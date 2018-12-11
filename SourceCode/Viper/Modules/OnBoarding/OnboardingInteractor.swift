//
//  OnboardingInteractor.swift
//

import UIKit

/// Implementation of OnboardingInteracting
class OnboardingInteractor: Interacting {

    // MARK: - Variable

    ///
    var view: OnboardingViewController?
    ///
    weak var router: OnboardingRouter?

    // MARK: - Life Cycle Methods

    /**
     Initialize the router with required dependencies

     - parameter storageService: The `StorageService` used by this application to
     store and retrieve stored data.
     */
    init(router: OnboardingRouter) {

        self.router = router
    }

    // MARK: - Navigation Methods

    ///
    func setInitialViewController() {
        router?.setInitialViewController()
    }
}
