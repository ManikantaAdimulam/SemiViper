//
//  MenuBar.swift
//  Viper
//
//  Created by Manikanta on 12/13/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import UIKit

class MenuBar: BaseView {
    
    /// CollectionView
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
        cv.dataSource = self
        cv.delegate = self
        let indexPath = IndexPath(item: 0, section: 0)
        cv.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        return cv
    }()
    
    ///
    lazy var underLayer: UIView = {
        let ul = UIView()
        ul.backgroundColor = UIColor.white
        //        ul.layer.borderWidth = 0.5
        //        ul.layer.borderColor = UIColor.red.cgColor
        return ul
    }()
    
    /// Adding View with programetical constraints
    override func setupView() {
        ///
        backgroundColor = UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
        ///
        addSubview(collectionView)
        ///
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        ///
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: collectionView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 44))
        ///
        addSubview(underLayer)
        ///
        underLayer.translatesAutoresizingMaskIntoConstraints = false
        ///
        addConstraint(NSLayoutConstraint(item: underLayer, attribute: .top, relatedBy: .equal, toItem: collectionView, attribute: .bottom, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: underLayer, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: underLayer, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.5))
        addConstraint(NSLayoutConstraint(item: underLayer, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: superview?.frame.size.width ?? 320/4))
        ///
        collectionView.register(MenuBarItem.self, forCellWithReuseIdentifier: "MenuBarItem")
    }
}

///
extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    ///
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    ///
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuBarItem", for: indexPath)
        cell.backgroundColor = UIColor(red: 255/255, green: 12/255, blue: 2/255, alpha: 0.8)
        return cell
    }
    
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: 44)
    }
    
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    ///
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2) {
            self.underLayer.frame.origin.x = CGFloat(indexPath.row) * (collectionView.frame.size.width / 4)
        }
    }
}
