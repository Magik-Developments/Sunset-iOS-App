//
//  DSButton.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 4/2/24.
//

import SwiftUI

struct DSButton: View {
    var title: String
    var buttonStyle: SunsetStyle
    var icon: ImageResource?
    var size: ButtonSize
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 8, content: {
                if let icon {
                    Image(icon)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(buttonStyle.FontColor)
                        .frame(width: 30, height: 30)
                }
                Text(title)
                    .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineS)
                    .foregroundStyle(buttonStyle.FontColor)
                    .textCase(.uppercase)


            })
            .frame(width: size.rawValue, height: 50)
        }
        .tint(buttonStyle.BackGroundColor)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .clipShape(.capsule)
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
            DSButton(title: "Press", buttonStyle: SunsetButtonStyles.primaryDefault, icon: .google, size: .large) {
                print("First button")
            }

            DSButton(title: "Press", buttonStyle: SunsetButtonStyles.secondaryWhite, size: .medium) {
                print("Second button")
            }
            DSButton(title: "Press", buttonStyle: SunsetButtonStyles.secondaryDark, icon: .facebookIcon ,size: .medium) {
                print("Third button")
            }
        }
    }

}
