//
//  WelcomeButtonsView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 5/3/24.
//

import SwiftUI

struct WelcomeButtonsView : View {
    @Binding var isMailSheetPresented: Bool
    @EnvironmentObject var viewModel: WelcomeViewModel
    @Environment(SunsetAppViewModel.self) var appViewModel

    var body: some View {
        VStack {
            Text(String(localized: "access.title"))
                .sunsetFontPrimary(primaryFont: .primaryMedium, primarySize: .headlineM)

            HStack {
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .envelopeFill,
                             imageColor: .neutralBackgroundDefault) {
                    isMailSheetPresented = true
                }
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .googleIcon,
                             imageColor: .neutralBackgroundDefault) {
                    //TODO: Login Google
                    viewModel.loginWithGoogle { isLoginSusccessful, user, error in
                        guard error == nil else {return}
                        Task {
                            if try await viewModel.checkIfUserDontExistInFirestore() {
                                try await viewModel.storeUserFirestore()
                            }
                        }
                        
                        if isLoginSusccessful {
                            withAnimation {
                                appViewModel.appState = .landing
                            }
                        } 
                    }
                }
                DSIconButton(backgroundIconColor: .primaryBackgroundLogin,
                             imageResource: .appleLogo,
                             imageColor: .neutralBackgroundDefault) {
                    //TODO: Login SSO Apple id.

                }
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
        }
    }
}

