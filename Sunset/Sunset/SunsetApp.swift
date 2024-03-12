//
//  SunsetApp.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 2/2/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SunsetApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
