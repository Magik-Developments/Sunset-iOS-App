//
//  LandingView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 14/3/24.
//

import SwiftUI

struct LandingView: View {
    //TODO: Implement landing
    @Environment(SunsetAppViewModel.self) var appViewModel

    var body: some View {
        Button{
            appViewModel.logOutUser()
        }label: {
            Text("Log Out").padding(8)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    LandingView()
}
