//
//  HomeScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 15/05/24.
//

import SwiftUI

struct PowerUpListScreen: View {
    @StateObject private var viewModel = PowerUpListViewModel()
    
    @State private var selectedPowerUpOption: PowerUpStatus = .scheduled
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Text("PowerUps")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                        .padding(.leading, -177)
                    
                    Spacer().frame(height: 30)
                    
                    Picker(selection: $selectedPowerUpOption, label: Text("")) {
                        Text("Agendados").tag(PowerUpStatus.scheduled)
                        Text("Salvos").tag(PowerUpStatus.past)
                        Text("Sugeridos").tag(PowerUpStatus.suggested)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .onChange(of: selectedPowerUpOption) { _, newValue in
                        viewModel.loadPowerUps(filterByStatus: newValue)
                    }
                    
                    Spacer().frame(height: 16)
                    
                    PowerUpListViewContent(viewModel: viewModel)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddTrainingView()) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 65, height: 65)
                                .foregroundColor(Color.ioasysGreen)
                                .padding()
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("Power Ups", displayMode: .inline)
            .tabItem {
                Image(systemName: "house.fill")
                Text("Início")
            }
            .onAppear {
                viewModel.loadPowerUps(filterByStatus: selectedPowerUpOption)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        PowerUpListScreen()
    }
}
