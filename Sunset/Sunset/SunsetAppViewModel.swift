//
//  SunsetAppViewModel.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI
import FirebaseAuth

@Observable
final class SunsetAppViewModel {

    var appState: AppState = .splash
    var user: User?

    func isUserLoggedIn() {
        withAnimation(.smooth) {
            appState = .welcome
        }
    }
}
