//
//  SplashScreen.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(SunsetAppViewModel.self) var viewModel
    @State private var scale = 1.0

    //TODO: Create Splash screen
    var body: some View {
        Text("Hello, Splash!")
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.smooth) {
                    self.scale = 1.25
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(1.5))
                viewModel.isUserLoggedIn()
                try? await Task.sleep(for: .seconds(0.5))
            }
    }
}

#Preview {
    SplashScreen()
}
