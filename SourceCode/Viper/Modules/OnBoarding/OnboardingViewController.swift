//
//  OnboardingViewController.swift
//

import UIKit

class OnboardingViewController: BaseViewController<OnboardingInteractor> {

    // MARK: - Variables

    ///
    var router: OnboardingRouter?

    // MARK: - IBActions

    ///
    @IBAction func getStartedTapped(_ sender: Any) {
        interactor?.setInitialViewController()
    }

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {

        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
    }

}
