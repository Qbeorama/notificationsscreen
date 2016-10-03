//
//  Notification+DictionaryForm.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import Foundation

extension Notification {
    
    class func notificationWithDictionary(dictionary:NSDictionary)->Notification? {
        
        guard let uuid = dictionary[Notification.UUIDKey] as? String else {
            assert(false, "Dictionary does not contain non-optional UUID key!")
            return nil
        }
        guard let imageURL = dictionary[Notification.ImageURLKey] as? String else {
            assert(false, "Dictionary does not contain non-optional imageURL key!")
            return nil
        }
        guard let notificationTypeString = dictionary[Notification.TypeKey] as? String else {
            assert(false, "Dictionary does not contain non-optional notificationType key!")
            return nil
        }
        
        let actorName = dictionary[Notification.ActorNameKey] as? String
        let actorId = dictionary[Notification.ActorIdKey] as? String
        let eventName = dictionary[Notification.EventNameKey] as? String
        let eventId = dictionary[Notification.EventIdKey] as? String
        let recipientName = dictionary[Notification.RecipientNameKey] as? String
        let recipientId = dictionary[Notification.RecipientIdKey] as? String
        
        let type = Notification.enumFromAPIString(notificationTypeString)
        
        let notification = Notification.init(type: type, imageURL: imageURL, uuid: uuid)
        notification.actorId = actorId
        notification.actorName = actorName
        notification.eventId = eventId
        notification.eventName = eventName
        notification.recipientId = recipientId
        notification.recipientName = recipientName
        
        let date = dictionary[Notification.TimeStampKey] as? NSDate
        if (date == nil) {
            notification.timestamp = NSDate()
        } else {
            notification.timestamp = date!
        }
        
        return notification
    }
    
    func toDictionary()->NSDictionary {
        
        let mutableDictionary = NSMutableDictionary()
        
        let enumStringForm = Notification.stringFromEnum(type)
        
        mutableDictionary.setObject(enumStringForm, forKey: Notification.TypeKey)
        mutableDictionary.setObject(timestamp, forKey: Notification.TimeStampKey)
        mutableDictionary.setObject(uuid, forKey: Notification.UUIDKey)
        mutableDictionary.setObject(imageURL, forKey: Notification.ImageURLKey)

        if (actorName != nil) {
            mutableDictionary.setObject(actorName!, forKey:Notification.ActorNameKey)
        }
        if (actorId != nil) {
            mutableDictionary.setObject(actorId!, forKey:Notification.ActorIdKey)
        }
        if (eventName != nil) {
            mutableDictionary.setObject(eventName!, forKey:Notification.EventNameKey)
        }
        if (eventId != nil) {
            mutableDictionary.setObject(eventId!, forKey:Notification.EventIdKey)
        }
        if (recipientName != nil) {
            mutableDictionary.setObject(recipientName!, forKey:Notification.RecipientNameKey)
        }
        if (recipientId != nil) {
            mutableDictionary.setObject(recipientId!, forKey:Notification.RecipientIdKey)
        }
        
        let immutableDictionary = mutableDictionary.copy() as! NSDictionary
        return immutableDictionary
    }

}
