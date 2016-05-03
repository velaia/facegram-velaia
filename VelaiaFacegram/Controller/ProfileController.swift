//
//  ProfileController.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 21.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

enum ActionButtonState: String {
    case CurrentUser = "Edit Profile"
    case NotFollowing = "+ Follow"
    case Following = "✓ Following"
}

class ProfileController: UIViewController {
    @IBOutlet weak var profilePic:UIImageView!
    @IBOutlet weak var postsLabel:UILabel!
    @IBOutlet weak var followersLabel:UILabel!
    @IBOutlet weak var followingLabel:UILabel!
    @IBOutlet weak var actionButton:UIButton!
    var profileUsername = Profile.currentUser?.username // Show currentUser by default
    var userProfile: Profile? // Fetch a user's profile if necessary
    var actionButtonState: ActionButtonState = .CurrentUser {
        willSet(newState) {
            switch newState {
            case .CurrentUser:
                actionButton.backgroundColor = UIColor.rawColor(red: 228, green: 228, blue: 228, alpha: 1.0)
                actionButton.layer.borderWidth = 1
            case .NotFollowing:
                actionButton.backgroundColor = UIColor.whiteColor()
                actionButton.layer.borderColor = UIColor.rawColor(red: 18, green: 86, blue: 136, alpha: 1.0).CGColor
                actionButton.layer.borderWidth = 1
            case .Following:
                actionButton.backgroundColor = UIColor.rawColor(red: 111, green: 187, blue: 82, alpha: 1.0)
                actionButton.layer.borderWidth = 0
            }
            actionButton.setTitle(newState.rawValue, forState: .Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let username = profileUsername else {
            print("No username for ProfileController")
            return
        }
        userProfile = Profile.currentUser
        if username == Profile.currentUser?.username {
            // udpate profile ui
            updateProfile()
        }
        profileRef.childByAppendingPath(username).observeEventType(.Value, withBlock: { snapshot in
            guard let profile = snapshot.value as? [String: AnyObject] else {
                return
            }
            self.userProfile = Profile.initWithUsername(username, profileDict: profile)
            if username != Profile.currentUser?.username {
                if self.userProfile!.followers.contains(Profile.currentUser!.username) {
                    // Following
                    self.actionButtonState = .Following
                } else {
                    // Not following
                    self.actionButtonState = .NotFollowing
                }
            }
            self.updateProfile()
            }, withCancelBlock: { error in
                print("Problem loading \(self.profileUsername)'s profile \(error.localizedDescription)")
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = Profile.currentUser {
            navigationController?.navigationBar.topItem?.title = currentUser.username
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
    
    func updateProfile() {
        postsLabel.text = "\(userProfile!.posts.count)"
        followersLabel.text = "\(userProfile!.followers.count)"
        followingLabel.text = "\(userProfile!.following.count)"
        if let profPic = userProfile?.picture {
            profilePic.image = profPic
        }
    }
    
    @IBAction func editProfile(sender:AnyObject) {
        print("User wants to edit their profile")
    }
}
