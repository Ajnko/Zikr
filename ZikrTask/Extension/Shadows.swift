//
//  Shadows.swift
//  ZikrTask
//
//  Created by Abdulbosid Jalilov on 21/05/24.
//

import UIKit

extension UIButton {
    func addShadow(
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.5,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowRadius: CGFloat = 4
    ) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
}

extension UITextField {
    func addShadow(
        shadowColor: UIColor = .black,
        shadowOpacity: Float = 0.5,
        shadowOffset: CGSize = CGSize(width: 0, height: 3),
        shadowRadius: CGFloat = 4
    ) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.masksToBounds = false
    }
    
    func settinPaddingView(paddingView: UIView) {
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
