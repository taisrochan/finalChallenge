//
//  RegisterViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var selectedArea: String = ""
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var openNextScreen = false
    
    private let service: UserService
    private let userId: String
    
    init(service: UserService, userId: String) {
        self.service = service
        self.userId = userId
    }
    
    func updateUser() {
        guard !userName.isEmpty, !email.isEmpty, !selectedArea.isEmpty else {
            alertMessage = "Por favor, preencha todos os campos."
            showAlert = true
            return
        }
        
        if !isValidEmail(email) {
            alertMessage = "E-mail inválido"
            showAlert = true
            return
        }
        
        isLoading = true
        
        service.updateUser(code: userId,
                           name: userName,
                           email: email,
                           area: selectedArea) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .failure:
                self.alertMessage = "Erro ao atualizar usuário. Tente novamente mais tarde."
                self.showAlert = true
            case .success:
                openNextScreen = true
                UserSessionManager.shared.saveUser(
                    User(id: Int(userId) ?? 0,
                         name: userName,
                         area: selectedArea,
                         email: email,
                         activationCode: "",
                         superpower: "",
                         isMentorActive: false,
                         mentor: "",
                         isMenteeActive: false)
                )
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
