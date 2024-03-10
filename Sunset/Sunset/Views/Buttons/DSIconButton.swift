//
//  DSIconButton.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct DSIconButton: View {

    var backgroundIconColor: ColorResource
    var imageResource: ImageResource
    var imageColor: ColorResource
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack(alignment: .center) {
                Circle()
                    .foregroundStyle(Color(backgroundIconColor))

                Image(imageResource)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color(imageColor))
                    .frame(width: 40, height: 40)
            }
            .frame(width: 80, height: 80)
        })
        .shadow(color: .gray, radius: 4)
    }
}

#Preview {
    DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                 imageResource: .envelopeFill,
                 imageColor: .neutralBackgroundDefault, action: {
        
    })
}
