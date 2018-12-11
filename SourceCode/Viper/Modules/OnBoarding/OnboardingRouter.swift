//
//  OnboardingRouter.swift
//

import UIKit

/// Implementation of OnboardingRouting
class OnboardingRouter {

    // MARK: - Variable

    ///
    private var mainRouter: MainRouter?

    ///
    lazy var interactor = OnboardingInteractor(router: self)

    // MARK: - Life cycle methods

    ///
    init(mainRouter: MainRouter? = nil) {

        self.mainRouter = mainRouter
    }

    ///
    func presentOnboarding(in window: UIWindow) {

        guard let vc = R.storyboard.onboarding.instantiateInitialViewController() else {
            fatalError("Unable to get OnboardingContainerViewController.")
        }
        vc.interactor = interactor
        vc.router = self
        window.rootViewController = vc
    }

    /// Finds the vc to be made root with the help of main router
    func setInitialViewController() {
        mainRouter?.setInitialViewController()
    }

}
