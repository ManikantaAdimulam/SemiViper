//
//  APIList.swift
//  PDP
//
//

import UIKit

///
enum BuildEnvironment: String {
    case local = "Local"
    case live = "Live"
    case development = "Development"
}

///
class APIList: NSObject {

//    /
//    struct ServerUrl {
//        ///
//        static var localURL: String {
//            return NetworkConfiguration.baseURL// + NetworkConfiguration.currentVersion
//        }
//    }

    ///
    struct Registration {
        ///
        static var getCountries = "api/country/"
        ///
        static var getStates = "api/state/"
        ///
        static var getCities = "api/city/"
        ///
        static var verifyOtp = "api/verifyOtp/"
        ///
        static var registerUser = "api/registration-customer/"
        ///
        static var termsAndConditions = "api/term-condition/"
    }
    
    ///
    struct ServiceInterest {
        ///
        static var getServices = "api/optin-services"
    }
    
    struct ServiceConfirm {
        ///
        static var saveOptinService = "api/save-optin-service"
    }
    struct MoviesList {
        static var moviesList = "/list_movies.json"
    }
}
