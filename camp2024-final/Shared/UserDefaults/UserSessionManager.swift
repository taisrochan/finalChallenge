//
//  UserSessionManager.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class UserSessionManager {
    static let shared = UserSessionManager()
    
    private let userDefaults = UserDefaults.standard
    private let userKey = "currentUser"

    private init() {}
    
    var userId: Int {
        guard let data = userDefaults.data(forKey: userKey),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            fatalError("deve estar logado para acessar essa propriedade")
        }
        return user.id
    }
    
    func saveUser(_ user: User) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            userDefaults.set(data, forKey: userKey)
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func loadUser() -> User? {
        guard let data = userDefaults.data(forKey: userKey) else { return nil }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            print("Failed to load user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func clearUser() {
        userDefaults.removeObject(forKey: userKey)
    }
}
