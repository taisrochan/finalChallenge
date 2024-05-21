//
//  PowerUpListViewModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import Foundation
import SwiftUI

class PowerUpListViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var powerUps: [AddPowerUpModel] = []
    var didSucceed = false
    var errorMessage: String = ""
    
    private var addPowerUpService: AddPowerUpService
    
    init(addPowerUpService: AddPowerUpService = AddPowerUpService()) {
        self.addPowerUpService = addPowerUpService
        loadPowerUps(filterByStatus: .scheduled)
    }
    
    func loadPowerUps(filterByStatus status: PowerUpStatus) {
        self.powerUps = addPowerUpService.getSavedPowerUps().filter({
            $0.id_status_treinamento == status.backendIdentifier
        })
    }
    
    func formattedDate(from dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
            guard let date = dateFormatter.date(from: dateString) else {
                return dateString
            }
            
            dateFormatter.dateFormat = "dd/MM/yyyy - HH'h'"
            return dateFormatter.string(from: date)
        }
    
    func addHTTPSIfNeeded(to link: String) -> String {
            if link.hasPrefix("http://") || link.hasPrefix("https://") {
                return link
            } else {
                return "https://\(link)"
            }
        }
    }

    
