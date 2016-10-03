//
//  NotificationReceiver.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 19/09/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

class NotificationReceiver: NSObject {
    
    /*
     We provide a default implementation of the Notification store backed by a .plist.
     Future implementations could be SQLite database, different file format, external API etc,
     hence we abstract to a protocol.
     */
    
    private let persistentStore:NotificationStoreProtocol =  NotificationsPlistStore()
    private let notificationRouter = NotificationRouter()
    
    //MARK: Public methods
    
    func registerForRemoteNotifications() {
        application.registerForRemoteNotifications()
    }
    
    func isRegisteredForRemoteNotifications()->Bool {
        return application.isRegisteredForRemoteNotifications()
    }
    
    func unregisterForRemoteNotifications() {
        application.unregisterForRemoteNotifications()
    }
    
    //MARK: UIApplication callbacks - Registering for Remote Notifications & Failure
    
    func didRegisterApplicationForRemoteNotifications(application:UIApplication, deviceToken:NSData) {

        let deviceTokenString = deviceToken.asDeviceTokenString()
        NSLog("Registered for remote notifications with device token: %@", deviceTokenString)
        
        //In production, the token was register to an Account object and uploaded to the server.
        
    }
    
    func didFailToRegisterApplicationForRemoteNotifications(application:UIApplication, error:NSError) {
        NSLog("Failed to register application token with error: %@", error)
    }
    
    //MARK: UIApplication callbacks - Receiving and Managing Remote Notifications
    
    func applicationDidReceiveRemoteNotification(application:UIApplication, userInfo:NSDictionary, fetchCompletionHandler:((UIBackgroundFetchResult)->())?) {
        
        guard let params = userInfo["params"] as? NSDictionary else {
            return
        }
        if (fetchCompletionHandler != nil) {
            fetchCompletionHandler!(.Failed)
            return
        }
        
        guard let notification = Notification.notificationWithDictionary(params) else {
            if (fetchCompletionHandler != nil) {
            fetchCompletionHandler!(.Failed)
            }
            assert(false)
            NSLog("Failed to create notification with dictionary %@", params)
            return
        }
        
        let shouldStore = !persistentStore.hasNotification(notification)
        if (shouldStore) {
        persistentStore.storeNotification(notification, completion: nil)
        }
        
        if (fetchCompletionHandler != nil) {
        fetchCompletionHandler!(.NewData)
        }
    }
    
    //MARK: Private convenience accessors
    
    private var application:UIApplication {
        get {
            return UIApplication.sharedApplication()
        }
    }
}
