//
//  ForgetPasswordViewController.swift
//
//

import UIKit

class ForgetPasswordViewController: BaseViewController<ForgetPasswordInteractor> {

    // MARK: - Variables

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!

    // MARK: - IBActions

    @IBAction func submitTapped(_ sender: Any) {
        guard interactor?.validate(forgotPasswordFields: ["email": emailTextField.text ?? ""]) ?? false else { return }
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
}
