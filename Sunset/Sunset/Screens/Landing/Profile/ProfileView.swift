//
//  ProfileView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 10/4/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(SunsetAppViewModel.self) var appViewModel
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {

        VStack {
            HStack(spacing: 8) {
                AsyncImage(url: appViewModel.user?.photoURL) { image in
                    image
                        .resizable()
                        .frame(width: 125, height: 125)
                        .clipShape(Circle())

                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 125, height: 125)
                        .background(.gray)
                        .clipShape(Circle())
                }
                //TODO: Refactor
                Text(appViewModel.user != nil ? appViewModel.user?.displayName ?? "" : "no tas logueao prim")
                Spacer()
                
                Button{
                    appViewModel.logOutUser()
                }label: {
                    Text("Log Out").padding(8)
                }
                .buttonStyle(.borderedProminent)
            }
            Spacer()
        }.padding(32)
    }
}

