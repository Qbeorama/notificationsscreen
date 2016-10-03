//
//  UIImageView+Networking.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImageWithURL(url:NSURL) {
        
        //METHOD STUB.
        //Originally fetched in background with AFNetworking.
        
        self.image = UIImage.init(named: "placeholderImage")
    }
}
