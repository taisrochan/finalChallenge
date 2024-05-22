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
        ZStack {
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Escolha o seu mentor na área de \(userArea)")
                        .padding()
                        .font(Font.system(size: 24, weight: .semibold))
                    
                    if !viewModel.mentors.isEmpty {
                        HStack {
                            Picker("Mentor", selection: $viewModel.selectedMentor) {
                                ForEach(viewModel.mentors, id: \.self.name) { mentor in
                                    Text(mentor.name)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(height: 40)
                            .padding()
                            .frame(maxWidth: .infinity)
                        }
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                        
                    } else {
                        HStack {
                            Spacer()
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                            Spacer()
                        }
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
                            .background(viewModel.selectedMentor == "" ? Color.gray : Color.green)
                            .cornerRadius(20)
                            .padding(.horizontal)
                    }
                    .disabled(viewModel.selectedMentor == "")
                    .padding(.bottom)
                }
                .padding()
            }
            
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5, anchor: .center)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            switch viewModel.alertType {
            case .mentorsLoadFailure:
                return Alert(title: Text("Erro"), message: Text("Falha ao carregar mentores"), dismissButton: .default(Text("OK")))
            case .sendRequestFailure:
                return Alert(title: Text("Erro"), message: Text("Falha ao enviar pedido"), dismissButton: .default(Text("OK")))
            case .requestSended:
                return Alert(
                    title: Text("Sucesso!"),
                    message: Text("Seu pedido foi enviado. Aguarde até o mentor responde-lo"),
                    dismissButton: .default(Text("Ok")) {
                        presentationMode.wrappedValue.dismiss()
                    })
            }
        }
    }
}

struct MentorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MentorRequisitionScreen()
    }
}

