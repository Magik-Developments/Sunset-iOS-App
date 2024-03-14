//
//  WelcomeViewModel.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 4/3/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SimpleToast
import FirebaseStorage
import GoogleSignIn

@MainActor
final class WelcomeViewModel: ObservableObject {
    
    //MARK: - Sheet presentations variables
    @Published var isMailSheetPresented: Bool = false
    @Published var isLostYourPasswordSheetPresented: Bool = false

    //MARK: - Login / Signup form variables
    @Published var isLoginForm: Bool = true
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""

    @Published var isEmailValid: Bool? = nil
    @Published var isPasswordValid: Bool? = nil
    @Published var isUsernameValid: Bool? = nil

    @Published var isToggleOn: Bool = false
    
    //MARK: - Toast 
    @Published var isToggleToastPresented: Bool = false
    @Published var isFieldsToastPresented: Bool = false
    @Published var isUserCreatedToastPresented: Bool = false
    @Published var isResetPasswordSentToastPresented: Bool = false

    //MARK: - Alert variables.
    @Published var alertItem: AlertItem?
    @Published var textFieldInfoAlertIsPresented: Bool = false
    @Published var firebaseErrorAlertIsPresented: Bool = false


    func populateAlertItemTextfield(validator: SunsetTextFieldValidator) {
        switch validator {
        case .username:
            alertItem = AlertContext.customError(title: "username.validation.title", message: "username.validation.desc")
        case .email:
            alertItem = AlertContext.customError(title: "email.validation.title", message: "email.validation.desc")
        case .password:
            alertItem = AlertContext.customError(title: "password.validation.title", message: "password.validation.desc")
        }
    }

    //MARK: - Sign up via email - Create user
    func areSignUpFieldsValid() -> Bool {
        guard let isEmailValid, let isPasswordValid, let isUsernameValid else { return false }
        return isEmailValid && isPasswordValid && isUsernameValid
    }

    func createUser() async throws -> AuthDataResult? {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            try await storeUserFirestore()
            return authResult
        } catch {
            alertItem = AlertContext.customError(title: "error.title", message: "firebase.error.common")
            firebaseErrorAlertIsPresented = true
        }
        return nil
    }

    func storeUserFirestore() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MMM dd HH:mm:ss 'GMT'Z yyyy"
        let dateString = dateFormatter.string(from: Date())

        let db = Firestore.firestore()
        let userRef = db.collection("users").document(username.lowercased())
        let imageURL = try await getDefaultImageURL()
        let userData: [String: String] = [
            "creation_date": dateString,
            "email": email,
            "image": imageURL,
            "provider": "firebase",
            "username": username
        ]

        try await userRef.setData(userData)
    }

    func checkIfUserDontExistInFirestore() async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else {
            return false
        }

        let usersCollection = Firestore.firestore().collection("users")

        let querySnapshot = try await usersCollection.whereField("uid", isEqualTo: uid).getDocuments()

        return querySnapshot.documents.isEmpty
    }


    fileprivate func getFilePathForDefaultImage() -> String {
        "profile_images/default_images/\(String(describing: username.first!.lowercased())).png"
    }

    fileprivate func getDefaultImageURL() async throws -> String {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let fileRef = storageRef.child(getFilePathForDefaultImage())

        do {
            let url = try await fileRef.downloadURL()
            return url.absoluteString
        } catch {
            throw error
        }
    }

    //MARK: - Google SSO
    func loginWithGoogle(completion: @escaping (Bool, User?, Error?) -> Void) {
        var isLoginSuccessful = false
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(isLoginSuccessful, nil, nil)
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as?
                                              UIWindowScene)?.windows.first?.rootViewController else {
            completion(isLoginSuccessful, nil, nil)
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [unowned self] result, error in
            guard error == nil else {
                // No action needed, user canceling sign-in flow.
                completion(isLoginSuccessful, nil, error)
                return
            }

            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                alertItem = AlertContext.customError(title: "error.title", message: "firebase.error.common")
                completion(isLoginSuccessful, nil, nil)
                return
            }

            let authCredential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: authCredential) { result, error in
                isLoginSuccessful = error == nil
                completion(isLoginSuccessful, result?.user, error)
            }
        }
    }

    //MARK: - Forgot your passowrd?
    func sendLinkLostPassword() async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            isResetPasswordSentToastPresented.toggle()
        } catch {
            alertItem = AlertContext.customError(title: "error.title", message: "firebase.error.common")
            firebaseErrorAlertIsPresented = true
        }
    }

    //MARK: - Toast -
    func isToggleOnToastLabel() -> some View {
        Label("toast.toggle.on", systemImage: "xmark.octagon")
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyM)
            .padding()
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top)
    }

    func areFieldsValidLabel() -> some View {
        Label("toast.fields.valid", systemImage: "xmark.octagon")
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyM)
            .padding()
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top)
    }

    func successUserCreatedLabel() -> some View {
        Label("toast.user.created", systemImage: "person.badge.shield.checkmark.fill")
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyM)
            .padding()
            .background(.successBackgroundDefault)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top)
    }

    func isEmailResetPasswordSent() -> some View {
        Label("toast.email.reset.sent", systemImage: "paperplane.fill")
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyM)
            .padding()
            .background(.successBackgroundDefault)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top)
    }
}
