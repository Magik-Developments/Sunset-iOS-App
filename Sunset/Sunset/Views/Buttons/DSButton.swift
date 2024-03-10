//
//  DSButton.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 4/2/24.
//

import SwiftUI

struct DSButton: View {
    var title: String.LocalizationValue
    var buttonStyle: SunsetStyle
    var size: ButtonSize
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 8, content: {
                Text(String(localized: title))
                    .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineS)
                    .foregroundStyle(buttonStyle.FontColor)
                    .textCase(.uppercase)
            })
            .frame(width: size.rawValue, height: 40)
        }
        .tint(buttonStyle.BackGroundColor)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .clipShape(.capsule)
        .shadow(color: .gray, radius: 4)
    }
}

enum ButtonSize: CGFloat {
    case large = 320
    case medium = 150
}

struct SunsetStyle {
    var FontColor: Color
    var BackGroundColor: Color
    var BorderColor: Color
}

struct SunsetButtonStyles {
    static let primaryDefault = SunsetStyle(FontColor: Color(.neutralBackgroundDefault),
                                            BackGroundColor: Color(.primaryBackgroundDefault),
                                            BorderColor: Color(.primaryBackgroundDefault))

    static let secondaryWhite = SunsetStyle(FontColor: Color(.neutralTextTitle),
                                            BackGroundColor: Color(.neutralBackgroundDefault),
                                            BorderColor: Color(.neutralTextTitle))

    static let secondaryDark = SunsetStyle(FontColor: Color(.neutralBackgroundDefault),
                                           BackGroundColor: Color(.neutralTextTitle),
                                           BorderColor: Color(.neutralTextTitle))
}

#Preview {
    ZStack {
        LinearGradient(colors: [Color(.primaryBackgroundLogin), Color(UIColor.systemBackground)],
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
        .ignoresSafeArea()
        .opacity(0.5)

        VStack {
            Spacer()
            DSButton(title: "Press", buttonStyle: SunsetButtonStyles.primaryDefault, size: .large) {
                print("First button")
            }

            DSButton(title: "Press", buttonStyle: SunsetButtonStyles.secondaryWhite, size: .medium) {
                print("Second button")
            }
            DSButton(title: "Press", buttonStyle: SunsetButtonStyles.secondaryDark ,size: .medium) {
                print("Third button")
            }
        }
    }

}
