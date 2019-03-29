//
//  UserFeedbackTableViewCell.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-28.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

class UserFeedbackTableViewCell: UITableViewCell, Designer {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var userHeader: UILabel!
    @IBOutlet weak var sectionHeader: UILabel!
    @IBOutlet weak var feedbackHeader: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var feedback: UILabel!
    @IBOutlet weak var feedbackHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with element: FeedbackElement) {
        styleFieldHeader(label: userHeader)
        styleFieldHeader(label: sectionHeader)
        styleFieldHeader(label: feedbackHeader)
        styleFieldValue(label: user)
        styleFieldValue(label: section)
        addShadow(layer: container.layer)
        roundCorners(layer: container.layer, by: 5)
        feedback.font = Fonts.getPrimary(size: 17)
        user.font = Fonts.getPrimary(size: 17)
        section.font = Fonts.getPrimary(size: 17)
        self.user.text = element.email
        self.section.text = element.section
        feedback.text = element.feedback
        self.feedbackHeight.constant = element.feedback.height(withConstrainedWidth: stack.frame.width, font: Fonts.getPrimary(size: 17))
    }
 
}
