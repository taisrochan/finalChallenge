//
//  RequisitionsScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI

struct RequisitionView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: RequisitionsViewModel
    @State private var selectedRequest: MentorRequestModel?
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                } else {
                    
                    if viewModel.requests.isEmpty {
                        Text("Nenhuma requisição encontrada")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                    } else {
                        List(viewModel.requests, id: \.date) { request in
                            if request.status == MentoringStatus.requested.rawValue {
                                Button(action: {
                                    selectedRequest = request
                                }) {
                                    RequisitionRowView(request: request)
                                }
                            } else {
                                RequisitionRowView(request: request)
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                return Alert(
                    title: Text("Oops..."),
                    message: Text("Não foi possível carregar as solicitações. Tente novamente mais tarde."),
                    dismissButton: .default(Text("Ok")) {
                        presentationMode.wrappedValue.dismiss()
                    })
            }
            .onAppear {
                viewModel.loadRequests()
            }
            .actionSheet(item: $selectedRequest) { request in
                ActionSheet(
                    title: Text("Deseja aceitar essa solicitação?"),
                    buttons: [
                        .default(Text("Aceitar")) {
                            viewModel.acceptRequest(request)
                        },
                        .destructive(Text("Rejeitar")) {
                            viewModel.rejectRequest(request)
                        },
                        .cancel(Text("Cancelar"))
                    ]
                )
            }
        }
        .navigationBarTitle("Solicitações", displayMode: .inline)
        
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
//
//struct RequisitionScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        RequisitionView(viewModel: RequisitionsViewModel())
//    }
//}
