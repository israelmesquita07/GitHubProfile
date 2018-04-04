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
        // Do any additional setup after loading the view, typically from a nib...
    }

    
    @IBAction func search(_ sender: UIButton) {
        let username = txtUserName.text
        print(username!)
        hideKeyboard()
        txtUserName.text = ""
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

