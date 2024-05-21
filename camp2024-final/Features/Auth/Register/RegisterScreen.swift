//
//  SignUpScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 14/05/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var area: String = ""
    @State private var selectedArea: CompanyAreas? = nil
    @EnvironmentObject private var appRootManager: AppRootManager
    
    init(userId: String) {
        _viewModel = StateObject(wrappedValue: RegisterViewModel(service: UserService(), userId: userId))
    }
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Text("Preencha seus dados")
                        .font(.headline)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 300)
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 200)
                        .foregroundColor(Color.ioasysGreen)
                }
                
                VStack(spacing: 20) {
                    TextField("Nome", text: $viewModel.userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    TextField("Email", text: $viewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        .keyboardType(.emailAddress)
                    
                    HStack {
                        Text("Área:")
                            .padding(.leading, 0)
                            .foregroundColor(.gray)
                        
                        Picker("Selecione a área", selection: $viewModel.selectedArea) {
                            Text("Selecione a área")
                            ForEach(CompanyAreas.allCases, id: \.self) { area in
                                Text(area.rawValue).tag(area.rawValue)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(.leading, 0)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        viewModel.updateUser()
                    }) {
                        Text("Salvar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                            .background(Color.ioasysGreen)
                            .cornerRadius(20)
                    }
                    .padding(.bottom, 20)
                    Spacer().frame(height: 30)
                }
                .padding(.horizontal)
                
                
            }
            if viewModel.isLoading {
                Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5, anchor: .center)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oops..."),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .onChange(of: viewModel.openNextScreen) {
            appRootManager.currentRoot = .home
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(userId: "01")
    }
}
