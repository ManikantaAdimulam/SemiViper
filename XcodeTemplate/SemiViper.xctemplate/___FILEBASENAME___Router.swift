//
//  ___FILENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//

import UIKit

/// Implementation of ___VARIABLE_productName:identifier___Routing
class ___FILEBASENAME___ {

    // MARK: - Variables

    // MARK: - Life cycle methods

    // MARK: - Assemble methods

    ///
    func assembleInitialScreen() -> ___VARIABLE_productName:identifier___ViewController {

        let storyboard = UIStoryboard.init(name: "___VARIABLE_productName:identifier___", bundle: nil)

        guard let vc = storyboard.instantiateInitialViewController() as? ___VARIABLE_productName:identifier___ViewController else {
            fatalError("Unable to get ___VARIABLE_productName:identifier___ViewController.")
        }

        let interactor = ___VARIABLE_productName:identifier___Interactor()
        vc.interactor = interactor
		interactor.view = vc
        return vc
    }

    // MARK: - Navigation methods
}
