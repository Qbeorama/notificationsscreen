//
//  AppDelegate.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let notificationReceiver = NotificationReceiver()
    
    //MARK: UIApplicationDelegate methods

    func applicationDidFinishLaunching(application: UIApplication) {
        registerNotificationSettings();
    }
    
    func registerNotificationSettings(){
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound]
        let settings = UIUserNotificationSettings.init(forTypes: notificationTypes, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        notificationReceiver.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        notificationReceiver.didRegisterApplicationForRemoteNotifications(application, deviceToken: deviceToken)
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        notificationReceiver.applicationDidReceiveRemoteNotification(application, userInfo: userInfo, fetchCompletionHandler: completionHandler)
    }
    
}

