//
//  DSToggle.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 9/3/24.
//

import SwiftUI

struct DSToggle: View {

    var text: String.LocalizationValue
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn, label: {
            Text(String(localized:text))
                .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyS)
        })
        .toggleStyle(SunsetToggleStyle())
    }
}

struct SunsetToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            Image(configuration.isOn ? .onToggle : .offToggle)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 51, height: 31, alignment: .center)
                .overlay {
                        Circle()
                            .foregroundColor(.white)
                            .padding(.all, 3)
                            .overlay {
                                Image(systemName:configuration.isOn ? "sun.max.fill" : "moon.zzz.fill")
                                    .foregroundStyle(configuration.isOn ? .primaryBackgroundLogin : .blue)
                                    .opacity(0.8)
                            }
                            .offset(x: configuration.isOn ? 11 : -11, y: 0)
                }
                .cornerRadius(20)
                .onTapGesture {
                    withAnimation( .linear(duration: 0.1)) {
                        configuration.isOn.toggle()
                    }
                }

        }
    }
}

#Preview {
    DSToggle(text: "common.conditions", isOn: .constant(true))
}
