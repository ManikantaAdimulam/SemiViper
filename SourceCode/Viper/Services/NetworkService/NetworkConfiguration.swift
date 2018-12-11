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
    static let currentVersion = "v1"
    ///
    static var baseURL: String = "http://202.131.112.86:9093/"
    ///
    static func configureNetwork(buildEnvironment: BuildEnvironment) {
        switch buildEnvironment {
        case .local: baseURL = "http://192.168.1.57:3002/"
        case .live: baseURL = ""
        case .development: baseURL = ""
        }
    }
}
