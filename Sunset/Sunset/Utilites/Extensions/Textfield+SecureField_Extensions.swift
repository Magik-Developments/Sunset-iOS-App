//
//  Textfield+SecureField_Extensions.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 10/3/24.
//

import SwiftUI


func secondaryTextFieldFont(secondaryFont: SunsetFontsSecondary, size: CGFloat) -> Font {
    Font.custom(secondaryFont.rawValue, size: size)
}

extension TextField {
    func sunsetStyles() -> some View {
        self
            .textFieldStyle(.plain)
            .foregroundStyle(.neutralTextBody)
            .font(secondaryTextFieldFont(secondaryFont: .secondaryRegular, size: 18))
            .padding(16)
            .textInputAutocapitalization(.never)
    }
}

extension SecureField {
    func sunsetStyles() -> some View {
        self
            .textFieldStyle(.plain)
            .foregroundStyle(.neutralTextBody)
            .font(secondaryTextFieldFont(secondaryFont: .secondaryRegular, size: 18))
            .padding(16)
            .textInputAutocapitalization(.never)
    }
}
