//
//  TabBarView.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 15/05/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case people
        case profile
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PowerUpListScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("PowerUp")
                }
                .tag(Tab.home)
            
            MentorshipHomeScreen()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Mentorias")
                }
                .tag(Tab.people)
            
            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
                .tag(Tab.profile)
        }
        .edgesIgnoringSafeArea(.bottom)
        .accentColor(Color.ioasysGreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
