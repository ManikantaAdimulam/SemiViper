//
//  UIViewController+HUD.swift
//  Viper
//

import UIKit
import MBProgressHUD

///
extension UIViewController {

    ///
    func showProgressHudView(title: String = "", view: UIView? = nil) {
        hideProgressHudView()
        DispatchQueue.main.async(execute: {[weak self] in
            let hud = MBProgressHUD.showAdded(to: view ?? self?.view ?? UIView(), animated: true)
            hud.contentColor = UIColor.white
            hud.bezelView.alpha = 1.0
            hud.bezelView.color = UIColor.clear
            hud.bezelView.style = .solidColor
            hud.backgroundView.color = UIColor.black
            hud.backgroundView.alpha = 0.6
            hud.backgroundView.style = .solidColor
            hud.label.text = title
            //hud.detailsLabel.text = description
        })
    }

    ///
    func hideProgressHudView(view: UIView? = nil) {
        DispatchQueue.main.async(execute: {[weak self] in
            MBProgressHUD.hide(for: view ?? self?.view ?? UIView(), animated: true)
        })
    }
}
