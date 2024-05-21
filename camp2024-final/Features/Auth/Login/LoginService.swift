//
//  LoginService.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import Foundation

class LoginService {
    func login(code: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://powerup-back.azurewebsites.net/api/usuarios/\(code)") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
            
            guard let data = data else {
                completion(.failure(URLError(.cannotDecodeContentData)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let usuario = try decoder.decode(User.self, from: data)
                completion(.success(usuario))
            } catch {
                completion(.failure(AuthError()))
            }
        }
        
        task.resume()
    }
}


class AuthError: NSError {
}
