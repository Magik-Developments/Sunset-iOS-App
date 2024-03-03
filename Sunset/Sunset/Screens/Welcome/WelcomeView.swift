//
//  WelcomeView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct WelcomeView: View {
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

                WelcomeButtonsView()
                    .padding(.bottom, 48)

                DSButton(title: "access.guest", buttonStyle: SunsetButtonStyles.secondaryWhite, size: .large) {
                    //TODO: Access as a guest.
                }

            }
        }
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
    }
}

struct WelcomeButtonsView : View {
    var body: some View {
        VStack {
            Text(String(localized: "access.title"))
                .sunsetFontPrimary(primaryFont: .primaryMedium, primarySize: .headlineM)

            HStack {
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .envelopeFill,
                             imageColor: .neutralBackgroundDefault) {
                    //TODO: Login Mail Flow
                }
//                Spacer()
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .googleIcon,
                             imageColor: .neutralBackgroundDefault) {
                    //TODO: Login Google
                }
//                Spacer()
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
