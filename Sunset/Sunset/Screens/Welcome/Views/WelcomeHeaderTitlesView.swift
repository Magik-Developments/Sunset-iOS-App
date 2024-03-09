//
//  WelcomeHeaderTitlesView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

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
