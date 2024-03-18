//
//  EmailVerificationView.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 14/3/24.
//

import SwiftUI
import SimpleToast

struct EmailVerificationView: View {
    @Environment(SunsetAppViewModel.self) var appViewModel
    @EnvironmentObject var viewModel: EmailVerificationViewModel

    var body: some View {
        VStack {
            Image(.mountain)
                .resizable()
                .frame(width: 250, height: 250)
                .padding(.vertical, 16)

            Spacer()

            Text(String(localized: "verification.title"))
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineL)
                .foregroundStyle(.neutralTextBody)
                .multilineTextAlignment(.center)

            Text(String(localized: "verification.description"))
                .sunsetFontPrimary(primaryFont: .primaryBold, primarySize: .headlineS)
                .foregroundStyle(.neutralTextDisabled)
                .multilineTextAlignment(.center)
                .padding(.vertical, 8)

            Spacer()

            DSButton(title: "verification.ok", buttonStyle: SunsetButtonStyles.primaryDefault, size: .large) {
                viewModel.accessIfUserIsVerified { isUserVerified in
                    if isUserVerified {
                        withAnimation {
                            appViewModel.appState = .landing
                        }
                    } else {
                        //TODO: TOAST to tell user it is not verified, and click on resend.
                    }
                }
            }
            .padding(.bottom, 8)

            HStack {

                DSButton(title: "common.do.later", buttonStyle: SunsetButtonStyles.secondaryDark, size: .medium) {
                    withAnimation {
                        appViewModel.appState = .landing
                    }
                }

                Spacer()

                CounterButton()
            }
            .padding(.horizontal, 8)


            .padding(.vertical, 8)
        }
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.startTimer()
        }
        .onChange(of: viewModel.counter, { oldValue, newValue in
            print(newValue)
        })
        .simpleToast(isPresented: $viewModel.isVerificationEmailSentToastPresented, options: appViewModel.toastOptions) {
            viewModel.isResendToastLabel()
        }
    }
}

#Preview {
    EmailVerificationView().environmentObject(EmailVerificationViewModel()).environment(SunsetAppViewModel())
}
