//
//  TextStyleDataSource.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

// This class could be further expanded to inject different styles for attributed strings based on context, read in from external XMLs or Theme objects. For now, we'll provide a default initializer.

class TextStyleDataSource: NSObject {
    
    let defaultTextStyle:TextStyle
    let highlightedTextStyle:TextStyle
    
    override init() {
        self.defaultTextStyle = TextStyle(font: UIFont.systemFontOfSize(15.0, weight: UIFontWeightThin), fontColor: UIColor.grayColor())
        self.highlightedTextStyle = TextStyle(font: UIFont.systemFontOfSize(15.0, weight: UIFontWeightBold), fontColor: UIColor.darkGrayColor())
        super.init()
    }
    
    init(defaultTextStyle:TextStyle, highlightedTextStyle:TextStyle) {
        self.defaultTextStyle = defaultTextStyle
        self.highlightedTextStyle = highlightedTextStyle
        super.init()
    }
}
