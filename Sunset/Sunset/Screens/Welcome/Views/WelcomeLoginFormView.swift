//
//  WelcomeLoginFormView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

struct WelcomeLoginFormView: View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    
    //TO MOVE TO VM.
    @State var email: String = ""
    @State var password: String = ""
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    //TO MOVE TO VM.

    var body: some View {
        VStack {
            Text("common.login")
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineL)

            RoundedRectangle(cornerRadius: 180)
                .stroke(isEmailFocused ? .primaryBackgroundLogin : .neutralBorderDefault, lineWidth: 2)
                .fill(.neutralBackgroundDefault)
                .frame(width: 340, height: 50)
                .overlay {
                    TextField("common.email", text: $email)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.neutralTextBody)
                        .font(secondaryTextFieldFont(secondaryFont: .secondaryRegular, size: 18))
                        .padding(16)
                        .textInputAutocapitalization(.never)
                        .focused($isEmailFocused)
                }

            RoundedRectangle(cornerRadius: 180)
                .stroke(isPasswordFocused ? .primaryBackgroundLogin : .neutralBorderDefault, lineWidth: 2)
                .fill(.neutralBackgroundDefault)
                .frame(width: 340, height: 50)
                .overlay {
                    SecureField("common.password", text: $password)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.neutralTextBody)
                        .font(secondaryTextFieldFont(secondaryFont: .secondaryRegular, size: 18))
                        .padding(16)
                        .textInputAutocapitalization(.never)
                        .focused($isPasswordFocused)
                }

            DSButton(title: "common.login", buttonStyle: SunsetButtonStyles.primaryDefault, size: .large) {
                //TODO: Validate fields.
            }
            .padding(.top, 16)
        }
        .tint(.primaryBackgroundLogin)
    }
}

func secondaryTextFieldFont(secondaryFont: SunsetFontsSecondary, size: CGFloat) -> Font {
    Font.custom(secondaryFont.rawValue, size: size)
}

#Preview {
    WelcomeLoginFormView()
}
