//
//  camp2024_finalApp.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 14/05/24.
//

import SwiftUI

@main
struct camp2024_finalApp: App {
    @StateObject private var appRootManager = AppRootManager()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .splash:
                    SplashScreenView()
                    
                case .login:
                    LoginView()
                    
                case .home:
                    TabBarView()
                }
            }
            .environmentObject(appRootManager)
        }
    }
}
