//
//  LoginViewController.swift
//  Viper
//

import UIKit

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

        guard interactor?.validate(loginFields: createLoginParameters()) ?? false else { return }
        HapticFeedback.notificationFeedback(ofType: .success)
        //locationService.setupLocationManager()
        locationService.fetchCurrentLocation(withBackgroundModeEnable: false, isContinousUpdate: false)
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

}
