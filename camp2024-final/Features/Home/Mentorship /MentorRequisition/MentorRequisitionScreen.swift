//
//  MentorRequisitionScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI

struct MentorRequisitionScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = MentorRequisitionViewModel(service: MentorRequisitionService())
    
    var userArea: String {
        UserSessionManager.shared.loadUser()?.area ?? "preferência"
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Escolha o seu mentor na área de \(userArea)")
                    .padding()
                    .font(Font.system(size: 24, weight: .semibold))
                
                if !viewModel.mentors.isEmpty {
                    HStack {
                        Picker("Mentor", selection: $viewModel.selectedMentor) {
                            ForEach(viewModel.mentors, id: \.self) { mentor in
                                Text(mentor.name).tag(mentor)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .frame(height: 36)
                    
                } else {
                    HStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                    }
                    .frame(alignment: .center)
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.sendRequest()
                }) {
                    Text("Enviar Pedido")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.ioasysGreen)
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
                .disabled(viewModel.selectedMentor == nil)
                .padding(.bottom)
            }
            .padding()
            .alert(isPresented: $viewModel.showAlert) {
                switch viewModel.alertType {
                case .mentorsLoadFailure:
                    return Alert(title: Text("Erro"), message: Text("Falha ao carregar mentores"), dismissButton: .default(Text("OK")))
                case .sendRequestFailure:
                    return Alert(title: Text("Erro"), message: Text("Falha ao enviar pedido"), dismissButton: .default(Text("OK")))
                case .requestSended:
                    return Alert(title: Text("Sucesso"), message: Text("Pedido enviado com sucesso"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct MentorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MentorRequisitionScreen()
    }
}
