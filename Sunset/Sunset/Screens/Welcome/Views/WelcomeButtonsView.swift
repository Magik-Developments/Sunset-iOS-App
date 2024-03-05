//
//  WelcomeButtonsView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

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

