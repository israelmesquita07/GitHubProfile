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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
    override func viewWillAppear(_ animated: Bool) {
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
                                let name = projects["owner"] as? [String: Any]
                                let user = UserProfile(image: #imageLiteral(resourceName: "moeda_coroa"), name: name!["login"] as? String ?? "Name")
                                
                                DispatchQueue.main.async {
                                    self.lblUser.text = user.name
                                    self.userImageView.image = user.image
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
