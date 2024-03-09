//
//  WelcomeLoginFormView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

struct WelcomeLoginFormView: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {
        VStack {
            Text(viewModel.isLoginForm ? "common.login" : "common.signup")
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineL)

            SunsetWelcomeTextfields()

            if !viewModel.isLoginForm {
                SunsetConditionsToggle()
            }

            DSButton(title: viewModel.isLoginForm ? "common.login" : "common.signup",
                     buttonStyle: viewModel.isLoginForm ? SunsetButtonStyles.primaryDefault : SunsetButtonStyles.secondaryDark ,
                     size: .large) {
                //TODO: Validate fields.
            }
            .padding(.top, 16)

            if viewModel.isLoginForm {
                SunsetSignUpButton()
            }
        }
        .tint(.primaryBackgroundLogin)
    }
}

#Preview {
    WelcomeLoginFormView()
}

//MARK: Helper view to simplify organization.
struct SunsetWelcomeTextfields: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {

        DSTextField(valueTextField: $viewModel.email, textFieldTitle: "common.email", isSecure: false)

        DSTextField(valueTextField: $viewModel.password, textFieldTitle: "common.password", isSecure: false)

        if !viewModel.isLoginForm {
            DSTextField(valueTextField: $viewModel.username, textFieldTitle: "common.username", isSecure: false)
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
                 buttonStyle: SunsetButtonStyles.secondaryDark, size: .medium) {
            withAnimation {
                viewModel.isLoginForm.toggle()
            }
        }
    }
}
