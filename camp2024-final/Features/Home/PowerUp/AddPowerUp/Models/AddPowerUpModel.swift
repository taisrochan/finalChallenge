//
//  AddPowerUpModel.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import Foundation

struct AddPowerUpModel: Codable, Identifiable {
    var id: String = UUID.init().uuidString
    var id_usuario = "teste10"
    var tipo: String?
    var area: String
    var titulo: String
    var descricao: String?
    var data: String
    var duracao: Int
    var link_reuniao: String?
    var link_gravacao: String?
    var id_status_treinamento: String
    
    init(
         area: String,
         titulo: String,
         descricao: String?,
         data: String,
         duracao: Int,
         link_reuniao: String? = nil,
         link_gravacao: String? = nil,
         id_status_treinamento: String) {
        self.area = area
        self.titulo = titulo
        self.descricao = descricao
        self.data = data
        self.duracao = duracao
        self.link_reuniao = link_reuniao
        self.link_gravacao = link_gravacao
        self.id_status_treinamento = id_status_treinamento
    }
}
