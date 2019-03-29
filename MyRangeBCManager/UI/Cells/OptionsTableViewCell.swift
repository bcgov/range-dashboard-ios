//
//  OptionsTableViewCell.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-08.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

class OptionsTableViewCell: UITableViewCell, Designer {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var testFlightLabel: UILabel!
    @IBOutlet weak var appStoreLabel: UILabel!
    
    @IBOutlet weak var divider: UIView!
    
    @IBAction func testflightAction(_ sender: Any) {
        
    }
    
    @IBAction func appStoreAction(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    func style() {
        styleSectionHeader(label: sectionTitle)
        styleFieldValue(label: appStoreLabel)
        styleFieldValue(label: testFlightLabel)
        addShadow(layer: container.layer)
        roundCorners(layer: container.layer, by: 5)
        divider.backgroundColor = Colors.technical.bodyText.withAlphaComponent(0.7)
    }
}
