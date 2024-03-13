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

    func isUserLoggedIn() async {
        Auth.auth().addStateDidChangeListener { auth, userFirebase in
            if (userFirebase != nil) {
                //user logged in
                self.user = userFirebase
                self.appState = .landing
            } else {
                //user not logged in
                withAnimation(.smooth) {
                    self.appState = .welcome
                }
            }
        }
    }

    func logOutUser() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withAnimation(.smooth) {
                appState = .welcome
            }
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }

}
