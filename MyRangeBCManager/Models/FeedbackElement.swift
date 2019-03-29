//
//  FeedbackElement.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-28.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import Foundation

class FeedbackElement {
    var feedback: String
    var section: String
    var anonymous: Bool
    var email: String = ""
    
    init(feedback: String, section: String, anonymous: Bool) {
        self.feedback = feedback
        self.section = section
        self.anonymous = anonymous
        
        if self.section.removeWhitespaces().isEmpty {
            self.section = "*Not Provided"
        }
        
        if self.feedback.removeWhitespaces().isEmpty {
            self.feedback = "*Not Provided"
        }
    }
    
    func toDictionary() -> [String: Any]{
        return [
            "anonymous": anonymous,
            "section": section,
            "feedback": feedback
        ]
    }
}
