//
//  WelcomeLoginFormView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

struct WelcomeLoginFormView: View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    @State var isLoginForm: Bool = true
    //TO MOVE TO VM.
    @State var email: String = ""
    @State var password: String = ""
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @State var isToggleOn: Bool = false
    //TO MOVE TO VM.

    var body: some View {
        VStack {
            Text(isLoginForm ? "common.login" : "common.signup")
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

            if !isLoginForm {
                ZStack {
                    RoundedRectangle(cornerRadius: 32)
                        .foregroundStyle(isToggleOn ? .green : .red)
                        .opacity(0.2)

                    DSToggle(text: "Condiciones vende tu alma bla bla bla bla bla balkbal te compramos todo bla bla bla bla vendelo todo queremos tus datos a mas no poder", isOn: $isToggleOn)
                        .padding(16)
                }
                .frame(maxWidth: 340, maxHeight: 100)
            }

            DSButton(title: isLoginForm ? "common.login" : "common.signup",
                     buttonStyle: isLoginForm ? SunsetButtonStyles.primaryDefault : SunsetButtonStyles.secondaryDark ,
                     size: .large) {
                //TODO: Validate fields.
            }
            .padding(.top, 16)

            if isLoginForm {
                Text("signup.invite")
                    .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyL)
                    .padding(.horizontal, 8)
                    .padding(.top, 36)
                    .multilineTextAlignment(.center)

                DSButton(title: "common.signup",
                         buttonStyle: SunsetButtonStyles.secondaryDark, size: .medium) {
                    withAnimation {
                        isLoginForm.toggle()
                    }
                }
            }
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
