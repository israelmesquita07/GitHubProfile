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
    var userprofile: UserProfile!
    var projectDetails: [ProjectDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //jeremy
        if let url = URL(string: "https://api.github.com/users/\(username!)/repos") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (dataRtd, res, error) in
                if error == nil {
                    if let data = dataRtd {
                        
                        do {
                            
                            if let objJson =  try JSONSerialization.jsonObject(with: data, options:[]) as? NSArray {
                                // print(objJson)
                                
                                var i = 0
                                var projects:[String:Any] = [:]
                                while objJson.count > i {
                                    projects = (objJson[i] as? [String: Any])!
                                    let project = ProjectDetail(titulo: (projects["name"] as? String ?? "Project")!, descricao: (projects["language"] as? String ?? "Language")!)
                                    self.projectDetails.append(project)
                                    i+=1
                                }
                                // let name = projects["owner"] as? [String: Any]
                                //                                let user = UserProfile(image: #imageLiteral(resourceName: "moeda_coroa"), name: name!["login"] as? String ?? "Name")
                                let user = UserProfile(image: #imageLiteral(resourceName: "moeda_coroa"), name: self.username)
                                
                                DispatchQueue.main.async {
                                    self.lblUser.text = user.name
                                    self.userImageView.image = user.image
                                    self.tableView.reloadData()
                                }
                            }
                            
                        }catch {
                            
                        }
                        
                    } else {
                        self.showAlertMessage(title: "Error", message: "User not found. Please enter another name")
                    }
                } else {
                    self.showAlertMessage(title: "Error", message: "A network error has occurred. Check your Internet connection and try again later.")
                }
            })
            task.resume()
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
        // Dispose of any resources that can be recreated.
        
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
