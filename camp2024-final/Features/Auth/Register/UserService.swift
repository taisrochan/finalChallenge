//
//  UserService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

class UserService {
    func updateUser(code: String, name: String, email: String, area: String, completion: @escaping (Result<Bool, Error>)->Void) {
        guard let url = URL(string: "https://powerup-back.azurewebsites.net/api/usuarios/\(code)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        let body: [String: Any] = [
            "nome": name,
            "email": email,
            "area": area
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion(.failure(URLError(.dataNotAllowed)))
            return
        }
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(true))
            
        }
        
        task.resume()
    }
}
