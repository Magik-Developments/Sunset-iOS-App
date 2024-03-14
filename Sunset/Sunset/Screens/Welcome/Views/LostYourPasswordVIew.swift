//
//  LostYourPasswordVIew.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 13/3/24.
//

import SwiftUI
import SimpleToast

struct LostYourPasswordVIew: View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    @Environment(SunsetAppViewModel.self) var appViewModel

    var body: some View {
        VStack {
            Image(.lighthouse)
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.vertical, 16)
            
            Spacer()

            Text(String(localized: "login.forgot.password"))
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineL)
                .foregroundStyle(.neutralTextBody)
                .multilineTextAlignment(.center)

            Text(String(localized: "forgot.password.description"))
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineS)
                .foregroundStyle(.neutralTextDisabled)
                .padding(.vertical, 8)

            DSTextField(valueTextField: $viewModel.email,
                        isFieldValid: $viewModel.isEmailValid,
                        validator: .email,
                        textFieldTitle: "common.email",
                        isSecure: false)
                .padding(8)
            
            Spacer()

            DSButton(title: "common.send.link", buttonStyle: SunsetButtonStyles.primaryDefault, size: .medium) {
                if viewModel.isEmailValid ?? false {
                    Task {
                        await viewModel.sendLinkLostPassword()
                    }
                } else {
                    viewModel.isFieldsToastPresented.toggle()
                }
            }
            .padding(.bottom, 8)

            DSButton(title: "common.go.back", buttonStyle: SunsetButtonStyles.secondaryDark, size: .medium) {
                viewModel.isLostYourPasswordSheetPresented.toggle()
            }

        }
        .padding(.horizontal, 16)
        .simpleToast(isPresented: $viewModel.isFieldsToastPresented, options: appViewModel.toastOptions) {
            viewModel.areFieldsValidLabel()
        }
        .simpleToast(isPresented: $viewModel.isResetPasswordSentToastPresented, options: appViewModel.toastOptions) {
            viewModel.isEmailResetPasswordSent()
        }
    }
}

#Preview {
    LostYourPasswordVIew()
}
