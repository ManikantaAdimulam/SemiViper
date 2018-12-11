//
//  BaseViewController.swift
//

import UIKit
import SafariServices

/**
 BaseViewController class that implements basic functionality
 */
class BaseViewController<T: Interacting>: UIViewController, SFSafariViewControllerDelegate {

    /// The interactor for this view
    var interactor: T?

    /**
     Takes care of calling default logic. All views subclasses
     that override this func need to call super.viewDidLoad()
     */
    override func viewDidLoad() {

        super.viewDidLoad()
        interactor?.viewDidLoad()
    }

    /**
     Takes care of calling default logic. All views subclasses
     that override this func need to call super.viewWillAppear()
     */
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        interactor?.viewWillAppear()
    }

    /**
     Takes care of calling default logic. All views subclasses
     that override this func need to call super.viewWillDisappear()
     */
    override func viewWillDisappear(_ animated: Bool) {

        interactor?.viewWillDisappear()
        super.viewWillDisappear(animated)
    }

}
