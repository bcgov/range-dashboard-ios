//
//  VersionInfoTableViewCell.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-08.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

class VersionInfoTableViewCell: UITableViewCell, Designer {
    
    @IBOutlet weak var versionContainer: UIView!
    @IBOutlet weak var appVersionTitle: UILabel!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionValue: UILabel!
    
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var buildValue: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateValue: UILabel!
    
    @IBOutlet weak var divider: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        style()
        autofillData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.versionsChanged(_:)), name: .versionsChanged, object: nil)
    }
    
    @objc func versionsChanged(_ notification: NSNotification) {
        autofillData()
    }
    
    func getBuildNumber(from version: RemoteVersion) -> Int {
        return Int(version.ios / 1000)
    }
    
    func getVersionNumber(from version: RemoteVersion) -> Int {
        let buildNumber = getBuildNumber(from: version)
        return version.ios - (buildNumber * 1000)
    }
    
    func autofillData() {
        resetFields()
        VersionHelper.shared.getBuildAndVersionNumber { (build, version) in
            self.buildValue.text = "\(build)"
            self.versionValue.text = "\(version)"
        }
        VersionHelper.shared.getVersionState { (state) in
            switch state {
            case .Testing:
                self.stateValue.text = "Testing"
            case .Production:
                self.stateValue.text = "Production"
            case .Unknown:
                self.stateValue.text = "Unknown"
            }
        }
    }
    
    func resetFields() {
        self.buildValue.text = "..."
        self.versionValue.text = "..."
        self.stateValue.text = "..."
    }
    
    func style() {
        styleSectionHeader(label: appVersionTitle)
        styleFieldValue(label: buildValue)
        styleFieldHeader(label: buildLabel)
        styleFieldValue(label: stateValue)
        styleFieldHeader(label: stateLabel)
        styleFieldValue(label: versionValue)
        styleFieldHeader(label: versionLabel)
        addShadow(layer: versionContainer.layer)
        roundCorners(layer: versionContainer.layer, by: 5)
        divider.backgroundColor = Colors.technical.bodyText.withAlphaComponent(0.7)
    }

}
