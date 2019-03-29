//
//  EditVersionStateTableViewCell.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-08.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Extended
import Designer

class EditVersionStateTableViewCell: UITableViewCell, Designer {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var subtitle: UITextView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func switchAction(_ sender: UIButton) {
        VersionHelper.shared.getBuildAndVersionNumber { (build, version) in
            VersionHelper.shared.getVersionState { (state) in
                switch state {
                case .Testing:
                    Alert.show(title: "Switch to Production?", message: "Version \(version), build \(build)", yes: {
                        self.setRemoteVersion(ios: VersionHelper.shared.createRemoteVersionFrom(version: version, build: build), idphint: "idir")
                    }, no: {})
                case .Production:
                    Alert.show(title: "Switch to Testing?", message: "Version \(version), build \(build)", yes: {
                        self.setRemoteVersion(ios: VersionHelper.shared.createRemoteVersionFrom(version: version, build: build), idphint: "bceid")
                    }, no: {})
                case .Unknown:
                    return
                }
            }
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
    }

    func autofillData() {
        resetFields()
        VersionHelper.shared.getVersionState { (state) in
            switch state {
            case .Testing:
                self.setDataForTestState()
            case .Production:
                self.setDataForProductionState()
            case .Unknown:
                self.setDataForUnknownState()
            }
        }
        setDataForTestState()
    }
    
    func setDataForProductionState() {
        sectionTitle.text = "Switch this version to testing state?"
        button.alpha = 1
        button.setTitle("Switch to testing", for: .normal)
        let subtitleText =  "The current version of this application is in production.\nIf you switch this version to testing, anyone who uses this version of the application will see a prompt during login asking them to select what type of tester they are."
        subtitle.text = subtitleText
        self.layoutIfNeeded()
    }
    
    func setDataForTestState() {
        sectionTitle.text = "Has this version been tested and approved by Apple?"
        button.alpha = 1
        button.setTitle("Switch to Production", for: .normal)
        let subtitleText =  "You should switch this version to production if it has been approved by Apple and is NOT waiting for approval in Test Flight or App Store.\nIf you switch this version to production, users will login directly through idir and will not see a prompt to select tester type."
        subtitle.text = subtitleText
        
        // Make sure subtitle font is smaller than the title.
        // since title font will scale to allow it to fit in the field.
        var subtitleFontSize: CGFloat = 17
        if (subtitleFontSize) >= sectionTitle.font.pointSize {
            subtitleFontSize = sectionTitle.font.pointSize - 3
        }
        
        subtitle.font = Fonts.getPrimary(size: subtitleFontSize)
        
        self.layoutIfNeeded()
    }
    
    func setDataForUnknownState() {
        sectionTitle.text = "The current version's state is Unknown"
        button.alpha = 1
        button.setTitle("Switch to testing", for: .normal)
        let subtitleText =  "The version's initial login screen cannot be determined. You can force switch it to testing by tapping the button below."
        subtitle.text = subtitleText
        self.layoutIfNeeded()
    }
    
    func resetFields() {
        subtitle.text = ""
        sectionTitle.text = ""
        button.alpha = 0
    }
    
    func style() {
        styleSmallSectionHeader(label: sectionTitle)
        subtitle.textColor = Colors.technical.bodyText
        subtitle.font = Fonts.getPrimary(size: 17)
        subtitle.isEditable = false
        addShadow(layer: container.layer)
        roundCorners(layer: container.layer, by: 5)
        styleFillButton(button: button)
        divider.backgroundColor = Colors.technical.bodyText.withAlphaComponent(0.7)
    }
}
