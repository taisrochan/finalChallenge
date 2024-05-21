//
//  MenteesScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI

struct MenteesScreen: View {
    // Lista de contatos
    let contacts = [
        Contact(name: "Tais Rocha Nogueira", email: "trochanogueira@ioasys.com"),
        Contact(name: "João Silva", email: "joaosilva@example.com"),
        Contact(name: "Maria Oliveira", email: "mariaoliveira@example.com"),
        Contact(name: "Carlos Pereira", email: "carlospereira@example.com"),
        Contact(name: "Ana Souza", email: "anasouza@example.com"),

    ]

    var body: some View {
        NavigationView {
            List(contacts) { contact in
                VStack(alignment: .leading) {
                    Text(contact.name)
                        .font(.headline)
                    Text(contact.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
            .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                VStack {
                                    Text("Lista de Mentorados")
                                        .font(.title)
                                        .bold()
                                }
                            }
                        }
                    }
                }
            }

struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let email: String
}

struct MenteeScren_Previews: PreviewProvider {
    static var previews: some View {
        MenteesScreen()
    }
}

