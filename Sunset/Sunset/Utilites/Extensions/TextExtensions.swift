//
//  TextExtensions.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/2/24.
//

import SwiftUI

extension Text {
    func sunsetFontPrimary(primaryFont: SunsetFontsPrimary,
                           primarySize: SunsetFontSizePrimary) -> some View {
        self
            .font(.custom(primaryFont.rawValue, size: primarySize.rawValue))
    }

    func sunsetFontSecondary(secondaryFont: SunsetFontsSecondary, 
                             secondarySize: SunsetFontSizeSecondary) -> some View {
        self
            .font(.custom(secondaryFont.rawValue, size: secondarySize.rawValue))
    }
}
