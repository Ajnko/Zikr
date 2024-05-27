//
//  UIColor.swift
//  Zikr
//
//  Created by Abdulbosid Jalilov on 21/05/24.
//

import Foundation
import UIKit

class AppColor: UIColor {
    
    static let viewColor = #colorLiteral(red: 0.8452333808, green: 0.8105810285, blue: 0.7374964356, alpha: 1)
    static let appBlackColor = #colorLiteral(red: 0.2096310258, green: 0.2603286505, blue: 0.3232938647, alpha: 1)
    static let buttonBackroundColor = #colorLiteral(red: 0.8745098039, green: 0.8352941176, blue: 0.7803921569, alpha: 1)
    static let appWhite = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let textcolor = #colorLiteral(red: 0.2117647059, green: 0.2588235294, blue: 0.3254901961, alpha: 1)

}

extension UIColor {
    static var textColor: UIColor {
        #colorLiteral(red: 0.001760003506, green: 0.1081371084, blue: 0.1908164918, alpha: 1)
    }
    
    static var whiteTextColor: UIColor {
        .white
    }
    
    static var lightMode: UIColor {
        #colorLiteral(red: 0.6962592006, green: 0.7062096, blue: 0.6844680309, alpha: 1)
    }
    
    static var darkMode: UIColor {
        #colorLiteral(red: 0.2096310258, green: 0.2603286505, blue: 0.3232938647, alpha: 1)
    }
    
}
