//
//  MenteesScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI
struct MenteesListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: MenteesListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5, anchor: .center)
                } else {
                    
                    if viewModel.mentees.isEmpty {
                        Text("Você não tem nenhum mentorado")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .multilineTextAlignment(.center)
                    } else {
                        List(viewModel.mentees, id: \.self) { mentee in
                            Text(getFirstTwoNames(from: mentee.name))
                                .font(.subheadline)
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
                viewModel.loadMentees()
            }
        }.navigationBarTitle("Meus mentorados", displayMode: .inline)
    }
    
    
}


struct MenteeScren_Previews: PreviewProvider {
    static var previews: some View {
        MenteesListView(viewModel: MenteesListViewModel())
    }
}

