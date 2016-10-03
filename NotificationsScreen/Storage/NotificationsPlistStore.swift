//
//  NotificationsPlistStore.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 18/09/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

class NotificationsPlistStore: NSObject, NotificationStoreProtocol {
    
    static let DataChangedNotification = "NotificationsPlistStoreDataChanged"
    static let DefaultPlistName = "Notifications.plist"
    
    let fileName:String
    
    //MARK: Object lifecycle
    
    init(fileName:String) {
        self.fileName = fileName
        super.init()
    }
    
    override init() {
        self.fileName = NotificationsPlistStore.DefaultPlistName
        super.init()
        self.populateWithPreviewData()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: NotificationStoreProtocol methods - public and called asynchronously
    
    func getNotifications(completion:FetchNotificationClosure?) {
    
        //Fetch objects in background
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))  { [weak self] in
            if (self == nil){
                return
            }
            let fetchedNotifications = self!.fetchNotificationsSync()
            
            //Act upon fetched objects on main thread
            dispatch_async(dispatch_get_main_queue()) {
                if (completion == nil){
                    return
                }
                completion!(notifications: fetchedNotifications, error: nil)
            }
        }
    }
    
    func storeNotification(notification: Notification, completion: ModifyNotificationClosure?) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))  { [weak self] in
            
            if (self == nil) {
                return
            }
            
            let saveError = self!.storeNotificationSync(notification)
            
            dispatch_async(dispatch_get_main_queue()) {
                if (completion == nil){
                    return
                }
                completion!(error: saveError)
            }
        }
    }
    
    func deleteNotification(notification: Notification, completion: ModifyNotificationClosure?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))  { [weak self] in
            
            if (self == nil) {
                return
            }
            
            let optionalError = self!.deleteNotificationSync(notification)
            
            dispatch_async(dispatch_get_main_queue()) {
                if (completion == nil){
                    return
                }
                completion!(error: optionalError)
            }
        }
    }
    
    func deleteAllNotifications(completion: ModifyNotificationClosure?) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))  { [weak self] in
            
            if (self == nil) {
                return
            }
            
            let optionalError = self!.deleteAllNotificationsSync()
            
            dispatch_async(dispatch_get_main_queue()) {
                if (completion == nil){
                    return
                }
                completion!(error: optionalError)
            }
        }

    }
    
    func hasNotification(notification:Notification) -> Bool {
        let notifications = self.fetchNotificationsSync()
        return notifications.contains(notification)
    }
    
    //MARK: Private methods called synchronously
    
    private func deleteNotificationSync(notification:Notification) -> NSError? {
    
        let currentNotifications = self.fetchNotificationsSync()
        
        var notificationsCopy = currentNotifications
        for someNotification in currentNotifications where someNotification == notification {
            guard let index = notificationsCopy.indexOf(someNotification) else {
                continue
            }
            notificationsCopy.removeAtIndex(index)
        }
        return saveNotificationsSync(notificationsCopy)
    }
    
    private func deleteAllNotificationsSync()-> NSError? {
        return deleteOldPlistFileIfExists()
    }
    
    private func storeNotificationSync(notification:Notification) ->NSError? {
        var currentNotifications = self.fetchNotificationsSync()
        currentNotifications.append(notification)
        return saveNotificationsSync(currentNotifications)
    }
    
    private func fetchNotificationsSync() -> [Notification] {
        
        let plistPath = getDefaultPlistSavePath()
        let fileExists = NSFileManager().fileExistsAtPath(plistPath)
        if (!fileExists) {
            return []
        }
        
        let rawNotifications = NSArray.init(contentsOfFile: plistPath)
        assert(rawNotifications != nil)
        var notifications:[Notification] = []
        for dictionary in rawNotifications! {
            guard let notification = Notification.notificationWithDictionary(dictionary as! NSDictionary) else {
                continue
            }
            notifications.append(notification)
        }
        return notifications
    }
    
    internal func saveNotificationsSync(notifications:[Notification]) -> NSError? {
        let array = NSMutableArray()
        for notification in notifications {
            let dictionaryForm = notification.toDictionary()
            array.addObject(dictionaryForm)
        }
        let optionalError = deleteOldPlistFileIfExists()
        if (optionalError != nil){
            return optionalError
        }
        let filePath = getDefaultPlistSavePath()
        let success = array.writeToFile(filePath, atomically: true)
        if (!success) {
            return NSError.init(domain: "com.sampleProject", code: -2, userInfo: ["description":"Failed to save .plist to file."])
        }
        NSNotificationCenter.defaultCenter().postNotificationName(NotificationsPlistStore.DataChangedNotification, object: nil)
        return nil
    }
    
    
    private func deleteOldPlistFileIfExists() -> NSError? {
        let filePath = getDefaultPlistSavePath()
        let fileExists = NSFileManager().fileExistsAtPath(filePath)
        if (!fileExists) {
            //Not an error.
            return nil
        }
        do {
            try  NSFileManager().removeItemAtPath(filePath)
        } catch {
            return NSError.init(domain: "com.sampleProject", code: -1, userInfo: ["description":"Failed to delete plist file."])
        }
        return nil
    }
    
    //MARK: Accessors
    
    private func getDefaultPlistSavePath() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        let plistPath = (documentsPath! as NSString).stringByAppendingPathComponent(fileName)
        return plistPath
    }
}
