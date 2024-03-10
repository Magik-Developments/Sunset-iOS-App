//
//  SplashScreen.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 3/3/24.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(SunsetAppViewModel.self) var viewModel
    @State private var scale = 1.25
    @State var showProgressView: Bool = false

    var body: some View {
        VStack(alignment: .center) {
            Image(.sun)
                .scaleEffect(scale)
                .onAppear {
                    withAnimation(.smooth) {
                        self.scale = 1.1
                    }
                }
                .task {
                    try? await Task.sleep(for: .seconds(1.5))
                    showProgressView = true
                    viewModel.isUserLoggedIn()
                    try? await Task.sleep(for: .seconds(0.5))
                    showProgressView = false
                }
            if showProgressView {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.primaryBackgroundLogin)
                    .padding(.top, 48)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
