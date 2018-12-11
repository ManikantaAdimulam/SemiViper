//
//  NetworkConfiguration.swift
//  PDP
//
import UIKit
import Alamofire
import Reachability
import CocoaLumberjack

///
class NetworkService {

    // MARK: - Variables

    ///
    private var reachability: Reachability?
    ///
    private(set) var isReachable: Bool = false
    ///
    private let notificationService: NotificationService

    // MARK: - Life Cycle Methods
    
    ///
    init(buildEnvirnment: BuildEnvironment, notificationService: NotificationService) {

        self.notificationService = notificationService
        ///
        NetworkConfiguration.configureNetwork(buildEnvironment: .local)
        ///
        configureReachablity()
    }
    
    // MARK: - Configuration Methods
    
    ///
    @objc func reachabilityChanged(_ notification: Notification) {
        
        guard let reachability = notification.object as? Reachability, reachability.connection != .none else {
            DDLogError("Invalid Reachability notification type or connection is none.")
            isReachable = false
            // Show Internet alert/View
            notificationService.showInternetAlert()
            return
        }
        isReachable = true
        DDLogVerbose("Reachable via \(reachability.connection)")
    }
    
    ///
    func configureReachablity() {
        //Reachability
        do {
            reachability = Reachability.init()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch { print("cant access") }
    }
    
    // MARK: - Alamofire Configuration
    
    ///
    func setAlamofireDefaultConfiguration() {
        
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = NetworkConfiguration.timeoutIntervalForRequest
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForResource = NetworkConfiguration.timeoutIntervalForResource
    }
    
    /// Custom API Calling methods. We can call any rest API With this common API calling method.
    ///
    /// - Parameters:
    ///   - path: API path
    ///   - ver: firmware version
    ///   - httpMethod: http Method.
    ///   - queue: queue object.
    ///   - success: success block.
    ///   - failure: failure block.
    func request(parameters: Parameters?, headerParameter: HTTPHeaders? = nil, serverUrl: String = NetworkConfiguration.baseURL, apiPath: String, httpMethod: HTTPMethod, queue: DispatchQueue? = nil, success:@escaping(_ response: [String: Any]) -> Void, failure:@escaping( _ error: Error?) -> Void) {
        
        setAlamofireDefaultConfiguration()
        // Set path
        var completeURL = serverUrl + apiPath
        
        // Add parameters to URL if request is get and clear passing parameters for the get request
        var passingParameters = parameters
        if httpMethod == .get, let value = passingParameters?.values.first as? String {
            completeURL += "/" + value
            passingParameters = nil
        }
        
        // Set header
        let headerParam = headerParameter == nil ? ["Content-Type": "application/json"] : headerParameter
        
        Alamofire.request(completeURL, method: httpMethod, parameters: passingParameters, encoding: JSONEncoding.default, headers: headerParam).responseJSON(queue: queue) { response in
            if let headers = response.response?.allHeaderFields as? [String: String] {
                if let header = headers["x-access-token"] { print(header) }
            }
            switch response.result {
            case .success:
                if let responseDict = response.result.value as? [String: Any] {
                    success(responseDict)
                    
                } else {
                    failure(response.result.error)
                }
            case .failure:
                failure(response.result.error)
            }
        }
    }
    
    /// Custom Multipart API Calling methods. We can call any rest API With this common API calling method.
    ///
    /// - Parameters:
    ///   - path: API path
    ///   - ver: firmware version
    ///   - httpMethod: http Method.
    ///   - queue: queue object.
    ///   - success: success block.
    ///   - failure: failure block.
    func multipartRequest(parameter: Parameters?, image: UIImage?, imageParameterName: String?, headerParameter: HTTPHeaders? = nil, serverUrl: String = NetworkConfiguration.baseURL, apiPath: String, httpMethod: HTTPMethod, queue: DispatchQueue? = nil, success:@escaping(_ response: [String: Any]) -> Void, failure:@escaping( _ error: Error?) -> Void) {
        
        setAlamofireDefaultConfiguration()
        // Set path
        let completeURL = serverUrl + apiPath
        // Set header
        let headerParam = headerParameter == nil ? ["Content-type": "multipart/form-data"] : headerParameter
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if let image = image, let data = image.jpegData(compressionQuality: 1.0) {
                let imageName = "\(Date())"
                multipartFormData.append(data, withName: imageParameterName ?? "", fileName: imageName + ".png", mimeType: "image/png")
            }
            
            for (key, value) in (parameter ?? [:]) {
                guard let data = "\(value)".data(using: String.Encoding.utf8) else { continue }
                multipartFormData.append(data, withName: key as String)
            }
            
        }, usingThreshold: UInt64.init(), to: completeURL, method: .post, headers: headerParam, encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let responseDict = response.result.value as? [String: Any] {
                        success(responseDict)
                    } else {
                        failure(response.result.error)
                    }
                }
            case .failure(let error):
                failure(error)
            }
        })
    }
}
