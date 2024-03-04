//
//  SunsetAppStateView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct SunsetAppStateView: View {

    @Environment(SunsetAppViewModel.self) var viewModel

    @State var lastState: AppState = .splash
    @State var networkStatus = NetworkStatus()

    var body: some View {
        Group {
            switch viewModel.appState {
            case .splash: SplashScreen()
            case .welcome: 
                WelcomeView()
                    .environmentObject(WelcomeViewModel())
            }
        }
    }
}
