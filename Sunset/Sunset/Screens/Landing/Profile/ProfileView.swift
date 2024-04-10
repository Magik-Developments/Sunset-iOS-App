//
//  ProfileView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 10/4/24.
//

import SwiftUI

struct ProfileView: View {
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
    ProfileView()
}
