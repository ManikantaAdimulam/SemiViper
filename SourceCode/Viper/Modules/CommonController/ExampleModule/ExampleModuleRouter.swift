//
//  ExampleModuleRouter.swift
//

import UIKit

/// Implementation of ExampleModuleRouting
/**
 Routers are used for
 - Navigation: ViewControllers and Interactors should not be responsible for
 assembling other views.
 - Dependency Injection: The router assembles a module's views and interactors
 with the required dependencies as needed.

 In this example, we will assemble the ExampleModuleViewController 3 different ways,
 as an example of each. The Interactor will have 2 dependencies: StorageService for
 storage (we aren't doing anything with it, just an example) and the
 ExampleModuleRouter for navigation (when we close the view).

 In most cases, only 1 of these following functions will be needed for a given module but
 there are exceptions.

 NOTE: If the storyboard has a nav, the code in example 1 will not work as-is because
 the initialViewController for the storyboard will be the navigationController,
 not the ExampleModuleViewController. In that case, the code would look the same
 as the assembleScreenWithNav code until the return statement, which would be
 `return vc` instead of `return nav`

 1. `assembleScreen(storageService: StorageService) -> ExampleModuleViewController`
 - creates the ExampleModuleViewController from its storyboard
 - creates the required ExampleModuleInteractor, initializing it with its StorageService
 dependency
 - sets that ExampleModuleInteractor as the ViewController's interactor
 - returns the ViewController

 2. `assembleScreenWithNav(storageService: StorageService) -> UIViewController`
 is similar but returns the ExampleModuleViewController in
 its NavigationController. Other than the code to get the nav and the return statement,
 the code is almost identical to `assembleScreen`.

 3. `presentScreen(in window: UIWindow, storageService: StorageService)` is similar
 to both of the previous examples but instead of returning the assembled ViewController
 to be displayed, we present the ViewController as the root of the app. This is
 typically used to show the first view of an application  as the root view or to
 replace that root view with another (e.g. after logging in, if a log in view is
 shown when the app is launched).
 */
class ExampleModuleRouter {

    /**
     Call to assemble the ExampleModuleViewController

     `assembleScreen(storageService: StorageService) -> ExampleModuleViewController`
     creates the ExampleModuleViewController from its storyboard, creates the
     required ExampleModuleInteractor, initializing it with its StorageService
     dependency, sets that ExampleModuleInteractor as the ViewController's interactor
     and returns the ViewController

     - parameter storageService: implementation the app's shared StorageService

     - returns: ExampleModuleViewController with its required dependencies set
    */
    ///
    var networkService: NetworkService
    
    init(with NetworkServices: NetworkService) {
        self.networkService = NetworkServices
    }
    func assembleScreen() -> ExampleModuleViewController? {

        /**
         Q: What is `R.storyboard.exampleModule()`?
         A: R.swift is a cocoapod that "borrows" from the Android concept of an
         `R` file for resources. It compiles strongly-typed constants for Colors
         named in the Assets catalog, strings in localizable.strings, and storyboards.
         It runs during Xcode's build process, generating the file in Resources/R.generated.swift,
         and allows us to get storyboards using the "strongly-typed"
         `R.storyboard.exampleModule.instantiateInitialViewController`
         instead of the "stringly-typed"
         `UIStoryboard.init(name: "DebugOutputView", bundle: nil).instantiateInitialViewController as? ExampleModuleViewController`
         */
        guard let vc = R.storyboard.exampleModule.exampleModuleStoryboard() else {
            fatalError("Unable to get ExampleModuleViewController.")
        }

        let interactor = ExampleModuleInteractor(networkServices: networkService)
        vc.interactor = interactor

        return vc
    }
    
    func assembelTabBarController() -> UITabBarController? {
        guard let controller = R.storyboard.exampleModule.instantiateInitialViewController() else {  fatalError("Unable to get ExampleModuleViewController.") }
//        controller.selectedViewController = assembleScreen()
        guard let exampleVC = assembleScreen(), let anotherVC = controller.viewControllers?.last else { return nil }
        controller.setViewControllers([exampleVC, anotherVC], animated: false)
//        controller.viewControllers = [assembleScreen(), controller.viewControllers!.last] as? [UIViewController]
        controller.selectedIndex = 0
        return controller
    }
    
    /**
     Call to assemble the ExampleModuleViewController in its UINavigationController

     `assembleScreenWithNav(storageService: StorageService) -> UIViewController`
     creates the NavigationController from its storyboard, creates its root ViewController
     ExampleModuleViewController, creates the required ExampleModuleInteractor,
     initializing it with its StorageService dependency, sets that ExampleModuleInteractor
     as the ViewController's interactor and returns the NavigationController

     - parameter storageService: implementation the app's shared StorageService

     - returns: navigationController with ExampleModuleViewController root view
     with its required dependencies set
     */
    func assembleScreenWithNav() -> UIViewController {

        // NOTE: if this view doesn't have a navController, this code will fail
        // because it expects a navcontroller as the initial view
        guard let nav = R.storyboard.exampleModule.instantiateInitialViewController(),
            let vc = nav.children.first as? ExampleModuleViewController else {
                fatalError("Unable to get ExampleModuleViewController.")
        }

        let interactor = ExampleModuleInteractor(networkServices: networkService)
        vc.interactor = interactor

        return nav
    }

    /**
     Call to present the ExampleModuleViewController as the root view of the app.

     `presentScreen(in window: UIWindow, storageService: StorageService)` is similar
     to both of the previous examples but instead of returning the assembled ViewController
     to be displayed, we present the ViewController as the root of the app. This is
     typically used to show the first view of an application  as the root view or to
     replace that root view with another (e.g. after logging in, if a log in view is
     shown when the app is launched).

     - parameter window: the application's UIWindow
     */
    func presentScreen(in window: UIWindow) {

        // we'll assume there is no nav for this use case. If there is, the next line
        // of code would look like the code in `assembleScreenWithNav` above.
        guard let vc = R.storyboard.exampleModule.exampleModuleStoryboard() else {
            fatalError("Unable to get ExampleModuleViewController.")
        }

        let interactor = ExampleModuleInteractor(networkServices: networkService)
        vc.interactor = interactor

        window.rootViewController = vc
    }
}
