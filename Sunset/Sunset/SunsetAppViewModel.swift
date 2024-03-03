//
//  SunsetAppViewModel.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

@Observable
final class SunsetAppViewModel {

    var appState: AppState = .splash

    func isUserLoggedIn() {
        withAnimation(.smooth) {
            appState = .welcome
        }
    }
}
