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
}
