//
//  SignUpViewController.swift
//
//

import UIKit

class SignUpViewController: BaseViewController<SignUpInteractor> {

    // MARK: - Variables

    // MARK: - IBOutlets

    ///
    @IBOutlet weak var firstNameTextField: UITextField!
    ///
    @IBOutlet weak var lastNameTextField: UITextField!
    ///
    @IBOutlet weak var emailTextField: UITextField!
    ///
    @IBOutlet weak var passwordTextField: UITextField!
    ///
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    // MARK: - IBActions

    @IBAction func signUpTapped(_ sender: Any) {
         guard interactor?.validate(registerFields: createRegisterParameters()) ?? false else { return }
       
    }
    // MARK: - Lifecycle Methods

    ///
    override func viewDidLoad() {

        super.viewDidLoad()
    }

    // MARK: - Setup methods

    ///
    func setupUI() {
    }

    // MARK: - Helper methods

    ///
    func createRegisterParameters() -> [String: Any] {

        var registerParameters = [String: Any]()
        registerParameters["firstName"] = firstNameTextField.text ?? ""
        registerParameters["lastName"] = lastNameTextField.text ?? ""
        registerParameters["email"] = emailTextField.text ?? ""
        registerParameters["password"] = passwordTextField.text ?? ""
        return registerParameters
    }
}
