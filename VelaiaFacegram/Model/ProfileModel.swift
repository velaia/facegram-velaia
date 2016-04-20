//
//  ProfileModel.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 20.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

class Profile {
    let username:String
    var followers:Array<String>
    var following:Array<String>
    var posts:Array<Post>
    var picture:UIImage?
    static var currentUser:Profile?
    
    init (username:String, followers:Array<String>, following:Array<String>, posts:Array<Post>, picture:UIImage?) {
        self.username = username
        self.followers = followers
        self.following = following
        self.posts = posts
        self.picture = picture
    }
    
    static func createUser(username:String!) -> Profile {
        return Profile(username: username, followers: [String](), following: [String](), posts: [Post](), picture: nil)
    }
}

