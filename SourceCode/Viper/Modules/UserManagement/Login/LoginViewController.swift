//
//  LoginViewController.swift
//  Viper
//

import UIKit
//import MSAL
import ADAL

class LoginViewController: BaseViewController<LoginInteractor> {
    
    // MARK: - IBOutlets
    
    ///
    @IBOutlet weak var emailTextField: UITextField!
    ///
    @IBOutlet weak var passwordTextField: UITextField!
    
    ///
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - IBActions
    lazy var locationService = LocationService(notificationService: interactor?.notificationService)
    ///
    @IBAction func loginTapped(_ sender: Any) {
        //showProgressHudView(title: "", view: loginButton)
        //   interactor?.requestAuthForNotification()
        
        //        let gallery = GalleryService(navigationController: self.navigationController)
        //        gallery.openCamera()
        //            interactor?.navigateToExampleModule()
        //        guard interactor?.validate(loginFields: createLoginParameters()) ?? false else { return }
        //        HapticFeedback.notificationFeedback(ofType: .success)
        //locationService.setupLocationManager()
        //        locationService.fetchCurrentLocation(withBackgroundModeEnable: false, isContinousUpdate: false)
        //        acquireToken { (response) in
        //            print(response)
        //        }
        /**
         - Microsoft login using ADAL library
         */
        loginWithADAL { (u) in
            print(u)
        }
    }
    
    ///
    @IBAction func signUpTapped(_ sender: Any) {
        interactor?.navigateToSignUp()
        
    }
    
    ///
    @IBAction func forgotPasswordTapped(_ sender: Any) {
        interactor?.navigateToForgotPassword()
    }
    
    // MARK: - Life cycle methods
    
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helper methods
    
    ///
    func createLoginParameters() -> [String: Any] {
        var loginParameters = [String: Any]()
        loginParameters["email"] = emailTextField.text ?? ""
        loginParameters["password"] = passwordTextField.text ?? ""
        return loginParameters
    }
    ///   Microsoft login using MSAL library(V 2.0)
    //    func acquireToken(completion: @escaping (_ success: Bool) -> Void) {
    //
    //        //        let kGraphURI = "https://graph.windows.net"
    //        let kAuthority = "https://login.microsoftonline.com/common"
    //        let kClientID = "7b0108e4-4e01-44c4-a1cb-9216609779f8"
    //        guard let url = URL(string: kAuthority) else {return}
    //
    //        do {
    //            let authority = try MSALAuthority(url: url)
    //            let applicationContext = try MSALPublicClientApplication(clientId: kClientID, keychainGroup: "com.manikanta.-", authority: authority)
    //            applicationContext.acquireToken(forScopes: ["user.read"]) { (result, error) in
    //                if let json = result?.accessToken {
    //                    print(json, result?.account.username ?? "", error ?? "")
    //                }
    //            }
    //        } catch let error {
    //            print(error)
    //        }
    //    }
    
    /// Microsoft login using ADAL(V1.0).
    ///
    /// - Parameter completion: Login success or failure.
    func loginWithADAL(completion: @escaping(_ response: Bool) -> Void) {
        let kGraphURI = "https://graph.windows.net"
        let kAuthority = "https://login.microsoftonline.com/common"
        let kClientID = "5848460e-b9cb-484a-9f14-ad2c2e1612a8"
        let kRedirectUrl = "mssso://com.xcube.hrdemo"
        guard let url = URL(string: kRedirectUrl) else {return}
        var authenticationError: ADAuthenticationError?
        let authContext = ADAuthenticationContext(authority: kAuthority, error: &authenticationError)
        authContext?.acquireToken(withResource: kGraphURI, clientId: kClientID, redirectUri: url, completionBlock: { (result) in
            print("\(String(describing: result?.authority))")
        })
    }
    
}
