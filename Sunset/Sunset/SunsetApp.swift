//
//  SunsetApp.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 2/2/24.
//

import SwiftUI

@main
struct SunsetApp: App {

    @State var viewModel = SunsetAppViewModel()

    @State var lastState: AppState = .splash
    @State var networkStatus = NetworkStatus()

    var body: some Scene {
        WindowGroup {
            SunsetAppStateView()
                .environment(viewModel)
        }
    }
}
