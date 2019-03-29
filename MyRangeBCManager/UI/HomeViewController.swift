//
//  HomeViewController.swift
//  MyRangeBCManager
//
//  Created by Amir Shayegh on 2019-03-07.
//  Copyright © 2019 Amir Shayegh. All rights reserved.
//

import UIKit
import Designer

enum HomeSection: Int, CaseIterable {
    case VersionInfo
    case EditVersion
    case EditVersionState
    case Options
}

class HomeViewController: UIViewController, Designer {

    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupTableView()
    }
    
    func style() {
        self.divider.backgroundColor = Colors.secondary
        styleTitle(label: pageTitle)
        addButtomShadow(to: topContainer, color: Colors.active.yellow.cgColor, opacity: 0.9)
    }
    
    func openFabricCrashlytics() {
        let urlString = "https://fabric.io/bcdevexchange/ios/apps/ca.bc.gov.pathfinder.mobile.myra/issues?state=all&event_type=crash&time=last-seven-days&subFilter=state"
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        register(cell: "VersionInfoTableViewCell")
        register(cell: "OptionsTableViewCell")
        register(cell: "EditVersionStateTableViewCell")
        register(cell: "ChangeVersionTableViewCell")
    }
    
    func register(cell name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: name)
    }
    
    func getVersionCell(indexPath: IndexPath) -> VersionInfoTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "VersionInfoTableViewCell", for: indexPath) as! VersionInfoTableViewCell
    }
    
    func getOptionCell(indexPath: IndexPath) -> OptionsTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "OptionsTableViewCell", for: indexPath) as! OptionsTableViewCell
    }
    
    func getEditVersionStateCell(indexPath: IndexPath) -> EditVersionStateTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "EditVersionStateTableViewCell", for: indexPath) as! EditVersionStateTableViewCell
    }
    
    func getEditVersionCell(indexPath: IndexPath) -> ChangeVersionTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "ChangeVersionTableViewCell", for: indexPath) as! ChangeVersionTableViewCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HomeSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: Int(indexPath.row))else {return UITableViewCell()}
        switch section {
        case .VersionInfo:
            return getVersionCell(indexPath: indexPath)
        case .Options:
            return getOptionCell(indexPath: indexPath)
        case .EditVersionState:
            return getEditVersionStateCell(indexPath: indexPath)
        case .EditVersion:
            return getEditVersionCell(indexPath: indexPath)
        }
    }
    
}
