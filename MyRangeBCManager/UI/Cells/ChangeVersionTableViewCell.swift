//
//  ChangeVersionTableViewCell.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-13.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

class ChangeVersionTableViewCell: UITableViewCell, Designer {
    
    var originalBuild: Int = 0
    var originalVersion: Int = 0
    
    var currentBuild: Int = 0
    var currentVersion: Int = 0
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionValue: UILabel!
    
    @IBOutlet weak var buildLabel: UILabel!
    @IBOutlet weak var buildValue: UILabel!
    
    @IBOutlet weak var buildStepper: UIStepper!
    @IBOutlet weak var versionStepper: UIStepper!
    
    @IBAction func buildStepperAction(_ sender: UIStepper) {
        currentBuild = Int(sender.value)
        self.buildValue.text = "\(currentBuild)"
        styleBasedOnValues()
    }
    
    @IBAction func versionStepperAction(_ sender: UIStepper) {
        currentVersion = Int(sender.value)
        self.versionValue.text = "\(currentVersion)"
        styleBasedOnValues()
    }
    
    @IBAction func submitChange(_ sender: Any) {
        let remoteVersion = VersionHelper.shared.createRemoteVersionFrom(version: currentVersion, build: currentBuild)
        Alert.show(title: "Are you sure?", message: "Would you like to set this as the application's latest version?\n\nVersion: \(currentVersion)\nBuild: \(currentBuild)\nTracked as: \(remoteVersion)", yes: {
            Alert.show(title: "Choose the State", message: "Please set the state of\nVersion \(self.currentVersion), Build \(self.currentBuild)", rightButtonName: "Testing", leftButtonName: "Production", rightButtonAction: {
                self.setRemoteVersion(ios: remoteVersion, idphint: "bceid")
            }, leftButtonAction: {
                self.setRemoteVersion(ios: remoteVersion, idphint: "idir")
            })
        }) {
            
        }
    }
    
    func setRemoteVersion(ios: Int, idphint: String) {
        API.updateRemoteVersion(ios: ios, idphint: idphint, completion: { (done, error) in
            if !done {
                Alert.show(title: "Error", message: error)
            } else {
                Alert.show(title: "Updated", message: "")
            }
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
        autofillData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.versionsChanged(_:)), name: .versionsChanged, object: nil)
    }
    
    @objc func versionsChanged(_ notification: NSNotification) {
        autofillData()
        style()
    }
    
    func autofillData() {
        self.updateButton.alpha = 0
        VersionHelper.shared.getBuildAndVersionNumber { (build, version) in
            self.initSteppersWith(build: build, version: version)
        }
    }
    
    func initSteppersWith(build: Int, version: Int) {
        self.currentBuild = build
        self.currentVersion = version
        
        self.originalBuild = build
        self.originalVersion = version
        
        buildStepper.value = Double(build)
        versionStepper.value = Double(version)
        
        versionStepper.minimumValue = 1
        buildStepper.minimumValue = 1
        
        self.buildValue.text = "\(build)"
        self.versionValue.text = "\(version)"
    }
    
    func style() {
        styleSectionHeader(label: sectionTitle)
        styleFieldValue(label: buildValue)
        styleFieldHeader(label: buildLabel)
        styleFieldValue(label: versionValue)
        styleFieldHeader(label: versionLabel)
        addShadow(layer: container.layer)
        roundCorners(layer: container.layer, by: 5)
        divider.backgroundColor = Colors.technical.bodyText.withAlphaComponent(0.7)
        styleFillButton(button: updateButton)
        updateButton.setTitle("Submit", for: .normal)
    }
    
    func styleBasedOnValues() {
        self.updateButton.setTitle("", for: .normal)
        self.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            if self.currentVersion > self.originalVersion {
                self.versionValue.textColor = Colors.active.yellow
                self.updateButton.alpha = 1
                self.updateButton.setTitle("Update", for: .normal)
            }
            
            if self.currentBuild > self.originalBuild  {
                self.buildValue.textColor = Colors.active.yellow
                self.updateButton.alpha = 1
                self.updateButton.setTitle("Update", for: .normal)
            }
            
            if self.currentVersion < self.originalVersion {
                self.versionValue.textColor = Colors.accent.red
                self.updateButton.alpha = 1
                self.updateButton.setTitle("Downgrade", for: .normal)
            }
            
            if self.currentBuild < self.originalBuild  {
                self.buildValue.textColor = Colors.accent.red
                self.updateButton.alpha = 1
                self.updateButton.setTitle("Downgrade", for: .normal)
            }
            
            if self.currentVersion > self.originalVersion && self.currentBuild < self.originalBuild {
                self.buildValue.textColor = Colors.active.yellow
                self.updateButton.alpha = 1
                self.updateButton.setTitle("Update", for: .normal)
            }

            
            if self.currentVersion == self.originalVersion && self.currentBuild == self.originalBuild {
                self.versionValue.textColor = Colors.technical.bodyText
                self.buildValue.textColor = Colors.technical.bodyText
                self.updateButton.alpha = 0
            }
            self.layoutIfNeeded()
        }
    }
}
