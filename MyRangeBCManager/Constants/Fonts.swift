//
//  Fonts.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation
import UIKit

class Fonts {
    
    static func getPrimary(size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIText", size: size)!
    }
    
    static func getPrimaryBold(size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIText-Bold", size: size)!
    }
    
    static func getPrimaryHeavy(size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIText-Heavy", size: size)!
    }
    
    static func getPrimaryLight(size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIText-Light", size: size)!
    }
    
    static func getPrimaryMedium(size: CGFloat) -> UIFont {
        return UIFont(name: ".SFUIText-Medium", size: size)!
    }
}

