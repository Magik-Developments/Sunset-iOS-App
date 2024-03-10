//
//  DSTextfieldValidators.swift
//  Sunset
//
//  Created by Faozi Bouybaouene on 10/3/24.
//

import Foundation

enum SunsetTextFieldValidator {
    case username
    case email
    case password
}

final class DSTextfieldValidators {

    //MARK: Username validator
    static func username(_ username: String) -> Bool {
        usernameLengthValidator(username: username) && usernameSpecialCharacterValidator(username: username)
    }

    static func usernameLengthValidator(username: String) -> Bool {
        username.count > 6
    }

    static func usernameSpecialCharacterValidator(username: String) -> Bool {
        let regex = #"^[a-zA-Z0-9_]+$"#
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: username)
    }

    //MARK: Email validator
    static func email(_ email: String) -> Bool {
        emailLengthValidator(email: email) && emailFormatValidator(email: email)
    }

    static func emailLengthValidator(email: String) -> Bool {
        return email.count > 0 // Minimum length requirement for an email
    }

    static func emailFormatValidator(email: String) -> Bool {
        let regex = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: email)
    }

    //MARK: Password validator
    static func password(_ password: String) -> Bool {
        passwordLengthValidator(password: password) && passwordCapitalLetterValidator(password: password)
    }

    static func passwordLengthValidator(password: String) -> Bool {
        return password.count >= 6 // Minimum length requirement for a password
    }

    static func passwordCapitalLetterValidator(password: String) -> Bool {
        let capitalLetterRegex = ".*[A-Z]+.*"
        let capitalLetterPredicate = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex)
        return capitalLetterPredicate.evaluate(with: password)
    }
}
