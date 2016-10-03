//
//  NotificationRouter.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 21/09/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

class NotificationRouter: NSObject {
    
    weak var parentViewController:UIViewController?
    
    func routeNotification(notification:Notification) {
        
        let goToEvent = shouldRouteToEvent(notification)
        if (goToEvent){
            routeToEventScreen(notification)
            return
        }
        
        let goToProfile = shouldRouteToUserProfile(notification)
        if (goToProfile){
            routeToUserProfileScreen(notification)
            return
        }
        
        //At this version of production code, not all notifications produce an action when tapped.
    }
    
    func routeToEventScreen(notification:Notification) {
        
        //In production, we pass in destinationId to the child view controller needed to load more data in next screen.
        guard let destinationId = notification.eventId else {
            assert(false, "Attempting to route to event screen from a notification that does not contain eventId.")
            return
        }
        let storyboard = self.parentViewController?.storyboard
        guard let eventDetails = storyboard?.instantiateViewControllerWithIdentifier("EventDetailsController") else {
            return
        }
        self.parentViewController?.showViewController(eventDetails, sender: nil)
        NSLog("Loading event details for %@", destinationId)
        
    }
    
    func routeToUserProfileScreen(notification:Notification) {
        
        //In production, we pass in destinationId to the child view controller needed to load more data in next screen.
        guard let userProfileId = notification.actorId else {
            assert(false, "Attempting to route to event screen from a notification that does not contain eventId.")
            return
        }
        let storyboard = self.parentViewController?.storyboard
        guard let userProfile = storyboard?.instantiateViewControllerWithIdentifier("UserProfileController") else {
            return
        }
        self.parentViewController?.showViewController(userProfile, sender: nil)
        NSLog("Loading event details for %@", userProfileId)
    }
    
    private func shouldRouteToEvent(notification:Notification)->Bool {
        switch notification.type {
        case .EventModified,.ParticipantJoined,.ParticipantLeft:
            return true
        default:
            return false
        }
    }
    
    private func shouldRouteToUserProfile(notification:Notification)->Bool {
        switch notification.type {
        case .FriendInvitation,.UserAcceptedInvitation,.UserDeclinedInvitation:
            return true
        default:
            return false
        }
    }
    
    //MARK: Convenience accessor
    
    private func currentApplicationState() -> UIApplicationState {
        let application = UIApplication.sharedApplication()
        let currentState = application.applicationState
        return currentState
    }
}
