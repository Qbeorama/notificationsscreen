//
//  NotificationsPlistStore+InitialData.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import Foundation

extension NotificationsPlistStore {
    
    //MARK: Method needed only for preview purpose
    
    internal func populateWithPreviewData(){
        
        let unparsedNotifications = [
            self.samplePushNotificationOne(),
            self.samplePushNotificationTwo(),
            self.samplePushNotificationThree(),
            self.samplePushNotificationFour(),
            self.samplePushNotificationFive()
        ]
        
        var notifications:[Notification] = []
        
        for dictionary in unparsedNotifications {
            let params = dictionary["params"] as! NSDictionary
            guard let notification = Notification.notificationWithDictionary(params) else {
                continue
            }
            notifications.append(notification)
        }
        
        self.saveNotificationsSync(notifications)
    }
    
    internal func samplePushNotificationOne() -> NSDictionary {
        let dictionary = [
            "aps" : [
                "alert" : "New notification",
                "content-available" : 1,
                "sound" : "default",
            ],
            "params" : [
                "comments_count" : 0,
                "event_id" : "316b6ed1-d003-48ac-a4a7-8c83884f173d",
                "event_name" : "Trening biegowy",
                "msg_timestamp" : 1475513761885,
                "msg_type" : "new_participant",
                "photo_url" : "https://graph.facebook.com/625915570914917/picture?height=400&width=400",
                "timestamp" : 1480586431000,
                "updated_at" : 1475513761864,
                "user_id" : "652a761c-012d-4c2c-92a5-12b2f2562e26",
                "user_name" : "Jan Kowalski",
                "uuid" : "b2a10a15-1b27-43c0-9563-59d3631da12d",
            ],
            ]
        return dictionary
    }
    
    
    internal func samplePushNotificationTwo() -> NSDictionary {
        let dictionary = [
            "aps" : [
                "alert" : "New notification",
                "content-available" : 1,
                "sound" : "default",
            ],
            "params" : [
                "comments_count" : 0,
                "event_id" : "316b6ed1-d003-48ac-a4a7-8c83884f173d",
                "event_name" : "Trening biegowy",
                "msg_timestamp" : 1475513662388,
                "msg_type" : "leaving_participant",
                "photo_url" : "https://graph.facebook.com/625915570914917/picture?height=400&width=400",
                "timestamp" : 1485542941000,
                "updated_at" : 1475513761864,
                "user_id" : "652a761c-012d-4c2c-92a5-12b2f2562e26",
                "user_name" : "Jan Kowalski",
                "uuid" : "b2a10a15-12b7-493c-9563-59d3631da12d",
            ],
            ]
        return dictionary
    }
    
    internal func samplePushNotificationThree() -> NSDictionary {
        let dictionary = [
            "aps" : [
                "alert" : "New notification",
                "content-available" : 1,
                "sound" : "default",
            ],
            "params" : [
                "comments_count" : 0,
                "event_id" : "316b6ed1-d003-48ac-a4a7-8c83884f173d",
                "event_name" : "Wspólny bieg po lesie",
                "msg_timestamp" : 1475513599647,
                "msg_type" : "event_updated",
                "photo_url" : "https://graph.facebook.com/625915570914917/picture?height=400&width=400",
                "timestamp" : 1485542941000,
                "updated_at" : 1475513761864,
                "user_id" : "652a761c-012d-4c2c-92a5-12b2f2562e26",
                "user_name" : "Karol Nowak",
                "uuid" : "b2a10a15-1b27-493c-9563-59d363xcada12d",
            ],
            ]
        return dictionary
    }
    
    internal func samplePushNotificationFour() -> NSDictionary {
        let dictionary = [
            "aps" : [
                "alert" : "New notification",
                "content-available" : 1,
                "sound" : "default",
            ],
            "params" : [
                "comments_count" : 0,
                "event_id" : "316b6ed1-d003-48ac-a4a7-8c83884f173d",
                "event_name" : "Wspólny bieg po lesie",
                "msg_timestamp" : 1475513599647,
                "msg_type" : "user_acceptance",
                "photo_url" : "https://graph.facebook.com/625915570914917/picture?height=400&width=400",
                "timestamp" : 1485542941000,
                "updated_at" : 1475513761864,
                "user_id" : "652a761c-012d-4c2c-92a5-12b2f2562e26",
                "user_name" : "Karol Nowak",
                "uuid" : "b2a10a15-1b27-493c-9563-59ef831da12d",
            ],
            ]
        return dictionary
    }
    
    internal func samplePushNotificationFive() -> NSDictionary {
        let dictionary = [
            "aps" : [
                "alert" : "New notification",
                "content-available" : 1,
                "sound" : "default",
            ],
            "params" : [
                "comments_count" : 0,
                "event_id" : "316b6ed1-d003-48ac-a4a7-8c83884f173d",
                "event_name" : "Wspólny bieg po lesie",
                "msg_timestamp" : 1475513599647,
                "msg_type" : "user_decline",
                "photo_url" : "https://graph.facebook.com/625915570914917/picture?height=400&width=400",
                "timestamp" : 1485542941000,
                "updated_at" : 1475513761864,
                "user_id" : "652a761c-012d-4c2c-92a5-12b2f2562e26",
                "user_name" : "Zbigniew Polski",
                "uuid" : "b2a10a15-1b27-493c-9563-59d36acdda12d",
            ],
            ]
        return dictionary
    }
}
