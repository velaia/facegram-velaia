//
//  PostModel.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 20.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

class Post {
    let creator:String
    let timestamp:NSDate
    let caption:String?
    let image:UIImage
    let postID:String?
    static var feed:Array<Post>?
    
    init(id:String?, creator:String, caption:String?, image:UIImage) {
        self.postID = id
        self.creator = creator
        self.caption = caption
        self.timestamp = NSDate()
        self.image = image
    }
    
    static func initWithPostID(postID: String, postDict: [String: String]) -> Post? {
        guard let creator = postDict["creator"], let base64String = postDict["image"] else {
            // Conditions failed ...
            print("Invalid Post Dictionary!")
            return nil
        }
        let caption = postDict["caption"]
        let image = UIImage.imageWithBase64String(base64String)
        return Post(id: postID, creator: creator, caption: caption, image: image)
    }
    
    func dictValue() -> [String: String] {
        var postDict = [String: String]()
        postDict["creator"] = creator
        postDict["image"] = image.base64String()
        if let realCaption = caption {
            postDict["caption"] = realCaption
        }
        return postDict
    }
}

class PostCell: UITableViewCell {
    @IBOutlet weak var captionLabel:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    
}

class PostHeaderCell: UITableViewCell {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
}