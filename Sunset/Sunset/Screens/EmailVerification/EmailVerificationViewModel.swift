//
//  EmailVerificationViewModel.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 14/3/24.
//

import SwiftUI
import FirebaseAuth

final class EmailVerificationViewModel: ObservableObject {
    
    @Published var counter = 30
    @Published var isResendActive = false
    @Published var timer: Timer?
    
    @Published var isVerificationEmailSentToastPresented: Bool = false

    func startTimer() {
        timer?.invalidate()
        counter = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] _ in
            if counter > 0 {
                counter -= 1
            } else {
                timer?.invalidate()
                isResendActive = true
            }
        }
    }

    func accessIfUserIsVerified(completion: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }

        user.reload { error in
            if let error = error {
                print("Error reloading user: \(error.localizedDescription)")
                // Handle the error appropriately, if needed
                completion(false)
            } else {
                let isVerified = user.isEmailVerified
                completion(isVerified)
            }
        }
    }

    func getCounterText() -> String {
        if isResendActive {
            return String(localized: "verification.resend")
        } else {
            return "\(String(localized: "verification.resend")) (\(counter)s)"
        }
    }

    //MARK: - Toast -
    func isResendToastLabel() -> some View {
        Label("toast.email.verification.sent", systemImage: "paperplane.fill")
            .sunsetFontSecondary(secondaryFont: .secondaryRegular, secondarySize: .bodyM)
            .padding()
            .background(.successBackgroundDefault)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 32))
            .padding(.top)
    }
}
