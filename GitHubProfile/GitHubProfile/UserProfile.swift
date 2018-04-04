//
//  UserProfile.swift
//  GitHubProfile
//
//  Created by Israel3D on 04/04/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class UserProfile {
    
    var image: UIImage!
    var name: String!
    var projects: [ProjectDetail]!
    
    init(image: UIImage, name: String, projects:[ProjectDetail]) {
        self.image = image
        self.name = name
        self.projects = projects
    }
}
