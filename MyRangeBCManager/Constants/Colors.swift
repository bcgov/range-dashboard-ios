//
//  Colors.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation
import UIKit
import Extended

class Colors {
    struct active {
        static let blue = UIColor(hex: "#234075")
        static let lightBlue = UIColor(hex: "#65799E")
        static let yellow = UIColor(hex: "#E3A82B")
    }
    
    struct accent {
        static let blue = UIColor(hex: "#1C6BFF")
        static let purple = UIColor(hex: "#B657FA")
        static let green = UIColor(hex: "#16C92E")
        static let yellow = UIColor(hex: "#F5A623")
        static let red = UIColor(hex: "#FF534A")
    }
    
    struct technical {
        static let mainText = UIColor(hex: "#000000")
        static let bodyText = UIColor(hex: "#8C8C8C")
        static let icon = UIColor(hex: "#CDCED2")
        static let input = UIColor(hex: "#EFEFF3")
        static let backgroundOne = UIColor(hex: "#FAFAFA")
        static let backgroundTwo = UIColor(hex: "#FFFFFF")
    }
    
    struct Status {
        static let Yellow = UIColor(hex: "#F5A623")
        static let Green = UIColor(hex: "#16C92E")
        static let DarkGray = UIColor.darkGray
        static let LightGray = UIColor.lightGray
        static let Red = UIColor(hex: "#FF534A")
    }
    
    static let shadowColor = UIColor(red:0.14, green:0.25, blue:0.46, alpha:0.2).cgColor
    
    static let bannerColor = active.yellow
    static let primary = active.blue
    static let primaryConstrast = active.lightBlue
    static let secondary = active.yellow
    static let mainText = technical.mainText
    static let bodyText = technical.bodyText
    static let inputBG = technical.input
    static let inputText = technical.mainText
    static let inputHeaderText = technical.mainText
    static let primaryBg = technical.backgroundTwo
    static let secondaryBg = technical.backgroundOne
    static let oddCell = technical.backgroundOne
    static let evenCell = technical.backgroundTwo
    static let invalid = accent.red
    static let switchOn = accent.green
    static let lockedCell = UIColor(red:0, green:0, blue:0, alpha:0.4)
    
}
