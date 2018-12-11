//
//  MainRouter.swift
//  Viper
//

import UIKit

/// Implementation of MainRouting
final class MainRouter {

    // MARK: - Variables

    ///
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ///
    private let window: UIWindow
    /// Root view controller of the app
    private var rootVC: UIViewController? {
        return window.rootViewController
    }

    // MARK: Services

    ///
    private let storageService: StorageService
    ///
    private lazy var notificationService: NotificationService = NotificationService(router: self, launchOptions: launchOptions)
    ///
    private lazy var networkService: NetworkService = NetworkService(buildEnvirnment: .local, notificationService: notificationService)

    // MARK: - Life Cycle Methods

    /**
     Initialize the router with required dependencies

     - parameter window: The root window of the application
     */
    init(window: UIWindow, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {

        storageService = StorageService()
        self.window = window
        self.launchOptions = launchOptions
    }

    // MARK: - Navigaiton methods

    /// Call to determine and present the root view for this application. Currently that will be either the tabBar or the initial onboarding slideshow.
    func setInitialViewController() {

        // show the onboarding slideshow
        if storageService.getIfOnBoardingIsShown() == false {
            let onboardingRouter = OnboardingRouter(mainRouter: self)
            onboardingRouter.presentOnboarding(in: window)
            storageService.setOnBoarding(isShown: true)
        } else {
            // Show other VC
            presentUserManagement()
        }
    }

    /// Set rootVC to user managment initial VC
    func presentUserManagement() {
        guard let vc = UserManagementRouter(router: self, networkService: networkService, storageService: storageService, notificationService: notificationService).assembleInitialScreen() else { return }
        window.rootViewController = vc
    }
}

// MARK: - CommonRoutingDelegate

///
extension MainRouter: CommonRoutingDelegate {

    /// Dismiss the presented view.
    /// Parameter type - is used to perform different action based on type. As its a common end point.
    func dismissViewController(ofType type: String) {
    }
}
