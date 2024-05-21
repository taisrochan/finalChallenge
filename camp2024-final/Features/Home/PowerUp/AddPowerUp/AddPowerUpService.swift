//
//  AddPowerUpService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import Foundation

class AddPowerUpService {
    
    private let userDefaultsKey = "savedPowerUps"
    
    func createPowerUp(powerUp: AddPowerUpModel, completion: @escaping (Result<Void, Error>) -> Void) {
        var savedPowerUps = getSavedPowerUps()
        savedPowerUps.append(powerUp)
        
        if let data = try? JSONEncoder().encode(savedPowerUps) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            completion(.success(()))
        } else {
            completion(.failure(NSError(domain: "SaveError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to save data."])))
        }
    }
    
 func getSavedPowerUps() -> [AddPowerUpModel] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let powerUps = try? JSONDecoder().decode([AddPowerUpModel].self, from: data) else {
            return []
        }
        return powerUps
    }
}

