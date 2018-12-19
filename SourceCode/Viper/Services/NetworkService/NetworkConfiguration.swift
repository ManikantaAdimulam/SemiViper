//
//  NetworkConfiguration.swift
//  PDP
//
//
import UIKit
///
class NetworkConfiguration: NSObject {
    
    // MARK: - Variables
    
    /// Time Interval in second for request time out
    static let timeoutIntervalForRequest = 30.0
    /// Time Interval in second for resource time out
    static let timeoutIntervalForResource = 30.0
    ///
    static let currentVersion = "v2"
    ///
    static var baseURL: String = "https://yts.am/api/"
    ///
    static func configureNetwork(buildEnvironment: BuildEnvironment) {
        switch buildEnvironment {
        case .local: baseURL = "https://yts.am/api/"
        case .live: baseURL = ""
        case .development: baseURL = ""
        }
    }
}
