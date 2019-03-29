//
//  FeedbacksViewController.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-28.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer
class FeedbacksViewController: UIViewController, Designer {

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var feedbacks: [FeedbackElement] = [FeedbackElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        style()
        load()
    }
    
    func load() {
        getFeedbacks { (feedbacks) in
            self.feedbacks = feedbacks
            self.tableView.reloadData()
        }
    }
    
    func style() {
        self.divider.backgroundColor = Colors.secondary
        styleTitle(label: pageTitle)
        addButtomShadow(to: topContainer, color: Colors.active.yellow.cgColor, opacity: 0.9)
    }
    
    func getFeedbacks(completion: @escaping (_ feedbacks: [FeedbackElement])->Void) {
        guard let endpoint = URL(string: Constants.API.feedbackPath, relativeTo: Constants.API.baseURL) else {
            return completion([FeedbackElement]())
        }
        
        API.get(endpoint: endpoint) { (json) in
            var results = [FeedbackElement]()
            guard let response = json else {return completion(results)}
            for element in response {
                var fb: String = ""
                if let feedback = element.1["feedback"].string {
                    fb = feedback
                }
                
                var sec: String = ""
                if let section = element.1["section"].string {
                    sec = section
                }
                
                var anonym:Bool = true
                if element.1["userId"].int != nil {
                    anonym = false
                }
                
                var email = ""
                if !anonym, let user = element.1["user"].dictionaryObject{
                    if let mail = user["email"] as? String {
                        email = mail
                    }
                }
                let element = FeedbackElement(feedback: fb, section: sec, anonymous: anonym)
                if !email.isEmpty {
                    element.email = email
                }
                results.append(element)
            }
            return completion(results)
        }
    }

}

extension FeedbacksViewController:  UITableViewDelegate, UITableViewDataSource {
    func setUpTable() {
        if self.tableView == nil { return }
        tableView.delegate = self
        tableView.dataSource = self
        registerCell(name: "UserFeedbackTableViewCell")
    }
    
    func registerCell(name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func getUserFeedbackTableViewCell(indexPath: IndexPath) -> UserFeedbackTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "UserFeedbackTableViewCell", for: indexPath) as! UserFeedbackTableViewCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = getUserFeedbackTableViewCell(indexPath: indexPath)
        cell.setup(with: feedbacks[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks.count
    }
}
