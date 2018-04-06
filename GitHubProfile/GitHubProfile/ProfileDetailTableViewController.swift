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
    var userprofile: UserProfile! //reparar
    var projectDetails: [ProjectDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.returnGitUsers()
    }
    
    func returnGitUsers() {
        
        if let url = URL(string: "https://api.github.com/users/\(username!)/repos") {
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (dataRtd, res, error) in
                if error == nil {
                    if let data = dataRtd {
                        
                        do {
                            
                            if let objJson =  try JSONSerialization.jsonObject(with: data, options:[]) as? NSArray {
                                
                                var i = 0
                                var projects:[String:Any] = [:]
                                while objJson.count > i {
                                    projects = (objJson[i] as? [String: Any])!
                                    let project = ProjectDetail(titulo: (projects["name"] as? String ?? "Project")!, descricao: (projects["language"] as? String ?? "Language")!)
                                    self.projectDetails.append(project)
                                    i+=1
                                }
                                
                                let imageMother = projects["owner"] as? [String: Any]
                                let imagemurl = imageMother!["avatar_url"] as? String
                                let urlImage = URL(string: imagemurl!) //fazer if caso nao tenha avatar
                                let dataImage = try? Data(contentsOf: urlImage!)
                                
                                let user = UserProfile(image: UIImage(data: dataImage!) ?? #imageLiteral(resourceName: "moeda_coroa"), name: self.username) //reparar
                                
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
