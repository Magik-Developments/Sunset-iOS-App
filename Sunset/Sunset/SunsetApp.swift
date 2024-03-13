//
//  SunsetApp.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 2/2/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
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
