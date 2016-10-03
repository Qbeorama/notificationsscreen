//
//  TextStyle.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

struct TextStyle {
    let fontColor:UIColor
    let font:UIFont
    
    init(font:UIFont, fontColor:UIColor) {
        self.font = font
        self.fontColor = fontColor
    }
}
