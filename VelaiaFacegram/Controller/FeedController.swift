//
//  FeedController.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 22.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

class FeedController: UITableViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() // Refreshes our feed
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let feed = Post.feed {
            return feed.count
        } else {
            return 0
        }
    }
    
    func postIndex(cellIndex: Int) -> Int {
        return tableView.numberOfSections - cellIndex - 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = Post.feed![postIndex(indexPath.section)]
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
        
        cell.captionLabel.text = post.caption
        cell.imgView.image = post.image
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let post = Post.feed![postIndex(indexPath.section)]
        if let img = post.image {
            let aspectRatio = img.size.height / img.size.width
            return tableView.frame.size.width * aspectRatio + 80 // height accounting for buttons and caption
        }
        return 208 // default height
    }
}
