//
//  Designer.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation
import UIKit
import Designer

extension Designer {
    
    func addButtomShadow(to view: UIView, color: CGColor = UIColor(red:0.14, green:0.25, blue:0.46, alpha:0.2).cgColor, height: CGFloat = 2, opacity: Float = 0.8) {
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: view.bounds.height))
        shadowPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        shadowPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height + height))
        shadowPath.addLine(to: CGPoint(x: 0, y: view.bounds.height + height))
        shadowPath.close()
        
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.masksToBounds = false
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: height)
        view.layer.shadowPath = shadowPath.cgPath
    }
    
//    public func addShadow(layer: CALayer) {
//        addShadow(to: layer, opacity: 0.8, height: 2)
//    }
//
//    public func addShadow(to layer: CALayer, opacity: Float, height: Int, radius: CGFloat? = 10) {
//        layer.borderColor = UIColor(red:0.14, green:0.25, blue:0.46, alpha:0.2).cgColor
//        layer.shadowOffset = CGSize(width: 0, height: height)
//        layer.shadowColor = UIColor(red:0.14, green:0.25, blue:0.46, alpha:0.2).cgColor
//        layer.shadowOpacity = opacity
//        var r: CGFloat = 10
//        if let radius = radius {
//            r = radius
//        }
//        layer.shadowRadius = r
//    }

    
    func styleHollowButton(button: UIButton) {
        styleButton(button: button, bg: UIColor.white, borderColor: Colors.primary.cgColor, titleColor: Colors.primary)
    }
    
    func styleFillButton(button: UIButton) {
        styleButton(button: button, bg: Colors.primary, borderColor: Colors.primary.cgColor, titleColor: UIColor.white)
        if let label = button.titleLabel {
            label.font = Fonts.getPrimary(size: 17)
        }
    }
    
    func styleButton(button: UIButton, bg: UIColor, borderColor: CGColor, titleColor: UIColor) {
        button.layer.cornerRadius = 5
        button.backgroundColor = bg
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor
        button.setTitleColor(titleColor, for: .normal)
    }
    
    func styleTitle(label: UILabel) {
        label.textColor = Colors.primary
        label.font = Fonts.getPrimaryBold(size: 22)
    }
    
    func styleSectionHeader(label: UILabel) {
        label.textColor = Colors.technical.mainText
        label.font = Fonts.getPrimaryBold(size: 19)
    }
    
    func styleSmallSectionHeader(label: UILabel) {
        label.textColor = Colors.technical.mainText
        label.font = Fonts.getPrimaryBold(size: 17)
    }
    
    func styleFieldHeader(label: UILabel) {
        label.textColor = Colors.technical.mainText
        label.font = Fonts.getPrimaryBold(size: 17)
    }
    
    func styleFieldValue(label: UILabel) {
        label.textColor = Colors.technical.bodyText
        label.font = Fonts.getPrimary(size: 17)
    }
    
    func styleFieldValue(textField: UITextField) {
        textField.textColor = Colors.technical.bodyText
        textField.font = Fonts.getPrimary(size: 17)
    }
    
    func styleFieldValue(textView: UITextView, editable: Bool = true) {
        textView.textColor = Colors.technical.bodyText
        textView.font = Fonts.getPrimary(size: 17)
        textView.isEditable = editable
    }
    
    func styleSmallFieldValue(label: UILabel) {
        label.textColor = Colors.technical.bodyText
        label.font = Fonts.getPrimary(size: 11)
    }
}
