//
//  WelcomeView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var viewModel: WelcomeViewModel
    @Environment(SunsetAppViewModel.self) var appViewModel

    var body: some View {
        ZStack {
            WelcomeBackgroundView()

            VStack(alignment: .center) {
                Image(.sun)
                    .resizable()
                    .frame(width: 220, height: 220)
                    .padding(.top, 16)
                Spacer()

                WelcomeHeaderTitlesView()

                Spacer()

                WelcomeButtonsView(isMailSheetPresented: $viewModel.isMailSheetPresented)
                    .padding(.bottom, 48)

                DSButton(title: "access.guest", buttonStyle: SunsetButtonStyles.secondaryWhite, size: .large) {
                    appViewModel.user = nil
                    withAnimation {
                        appViewModel.appState = .landing
                    }
                }

            }
        }
        .sheet(isPresented: $viewModel.isMailSheetPresented, content: {
            WelcomeLoginFormView()
                .presentationDetents([.fraction(0.6)])
                .presentationCornerRadius(75)
        })
    }
}


#Preview {
    WelcomeView()
}
