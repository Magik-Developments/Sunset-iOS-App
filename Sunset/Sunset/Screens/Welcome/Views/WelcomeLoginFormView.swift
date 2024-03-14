//
//  WelcomeLoginFormView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI
import SimpleToast

struct WelcomeLoginFormView: View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    @Environment(SunsetAppViewModel.self) var appViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(viewModel.isLoginForm ? "common.login" : "common.signup")
                    .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineL)

                SunsetWelcomeTextfields()

                if !viewModel.isLoginForm {
                    SunsetConditionsToggle()
                }

                DSButton(title: viewModel.isLoginForm ? "common.login" : "common.signup",
                         buttonStyle: SunsetButtonStyles.primaryDefault ,
                         size: .large) {

                    if viewModel.isLoginForm {
                        //TODO: Validate email and password. and do login.
                    } else {
                        if viewModel.areSignUpFieldsValid() {
                            if viewModel.isToggleOn {
                                Task {
                                    let authResult = try await viewModel.createUser()
                                    guard let authResult else { return }
                                    appViewModel.sendVerificationEmail()
                                    viewModel.isUserCreatedToastPresented = true
                                    appViewModel.user = authResult.user
                                }
                            } else {
                                viewModel.isToggleToastPresented = true
                            }
                        } else {
                            viewModel.isFieldsToastPresented = true
                        }
                    }
                }
                         .padding(.top, 16)

                if !viewModel.isLoginForm {
                    DSButton(title: "common.go.back", buttonStyle: SunsetButtonStyles.secondaryDark, size: .medium) {
                        withAnimation {
                            viewModel.isLoginForm.toggle()
                        }
                    }
                    .padding(.bottom, 8)
                }

                if viewModel.isLoginForm {
                    SunsetLostYourPasswordButton()
                        .padding(.top, 16)

                    SunsetSignUpButton()
                }
            }
            .tint(.primaryBackgroundLogin)
        }
        .padding(.top, 16)
        .scrollIndicators(.automatic)
        .alert(viewModel.alertItem?.title ?? Text(""),
               isPresented: $viewModel.firebaseErrorAlertIsPresented) {
            //NO ACTIONS NEEDED
        } message: {
            viewModel.alertItem?.message
        }
        .simpleToast(isPresented: $viewModel.isToggleToastPresented, options: appViewModel.toastOptions) {
            viewModel.isToggleOnToastLabel()
        }
        .simpleToast(isPresented: $viewModel.isFieldsToastPresented, options: appViewModel.toastOptions) {
            viewModel.areFieldsValidLabel()
        }
        .simpleToast(isPresented: $viewModel.isUserCreatedToastPresented, options: appViewModel.toastOptions) {
            viewModel.successUserCreatedLabel()
        }
        .sheet(isPresented: $viewModel.isLostYourPasswordSheetPresented, content: {
            LostYourPasswordVIew()
        })
    }
}

#Preview {
    WelcomeLoginFormView()
}

//MARK: Helper view to simplify organization.
struct SunsetWelcomeTextfields: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {

        DSTextField(valueTextField: $viewModel.email, 
                    isFieldValid: $viewModel.isEmailValid,
                    validator: .email,
                    textFieldTitle: "common.email",
                    isSecure: false)

        DSTextField(valueTextField: $viewModel.password, 
                    isFieldValid: $viewModel.isPasswordValid,
                    validator: .password,
                    textFieldTitle: "common.password",
                    isSecure: true)

        if !viewModel.isLoginForm {
            DSTextField(valueTextField: $viewModel.username, 
                        isFieldValid: $viewModel.isUsernameValid,
                        validator: .username,
                        textFieldTitle: "common.username",
                        isSecure: false)
        }
    }
}

struct SunsetConditionsToggle: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .foregroundStyle(viewModel.isToggleOn ? .green : .red)
                .opacity(0.2)

            DSToggle(text: "common.conditions", isOn: $viewModel.isToggleOn)
                .padding(16)
        }
        .frame(maxWidth: 340, maxHeight: 100)
    }
}

struct SunsetSignUpButton: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {
        Text("signup.invite")
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyL)
            .padding(.horizontal, 8)
            .padding(.top, 36)
            .multilineTextAlignment(.center)

        DSButton(title: "common.signup",
                 buttonStyle: viewModel.isLoginForm ? SunsetButtonStyles.secondaryDark : SunsetButtonStyles.primaryDefault,
                 size: .medium) {
            withAnimation {
                viewModel.isLoginForm.toggle()
            }
        }
    }
}

struct SunsetLostYourPasswordButton: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {
        Button {
            viewModel.isLostYourPasswordSheetPresented.toggle()
        } label: {
            Text(String(localized: "login.forgot.password"))
                .sunsetFontSecondary(secondaryFont: .secondarySemiBold, secondarySize: .bodyM)
                .foregroundStyle(.neutralTextBody)
        }
    }
}
