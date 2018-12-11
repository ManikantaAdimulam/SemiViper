//
//  LoginInteractor.swift
//  Viper
//
//

import UIKit
import SwiftyJSON

///
class LoginInteractor: Interacting {

    // MARK: - Variables

    ///
    private let router: UserManagementRouter
    ///
    weak var view: LoginViewController?
    ///
    let notificationService: NotificationService
    
    // MARK: - Life Cycle Methods

    ///
    init(router: UserManagementRouter, notificationService: NotificationService) {

        self.router = router
        self.notificationService = notificationService
    }

    // MARK: - Other methods

    ///
    func requestAuthForNotification() {
        notificationService.notificationConfiguration()
    }

    /// Methods validates if the entered values are correct or not
    /// - Parameter loginFields: fields that are needed to be validated
    /// - Returns: true -> valid, false -> invalid
    func validate(loginFields: [String: Any]) -> Bool {

        let loginFields = JSON(loginFields)

        // Email address
        let emailValidation = Validator.validate(email: loginFields["email"].stringValue, customName: "Email")
        guard emailValidation.isValid else {
            view?.showOkAlert(message: emailValidation.message ?? "")
            return false
        }

        // Password
        let passwordValidation = Validator.validate(password: loginFields["password"].stringValue, customPassword: "Password")
        guard passwordValidation.isValid else {
            view?.showOkAlert(message: passwordValidation.message ?? "")
            return false
        }

        return true
    }

    /// MARK: - Navigation methods

    ///
    func navigateToSignUp() {
        router.navigateToSignUp()
    }

    ///
    func navigateToForgotPassword() {
         router.navigateToForgotPassword()
    }
    
}
