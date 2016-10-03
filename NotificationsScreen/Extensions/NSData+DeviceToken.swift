//
//  NSData+DeviceToken.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import Foundation

extension NSData {
    
    func asDeviceTokenString() -> NSString {

        let tokenChars = UnsafePointer<CChar>(self.bytes)
        
        var token:String = ""
        for i in 0..<self.length {
            token += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        return token
    }
}
