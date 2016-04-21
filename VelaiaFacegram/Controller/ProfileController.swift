//
//  ProfileController.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 21.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    @IBOutlet weak var profilePic:UIImageView!
    @IBOutlet weak var postsLabel:UILabel!
    @IBOutlet weak var followersLabel:UILabel!
    @IBOutlet weak var followingLabel:UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = Profile.currentUser {
            self.postsLabel.text = "\(currentUser.posts.count)" // "5" 5 - just a string containing the count of posts
            self.followersLabel.text = "\(currentUser.followers.count)"
            self.followingLabel.text = "\(currentUser.following.count)"
            if let profilePic = currentUser.picture {
                self.profilePic.image = profilePic
            }
        } else {
            print("No user is logged in")
        }
    }
    
    @IBAction func editProfile(sender:AnyObject) {
        print("User wants to edit their profile")
    }
}
