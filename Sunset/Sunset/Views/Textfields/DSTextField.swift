//
//  DSTextField.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 9/3/24.
//

import SwiftUI

struct DSTextField: View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    @FocusState var isTextFieldFocused: Bool
    @Binding var valueTextField: String
    var textFieldTitle: String.LocalizationValue
    var isSecure: Bool

    var body: some View {
        RoundedRectangle(cornerRadius: 180)
            .stroke(isTextFieldFocused ? .primaryBackgroundLogin : .neutralBorderDefault, lineWidth: 2)
            .fill(.neutralBackgroundDefault)
            .frame(width: 340, height: 50)
            .overlay {
                if !isSecure {
                    TextField(String(localized:textFieldTitle), text: $valueTextField)
                        .sunsetStyles()
                        .focused($isTextFieldFocused)

                } else {
                    SecureField(String(localized:textFieldTitle), text: $valueTextField)
                        .sunsetStyles()
                        .focused($isTextFieldFocused)
                }
            }
    }
}

