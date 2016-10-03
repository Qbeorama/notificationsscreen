//
//  Notification+Enums.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 03/10/2016.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import Foundation

enum NotificationType: Int {
    case Unknown
    case FriendInvitation
    case UserAcceptedInvitation
    case UserDeclinedInvitation
    case ParticipantJoined
    case ParticipantLeft
    case EventModified
    case EventCancelled
}

extension Notification {
    
    class func enumFromAPIString(notificationType:String) -> NotificationType {
        switch notificationType {
        case "event_cancelled":
            return NotificationType.EventCancelled
        case "event_updated":
            return NotificationType.EventModified
        case "user_invitation":
            return NotificationType.FriendInvitation
        case "user_acceptance":
            return NotificationType.UserAcceptedInvitation
        case "user_decline":
            return NotificationType.UserDeclinedInvitation
        case "new_participant":
            return NotificationType.ParticipantJoined
        case "leaving_participant":
            return NotificationType.ParticipantLeft
        default:
            //Handle and fix if happens in dev runtime
            assert(false, "Unknown notification type received: \(notificationType), cannot handle!")
            return NotificationType.Unknown
        }
    }
    
    func stringFromEnum() -> String {
        return Notification.stringFromEnum(self.type)
    }
    
    class func stringFromEnum(type:NotificationType) -> String {
        switch type {
        case NotificationType.EventCancelled:
            return "event_cancelled"
        case NotificationType.ParticipantJoined:
            return "new_participant"
        case NotificationType.EventModified:
            return "event_updated"
        case NotificationType.FriendInvitation:
            return "user_invitation"
        case NotificationType.UserAcceptedInvitation:
            return "user_acceptance"
        case NotificationType.UserDeclinedInvitation:
            return "user_decline"
        case NotificationType.ParticipantLeft:
            return "leaving_participant"
        case NotificationType.Unknown:
            return "unknown"
        }
    }

}
