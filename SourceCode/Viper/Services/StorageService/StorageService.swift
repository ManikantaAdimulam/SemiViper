//
//  StorageService.swift
//

import Foundation
import CocoaLumberjack

///
typealias BasicCompletion = ((_ isSuccess: Bool, _ error: Error?) -> Void)

/// This service will handle saving data and retrieving saved data
class StorageService {

    // MARK: - Types of storage service

    /// This stores and manages UserDefaults storage
    // private let localStorage: LocalStorageService? = nil
    ///
    // private let cloudStorage = CloudStorageService()

    // MARK: - Onboarding

    ///  Save true as on boarding is shown once.
    ///
    /// - Parameter isShown: Bool value to be stored
    func setOnBoarding(isShown: Bool) {

        LocalStorageService.setShowUserOnboarding(isShown)
    }

    /**
     Get true or false as on boarding is shown once or not.

     - returns: true or false if on boarding screen is shown or not.
     */
    func getIfOnBoardingIsShown() -> Bool {

        return LocalStorageService.getShowUserOnboarding() ?? false
    }
}
