//
//  User.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 21/05/24.
//

import Foundation

import Foundation

struct User: Codable, Hashable, Equatable {
    let id: Int
    let name: String
    let area: String
    let email: String
    let activationCode: String
    let superpower: String
    let isMentorActive: Bool
    let mentor: String
    let isMenteeActive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case area
        case email
        case activationCode = "codigo_ativacao"
        case superpower = "superpoder"
        case isMentorActive = "flag_mentor_ativo"
        case mentor
        case isMenteeActive = "flag_mentorado_ativo"
    }
    
    static var mock: User = User(id: 0, name: "", area: "", email: "", activationCode: "", superpower: "", isMentorActive: false, mentor: "", isMenteeActive: false)
}
