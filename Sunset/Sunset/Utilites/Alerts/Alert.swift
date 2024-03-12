//
//  Alert.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 10/3/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: - Field validation Alerts
    static func customError(title: String.LocalizationValue, message: String.LocalizationValue) -> AlertItem {
        AlertItem(title: Text(String(localized: title)),
                  message: Text(String(localized: message)),
                  dismissButton: .default(Text("common.alert.gotit")))
    }
}
