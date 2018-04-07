//
//  ProfileDetailTableViewController.swift
//  GitHubProfile
//
//  Created by Israel3D on 04/04/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class ProfileDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUser: UILabel!
    
    var username: String!
    var projectDetails: [ProjectDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        REST.returnGitUser(username: username, onComplete: { (userProfile, projectDetail) in
            self.projectDetails = projectDetail
            DispatchQueue.main.async {
                self.lblUser.text = userProfile.name
                self.userImageView.image = userProfile.image
                self.tableView.reloadData()
            }
        }) { (error) in
            switch error{
            case .noInternetConnection:
                self.showAlertMessage(title: "Error", message: "A network error has occurred. Check your Internet connection and try again later.")
            case .userNotFound:
                self.showAlertMessage(title: "Error", message: "User not found. Please enter another name")
            }
            DispatchQueue.main.async {
                self.lblUser.text = "😰"
            }
        }
    }
    
    func showAlertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOK)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        let project = projectDetails[indexPath.row]
        cell.textLabel?.text = project.titulo
        cell.detailTextLabel?.text = project.descricao
        return cell
    }
    
}
