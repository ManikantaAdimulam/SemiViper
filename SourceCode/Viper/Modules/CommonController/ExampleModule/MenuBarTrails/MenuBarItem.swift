//
//  MenuBarItem.swift
//  Viper
//
//  Created by Manikanta on 12/13/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import UIKit

class MenuBarItem: UICollectionViewCell {

    /// Creating item view
    lazy var itemView: ItemView = {
        let iv = ItemView()
        return iv
    }()

    ///
    override var isSelected: Bool {
        didSet {
            itemView.backgroundColor = isSelected ? UIColor.white: UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
            itemView.layer.borderWidth = 0.5
            itemView.layer.borderColor = isSelected ? UIColor.white.cgColor: UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8).cgColor
        }
    }

    ///
    override var isHighlighted: Bool {
        didSet {
            itemView.backgroundColor = isSelected ? UIColor.white: UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
        }
    }

    ///
    override init(frame: CGRect) {
        super.init(frame: frame)
        ///
        backgroundColor = UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
        ///
        addSubview(itemView)
        ///
        itemView.translatesAutoresizingMaskIntoConstraints = false
        ///
        addConstraint(NSLayoutConstraint(item: itemView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: itemView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: itemView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: itemView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0))
    }

    ///
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    ///
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
