//
//  UserManagmentRouter.swift
//  Viper

import UIKit
import CocoaLumberjack

///
class UserManagementRouter {

    // MARK: - Variables

    ///
    private let networkService: NetworkService
    ///
    private let storageService: StorageService
    ///
    private let notificationService: NotificationService

    ///
    weak private var navigationController: UINavigationController?

    // MARK: - Life Cycle Method

    ///
    init(router: MainRouter, networkService: NetworkService, storageService: StorageService, notificationService: NotificationService) {
        self.networkService = networkService
        self.storageService = storageService
        self.notificationService = notificationService
    }

    // MARK: - Assemble Methods
    
    ///
    func assembleInitialScreen() -> UINavigationController? {

        navigationController = R.storyboard.userManagement.instantiateInitialViewController()
        let loginVC = assembleLoginScreen()
        navigationController?.setViewControllers([loginVC], animated: true)
        return navigationController
    }

    ///
    func assembleLoginScreen() -> UIViewController {

        guard let vc = R.storyboard.userManagement.loginViewController() else {
            DDLogError("Unable to get LoginViewController.")
            fatalError("Unable to get LoginViewController.")
        }

        let interactor = LoginInteractor(router: self, notificationService: notificationService)
        interactor.view = vc
        vc.interactor = interactor
        return vc
    }

    ///
    func assembleSignUpScreen() -> SignUpViewController {

        guard let vc = R.storyboard.userManagement.signUpViewController() else {
            DDLogError("Unable to get SignUpViewController.")
            fatalError("Unable to get SignUpViewController.")
        }

        let interactor = SignUpInteractor()
        interactor.view = vc
        vc.interactor = interactor
        return vc
    }

    ///
    func assembleForgotPasswordScreen() -> ForgetPasswordViewController {

        guard let vc = R.storyboard.userManagement.forgetPasswordViewController() else {
            DDLogError("Unable to get ForgetPasswordViewController.")
            fatalError("Unable to get ForgetPasswordViewController.")
        }

        let interactor = ForgetPasswordInteractor()
        interactor.view = vc
        vc.interactor = interactor
        return vc
    }

    // MARK: - Navigation methods

    ///
    func navigateToSignUp() {
        let signUpVC = assembleSignUpScreen()
        navigationController?.pushViewController(signUpVC, animated: true)
    }

    ///
    func navigateToForgotPassword() {
        let forgotPasswordVC = assembleForgotPasswordScreen()
        navigationController?.pushViewController(forgotPasswordVC, animated: true)
    }
}
