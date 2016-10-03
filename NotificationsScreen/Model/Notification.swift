//
//  Notification.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 23/08/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import Foundation

class Notification: NSObject {
    
    //Values and keys received as dictionary from API
    static let ActorIdKey = "user_id"
    static let ActorNameKey = "user_name"
    static let EventIdKey = "event_id"
    static let EventNameKey = "event_name"
    static let ImageURLKey = "photo_url"
    static let RecipientIdKey = "recipient_id"
    static let RecipientNameKey = "recipient_name"
    static let TimeStampKey = "msg_timestamp"
    static let TypeKey = "msg_type"
    static let UUIDKey = "uuid"
    static let UpdatedAtKey = "updated_at"
    
	let imageURL: String
	let type: NotificationType
    let uuid: String
    
	var actorId: String?
	var actorName: String?
	var eventId: String?
	var eventName: String?
	var recipientId: String?
	var recipientName: String?

    //Should be provided and overriden by API. Fallback to date of the object's creation
    var timestamp: NSDate = NSDate()
    
    init(type: NotificationType, imageURL: String, uuid:String) {
        self.uuid = uuid
		self.type = type
		self.imageURL = imageURL
	}
    
    //MARK: NSObject isEqual override
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let unwrappedObject = object else {
            return false
        }
        let isEqual = (self.uuid == unwrappedObject.uuid)
        return isEqual
    }
}

//MARK: Swift Equatable protocol implementation

func ==(left: Notification, right: Notification) -> Bool {
    return left.uuid == right.uuid
}
