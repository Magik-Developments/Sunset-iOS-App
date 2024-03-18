//
//  CounterButton.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 18/3/24.
//

import SwiftUI

struct CounterButton: View {
    @Environment(SunsetAppViewModel.self) var appViewModel
    @EnvironmentObject var viewModel: EmailVerificationViewModel
    
    var body: some View {
        Button(action: {
            appViewModel.sendVerificationEmail()
            viewModel.isVerificationEmailSentToastPresented.toggle()
            viewModel.startTimer()
        }, label: {
            Text(viewModel.getCounterText())
                .sunsetFontPrimary(primaryFont: .primaryMedium, primarySize: .headlineXS)
                .tint(.primaryBackgroundDefault)
        })
        .disabled(!viewModel.isResendActive)
    }
}

#Preview {
    CounterButton().environmentObject(EmailVerificationViewModel()).environment(SunsetAppViewModel())
}
