//
//  MenuItemView.swift
//  Viper
//
//  Created by Manikanta on 12/13/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import UIKit

/// Customizable View
class ItemView: BaseView {
    ///
    lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    ///
    override func setupView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
        addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
        label.text = "1"
        label.highlightedTextColor = UIColor.white
    }
}
