//
//  ExampleModuleInteractor.swift
//

import UIKit
import SwiftyJSON

/// An example implementation of the Interactor in a module using MVC + Interactor & Router

/**
 This module exists as an example that can be reused as views/screens/modules are
 added to the app.
 
 MVC is a view layer pattern and does not handle the services, routing,
 dependency injection, and other responsibilities required for a full application.
 
 The Interactor allows the VC to interact with services and navigation without
 those services or routing components being exposed to the VC. This means a more
 clear definition of each class's responsibility, less surface area for defects,
 easier testing, and fewer lines of duplicated code.
 
 The Interactors implement a base Interacting protocol. This allows us to do a bit
 of default wiring between the ViewController (via a BaseViewController<T: Interacting> protocol)
 and Interactor (via Interacting protocol) and have default implementations for
 the ViewController's lifecycle events that may need to bubble up to the Interactor.
 Those protocols are defined in the /Common/BaseContracts folder.
 
 Because there are empty default implementations of the Interacting protocol's
 viewDidLoad, viewWillAppear, and viewWillDisappear methods, we don't need to implement
 them here unless we have functionality that relies on those methods. We often will.
 
 In this example, we have a single dependency: StorageService
 */
///
final class ExampleModuleInteractor: Interacting {
    // MARK: - Variables
    
    ///
    weak var view: ExampleModuleViewController?
    ///
    var networkServices: NetworkService
    ///
    var movies: Movies?
    // MARK: - Life cycle methods
    ///
    init(networkServices: NetworkService) {
        self.networkServices = networkServices
    }
    ///
    func getMovies(completion: @escaping(_ response: Bool) -> Void) {
        networkServices.request(parameters: nil, apiPath: APIList.MoviesList.moviesList, httpMethod: .get, success: { response in
            guard let data = response["data"] as? [String: Any] else {return}
            self.movies = Movies(json: JSON(data))
            completion(true)
        }, failure: { _ in
            completion(false)
        })
    }
}
