//
//  PowerUpStatus.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import Foundation

enum PowerUpStatus: Int {
    case scheduled
    case past
    case suggested
    
    var backendIdentifier: String {
        switch self {
        case .scheduled: return "agendamento"
        case .past: return "gravacao"
        case .suggested: return "suggested"
        }
    }
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
        case "salvar": self = .past
        case "sugerir": self = .suggested
        default: self = .scheduled
        }
    }
}
