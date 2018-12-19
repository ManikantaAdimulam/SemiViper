//
//  MenubarVC.swift
//  Viper
//
//  Created by Manikanta on 12/13/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import UIKit

class MenubarVC: UIViewController {

    /// Creating menu bar
    let menuBar: MenuBar = {
        let mb = MenuBar()
        mb.frame.size = .zero
        mb.layer.borderWidth = 0.5
        mb.layer.borderColor = UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8).cgColor
        return mb
    }()

    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        ///
        view.addSubview(menuBar)
        ///
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        ///
        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: menuBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 48))
        
    }
}

/// Base class for over ride methodes
class BaseView: UIView {
    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    ///
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///
    func setupView() {
        
    }
}
