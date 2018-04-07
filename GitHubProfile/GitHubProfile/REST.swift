//
//  REST.swift
//  GitHubProfile
//
//  Created by Israel3D on 07/04/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

enum GitError {
    case userNotFound
    case noInternetConnection
}

class REST {
    
    class func returnGitUser(username:String, onComplete: @escaping (UserProfile, [ProjectDetail]) -> Void, onError: @escaping (GitError) -> Void){
        if let url = URL(string: "https://api.github.com/users/\(username)/repos") {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (dataRtd, res, error) in
                if error == nil {
                    if let data = dataRtd {
                        
                        do {
                            
                            if let objJson =  try JSONSerialization.jsonObject(with: data, options:[]) as? NSArray {
                                
                                var i = 0
                                var projects:[String:Any] = [:]
                                var projectDetails: [ProjectDetail] = []
                                while objJson.count > i {
                                    projects = (objJson[i] as? [String: Any])!
                                    let project = ProjectDetail(titulo: (projects["name"] as? String ?? "Project")!, descricao: (projects["language"] as? String ?? "Language")!)
                                    projectDetails.append(project)
                                    i+=1
                                }
                                
                                let imageMother = projects["owner"] as? [String: Any]
                                let urlImage = URL(string:(imageMother!["avatar_url"] as? String)!)
                                let dataImage = try? Data(contentsOf: urlImage!)
                                
                                let user = UserProfile(image: UIImage(data: dataImage!) ?? #imageLiteral(resourceName: "moeda_coroa"), name: username)
                                
                                onComplete(user, projectDetails)
                                
                            } else {
                                onError(.userNotFound)
                            }
                            
                        }catch {
                            onError(.userNotFound)
                        }
                    } else {
                        onError(.userNotFound)
                    }
                } else {
                    onError(.noInternetConnection)
                }
            })
            dataTask.resume()
        }
        
    }
    
    
}


