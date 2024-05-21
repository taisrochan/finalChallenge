//
//  LoginViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var openNextScreen = false
    @Published var showErrorAlert = false
    var errorMessage: String = ""
    var navigateToCompleteRegistration = false
    var userId = 0
    
    private let service = LoginService()
    private let userManagerSession = UserSessionManager.shared
    
    func login(code: String) {
        resetInfos()
        
        guard !code.isEmpty else {
            self.errorMessage = "Código não pode estar vazio."
            self.showErrorAlert = true
            return
        }
        
        self.isLoading = true
        
        let userId = convertCodeToUserId(code: code).asString()
        service.login(code: userId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let user):
                    if user.email == "" {
                        self?.navigateToCompleteRegistration = true
                        self?.userId = user.id
                    } else {
                        self?.userManagerSession.saveUser(user)
                    }
                    self?.openNextScreen = true
                case .failure(let error):
                    if error is AuthError {
                        self?.errorMessage = "Código inválido."
                    } else {
                        print("Erro: \(error.localizedDescription)")
                        self?.errorMessage = "Não foi possível realizar o login. Tente novamente mais tarde."
                    }
                    self?.showErrorAlert = true
                }
            }
        }
    }
    
    func resetInfos() {
        openNextScreen = false
        navigateToCompleteRegistration = false
        userId = 0
    }
}
