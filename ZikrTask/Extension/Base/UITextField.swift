//
//  UITextField.swift
//  Zikr
//
//  Created by Abdulbosid Jalilov on 21/05/24.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, textColor: UIColor, font: UIFont, backgroundColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.textColor = textColor
        self.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        
        
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
