//
//  SunsetAppViewModel.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI
import FirebaseAuth
import SimpleToast

@Observable
final class SunsetAppViewModel {

    var appState: AppState = .splash
    var user: User?

    var toastOptions = SimpleToastOptions(
        alignment: .bottom,
        hideAfter: 4
    )

    //MARK: - User Actions
    func isUserLoggedIn() async {
        Auth.auth().addStateDidChangeListener { [self] auth, userFirebase in
            if (userFirebase != nil) {
                user = userFirebase
                if user?.isEmailVerified ?? true {
                    withAnimation(.smooth) {
                        appState = .landing
                    }
                } else {
                    withAnimation(.smooth) {
                        appState = .verificationEmail
                    }
                }
            } else {
                //user not logged in
                withAnimation(.smooth) {
                    appState = .welcome
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

    func sendVerificationEmail() {
        guard let user = Auth.auth().currentUser else { return }

        user.sendEmailVerification { error in
            if let error = error {
                print("Error sending verification email: \(error.localizedDescription)")
            } else {
                print("Verification email sent successfully.")
            }
        }
    }

}
