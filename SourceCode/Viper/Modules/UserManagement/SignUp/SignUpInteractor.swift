//
//  SignUpInteractor.swift
//
//

import UIKit
import SwiftyJSON

/// Implementation of RegisterInteracting
class SignUpInteractor: Interacting {

    // MARK: - Variables

    ///
    weak var view: SignUpViewController?

    // MARK: - Life cycle methods

    ///
    init() {

    }

    // MARK: - Other methods

    /// Methods validates if the entered values are correct or not
    /// - Parameter loginFields: fields that are needed to be validated
    /// - Returns: true -> valid, false -> invalid
    func validate(registerFields: [String: Any]) -> Bool {

        let registerFields = JSON(registerFields)

        // First Name
        let firstNameValidation = Validator.validate(name: registerFields["firstName"].stringValue, customName: "first name")
        guard firstNameValidation.isValid else {
            view?.showOkAlert(message: firstNameValidation.message ?? "")
            return false
        }

        // Last Name
        let lastNameValidation = Validator.validate(name: registerFields["lastName"].stringValue, customName: "last name")
        guard lastNameValidation.isValid else {
            view?.showOkAlert(message: lastNameValidation.message ?? "")
            return false
        }

        // Email address
        let emailValidation = Validator.validate(email: registerFields["email"].stringValue, customName: "Email")
        guard emailValidation.isValid else {
            view?.showOkAlert(message: emailValidation.message ?? "")
            return false
        }

        // Password
        let passwordValidation = Validator.validate(password: registerFields["password"].stringValue, customPassword: "Password")
        guard passwordValidation.isValid else {
            view?.showOkAlert(message: passwordValidation.message ?? "")
            return false
        }

        return true
    }
}
