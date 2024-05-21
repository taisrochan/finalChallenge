//
//  RequisitionsScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI

struct RequisitionScreen: View {
    let notifications = [
        Notification(date: "Hoje", content: "Você tem uma nova mensagem."),
        Notification(date: "Hoje", content: "Você tem um novo convite."),
        Notification(date: "Ontem", content: "Seu pedido foi aprovado."),
        Notification(date: "Ontem", content: "Você tem uma nova tarefa."),
    ]
    
    var body: some View {
        if notifications.isEmpty {
            Text("Você não possui notificações")
                .font(.headline)
                .foregroundColor(.gray)
                .padding()
        } else {
            List {
//                            ForEach(notifications.grouped(by: \.date)) { section in
//                                Section(header: Text(section.key)) {
//                                    ForEach(section.value) { notification in
//                                        Text(notification.content)
                                    }
                                }
                            }
                        }
                

struct RequisitionExemple: View {
    var body: some View {
        NavigationView {
            RequisitionScreen()
                .navigationBarTitle("Notificações")
        }
    }
}

struct RequisitionScreen_Previews: PreviewProvider {
    static var previews: some View {
        RequisitionScreen()
    }
}

// Model for Notification
struct Notification: Identifiable, Comparable, Hashable {
    let id = UUID()
    let date: String
    let content: String
    
    static func < (lhs: Notification, rhs: Notification) -> Bool {
           lhs.date < rhs.date
       }
   }


// Extension to group notifications by date
extension Array where Element: Comparable {
    func grouped<T: Hashable & Comparable>(by keyPath: KeyPath<Element, T>) -> [(key: T, value: [Element])] {
        Dictionary(grouping: self, by: { $0[keyPath: keyPath] })
            .map { ($0, $1) }
            .sorted { $0.0 < $1.0 }
    }
}

