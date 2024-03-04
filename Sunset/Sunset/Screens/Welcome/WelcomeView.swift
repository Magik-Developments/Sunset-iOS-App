//
//  WelcomeView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: WelcomeViewModel

    var body: some View {
        ZStack {
            WelcomeBackgroundView()

            VStack {
                Image(.sun)
                    .resizable()
                    .frame(width: 220, height: 220)
                    .padding(.top, 16)
                Spacer()

                WelcomeHeaderTitlesView()

                Spacer()

                WelcomeButtonsView(isMailSheetPresented: $viewModel.isMailSheetPresented)
                    .padding(.bottom, 48)

                DSButton(title: "access.guest", buttonStyle: SunsetButtonStyles.secondaryWhite, size: .large) {
                    //TODO: Access as a guest.
                }

            }
        }
        .sheet(isPresented: $viewModel.isMailSheetPresented, content: {
            //TODO: Add access form login and also button to switch to signup.
            Text("Hello sheet")
                .presentationDetents([.fraction(0.6)])
                .presentationCornerRadius(75)
        })
    }
}

struct WelcomeBackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color(.primaryBackgroundLogin), Color(.neutralBackgroundDefault)],
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
        .ignoresSafeArea()
        .opacity(0.3)
    }
}

struct WelcomeHeaderTitlesView: View {
    var body: some View {
        Text(String(localized: "access.hello"))
            .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .displayM)
            .foregroundStyle(.neutralTextTitle)
            .multilineTextAlignment(.leading)

        Text(String(localized: "access.welcome.title"))
            .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .displayM)
            .foregroundStyle(.neutralTextTitle)

        Text(String(localized: "access.welcome.message"))
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyL)
            .multilineTextAlignment(.center)
            .padding(.top, 8)
    }
}

struct WelcomeButtonsView : View {
    @Binding var isMailSheetPresented: Bool

    var body: some View {
        VStack {
            Text(String(localized: "access.title"))
                .sunsetFontPrimary(primaryFont: .primaryMedium, primarySize: .headlineM)

            HStack {
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .envelopeFill,
                             imageColor: .neutralBackgroundDefault) {
                    isMailSheetPresented = true
                }
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .googleIcon,
                             imageColor: .neutralBackgroundDefault) {
                    //TODO: Login Google
                }
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .appleLogo,
                             imageColor: .neutralBackgroundDefault) {
                    //TODO: Login SSO Apple id.

                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    WelcomeView()
}
