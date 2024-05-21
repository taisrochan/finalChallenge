//
//  MentorshipHomeScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI

struct MentorshipHomeScreen: View {
    @StateObject private var viewModel = MentorshipHomeViewModel(service: MentorshipService())
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                Divider()
                
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("Deseja mentorar?")
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                        
                        if viewModel.isToggleDisabled {
                            createToggle(isDisable: true)
                        } else {
                            createToggle(isDisable: false)
                        }
                        
                    }
                    
                    Divider()
                    
                    NavigationLink(destination: MentorRequisitionScreen()) {
                        Text("Deseja ter um mentor?")
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.clear)
                            .cornerRadius(10)
                    }
                    
                    Divider()
                    
                    NavigationLink(
                        destination: RequisitionView(viewModel: RequisitionsViewModel())) {
                            Text("Solicitações")
                                .foregroundColor(.black)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(.clear)
                                .cornerRadius(10)
                        }
                    
                    Divider()
                    
                    NavigationLink(destination: MenteesScreen()) {
                        Text("Lista de Mentorados")
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(.clear)
                            .cornerRadius(10)
                    }
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .navigationBarTitle("Mentorias", displayMode: .large)
            .alert(isPresented: $viewModel.showAlert) {
                if viewModel.didFailMentoringStatusToggle {
                    let errorText = "Não foi possível atualizar seu estado de mentoria. Tente novamente mais tarde"
                    return Alert(title: Text("Oops..."),
                          message: Text(errorText),
                          dismissButton: .default(Text("OK")))
                } else {
                    return Alert(
                        title: Text("Confirmação"),
                        message: Text("Tem certeza que não deseja mais ser mentor?"),
                        primaryButton: .destructive(Text("Confirmar")) {
                            viewModel.confirmMentoringStatusChange(wantToBeAmentor: false)
                        },
                        secondaryButton: .cancel(Text("Cancelar")) {
                            viewModel.didPressCancel()
                        }
                    )
                }
            }
        }
    }
    
    func createToggle(isDisable: Bool) -> some View {
        return Toggle("", isOn: $viewModel.wantToBeAMentorStatus)
            .disabled(isDisable)
            .labelsHidden()
            .frame(width: 50)
            .scaleEffect(0.7)
            .onChange(of: viewModel.wantToBeAMentorStatus) { oldValue, value in
                if viewModel.canPostChanging {
                    viewModel.changeMentoringStatus(wantToBeAmentor: value)
                }
            }
    }
}
struct MentorshipHomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        MentorshipHomeScreen()
    }
}

