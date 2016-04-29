//
//  Extensions.swift
//  VelaiaFacegram
//
//  Created by Daniel N Lang on 29.04.16.
//  Copyright © 2016 Daniel N Lang. All rights reserved.
//

import UIKit

extension UIColor {
    static func rawColor(red rawRed: CGFloat, green rawGreen: CGFloat, blue rawBlue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: rawRed/255.0, green: rawGreen/255.0, blue: rawBlue/255.0, alpha:alpha)
    }
}

extension UIImage {
    func base64String() -> String {
        let imageData = UIImagePNGRepresentation(self)
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        return base64String
    }
    
    static func imageWithBase64String(base64String: String) -> UIImage {
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        let postImage = UIImage(data: decodedData)!
        return postImage
    }
}
