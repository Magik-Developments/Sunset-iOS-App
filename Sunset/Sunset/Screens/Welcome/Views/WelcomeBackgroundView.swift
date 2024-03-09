//
//  WelcomeBackgroundView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

struct WelcomeBackgroundView: View {
    var body: some View {
        LinearGradient(colors: [Color(.primaryBackgroundLogin), Color(.neutralBackgroundDefault)],
                       startPoint: .bottomLeading,
                       endPoint: .topTrailing)
        .ignoresSafeArea()
        .opacity(0.3)
    }
}
