//
//  ForgetPasswordInteractor.swift
//
//

import UIKit
import SwiftyJSON

/// Implementation of ForgetPasswordInteracting
class ForgetPasswordInteractor: Interacting {

    // MARK: - Variables

    ///
    weak var view: ForgetPasswordViewController?

    // MARK: - Life cycle methods

    ///
    init() {

    }

    // MARK: - Other methods

    /// Methods validates if the entered values are correct or not
    /// - Parameter loginFields: fields that are needed to be validated
    /// - Returns: true -> valid, false -> invalid
    func validate(forgotPasswordFields: [String: Any]) -> Bool {

        let forgotPasswordFields = JSON(forgotPasswordFields)

        // Email address
        let emailValidation = Validator.validate(email: forgotPasswordFields["email"].stringValue, customName: "Email")
        guard emailValidation.isValid else {
            view?.showOkAlert(message: emailValidation.message ?? "")
            return false
        }
        return true
    }
}
