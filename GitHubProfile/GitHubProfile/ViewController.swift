//
//  ViewController.swift
//  GitHubProfile
//
//  Created by Israel3D on 30/03/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtUserName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let profileDetailViewController = segue.destination as! ProfileDetailTableViewController
        
        if let username = txtUserName.text {
            profileDetailViewController.username = username
            hideKeyboard()
            txtUserName.text = ""
        }
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

