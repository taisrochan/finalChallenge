//
//  AddPowerUpViewModel .swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import Foundation
import SwiftUI

class AddPowerUpViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var powerUps: [AddPowerUpModel] = []
    var didSucceed = false
    var errorMessage: String = ""
    
    private var addPowerUpService: AddPowerUpService
    
    init(addPowerUpService: AddPowerUpService = AddPowerUpService()) {
        self.addPowerUpService = addPowerUpService
    }
    
    func createPowerUp(
        area: String,
        titulo: String,
        descricao: String,
        data: Date,
        duracao: String,
        linkReuniao: String,
        status: PowerUpStatus
    ) {
        guard !area.isEmpty, !titulo.isEmpty, !descricao.isEmpty, !linkReuniao.isEmpty else {
            self.errorMessage = "Campos obrigatórios não preenchidos"
            self.didSucceed = false
            self.showAlert = true
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dataString = formatter.string(from: data)
        
        let duracaoInt: Int
        switch duracao {
        case "30 min":
            duracaoInt = 30
        case "1 hora":
            duracaoInt = 60
        default:
            duracaoInt = 0
        }
        
        let training = AddPowerUpModel(
            area: area,
            titulo: titulo,
            descricao: descricao,
            data: dataString,
            duracao: duracaoInt,
            link_reuniao: linkReuniao,
            link_gravacao: nil,
            id_status_treinamento: status.backendIdentifier
        )
        
        self.isLoading = true
        
        addPowerUpService.createPowerUp(powerUp: training) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.didSucceed = true
                    self?.showAlert = true
                case .failure(let error):
                    self?.didSucceed = false
                    self?.errorMessage = "Erro: \(error.localizedDescription)"
                    self?.showAlert = true
                }
            }
        }
    }
}

