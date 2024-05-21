//
//  SplashScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 14/05/24.
//
import SwiftUI

struct SplashScreenView: View {
    @State private var displayedText = ""
    let text = "ioasys"
    @State private var shouldNavigateToLogin = false
    @EnvironmentObject private var appRootManager: AppRootManager
    
    var body: some View {
        //        NavigationView {
        VStack {
            Spacer()
            Text(displayedText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
        .onAppear {
            animateText()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func animateText() {
        var index = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            guard index < text.count else {
                timer.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring()) {
                        if UserSessionManager.shared.loadUser() == nil {
                            appRootManager.currentRoot = .login
                        } else {
                            appRootManager.currentRoot = .home
                        }
                    }
                        
                }
                return
            }
            displayedText += String(text[text.index(text.startIndex, offsetBy: index)])
            index += 1
        }
        timer.fire()
    }
}


struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
