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
    let image:UIImage?
    static var feed:Array<Post>?
    
    init(creator:String, caption:String?, image:UIImage?) {
        self.creator = creator
        self.caption = caption
        self.timestamp = NSDate()
        self.image = image
    }
}

class PostCell: UITableViewCell {
    @IBOutlet weak var captionLabel:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    
}