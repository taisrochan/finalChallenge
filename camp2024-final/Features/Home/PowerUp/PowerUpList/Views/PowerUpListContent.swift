//
//  PowerUpListContent.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 20/05/24.
//

import SwiftUI

struct PowerUpListViewContent: View {
    @ObservedObject var viewModel: PowerUpListViewModel
    
    var body: some View {
        if viewModel.powerUps.isEmpty {
            Text("Nenhum PowerUp Agendado")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List(viewModel.powerUps) { powerUp in
                HStack {
                    VStack(alignment: .leading) {
                        Text(powerUp.titulo)
                            .font(.headline)
                        Text("\(viewModel.formattedDate(from: powerUp.data)) - \(powerUp.duracao) min")
                            .font(.subheadline)
                    }
                    Spacer()
                    let link = powerUp.link_reuniao ?? powerUp.link_gravacao ?? ""
                    let formattedLink = viewModel.addHTTPSIfNeeded(to: link)
                    if let url = URL(string: formattedLink) {
                        Link(destination: url) {
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
