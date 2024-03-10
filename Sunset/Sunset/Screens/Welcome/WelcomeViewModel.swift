//
//  WelcomeViewModel.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 4/3/24.
//

import SwiftUI


final class WelcomeViewModel: ObservableObject {

    @Published var isMailSheetPresented: Bool = false
    
    //MARK: Login / Signup form variables
    @Published var isLoginForm: Bool = true
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var isToggleOn: Bool = false

    @Published var isEmailValid: Bool? = nil
    @Published var isPasswordValid: Bool? = nil
    @Published var isUsernameValid: Bool? = nil


    @Published var alertItem: AlertItem?
    @Published var textFieldInfoAlertIsPresented: Bool = false

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
}
