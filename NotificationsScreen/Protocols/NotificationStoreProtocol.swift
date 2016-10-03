//
//  NotificationStoreProtocol.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 18/09/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import Foundation

typealias FetchNotificationClosure = (notifications:[Notification],error:NSError?) -> ()
typealias ModifyNotificationClosure = (error:NSError?) -> ()

protocol NotificationStoreProtocol : class {
    //Asynchronous
    func getNotifications(completion:FetchNotificationClosure?)
    func storeNotification(notification:Notification,completion:ModifyNotificationClosure?)
    func deleteNotification(notification:Notification,completion:ModifyNotificationClosure?)
    func deleteAllNotifications(completion:ModifyNotificationClosure?)
    //Synchronous
    func hasNotification(notification:Notification) -> Bool
}
