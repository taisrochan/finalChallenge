//
//  LoginScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 14/05/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var validatorCode: String = "F8T6QD"
    @State private var isSecure: Bool = true
    @State private var isEditing: Bool = false
    @State private var navigationPath = NavigationPath()
    @FocusState private var codeIsFocused: Bool
    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color.green.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("ioasysLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 80)
                        .padding(.top, 16)
                    
                    Text("Seja bem vind@!")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 130)
                    
                    Spacer().frame(height: 70)
                    
                    HStack {
                        if isSecure {
                            SecureField(
                                "Insira aqui o código validador",
                                text: $validatorCode)
                            .focused($codeIsFocused)
                        } else {
                            TextField(
                                "Insira aqui o código validador",
                                text: $validatorCode)
                            .focused($codeIsFocused)
                        }
                        
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        isEditing = true
                    }
                    
                    Spacer().frame(height: 32)
                    
                    Button(action: {
                        codeIsFocused = false
                        viewModel.login(code: validatorCode)
                    }) {
                        Text("Entrar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                }
                .padding()
                
                if viewModel.isLoading {
                    Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5, anchor: .center)
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                isEditing = false
            }
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(title: Text("Erro"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(for: Destination.self) { destination in
                if case .completeRegistration(let userId) = destination {
                    RegisterView(userId: "\(userId)")
                }
            }
        }
        .onChange(of: viewModel.openNextScreen) {
            if viewModel.isLoading {
                return
            }
            if viewModel.navigateToCompleteRegistration {
                navigationPath.append(Destination.completeRegistration(userId: viewModel.userId))
            } else {
                withAnimation(.spring()) {
                    appRootManager.currentRoot = .home
                }
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
