//
//  AttributedStringFormatter.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 23/08/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

class AttributedStringFormatter: NSObject {
    
    let styleProvider = TextStyleDataSource()

	func attributedStringForNotification(notification: Notification) -> NSAttributedString {
		var attributedString: NSAttributedString
		switch notification.type {
		case .FriendInvitation:
			attributedString = friendInvitationString(notification)
		case .ParticipantJoined:
			attributedString = newParticipantString(notification)
        case .ParticipantLeft:
            attributedString = participantLeftString(notification)
		case .EventModified:
			attributedString = eventModifiedString(notification)
		case .EventCancelled:
			attributedString = eventCancelledString(notification)
        case .UserAcceptedInvitation:
            attributedString = userAcceptedInvitationString(notification)
        case .UserDeclinedInvitation:
            attributedString = userDeclinedInvitationString(notification)
        case .Unknown:
            assert(false, "Returning empty string from AttributedStringFormatter.attributedStringForNotification() - Unknown type passed into method!")
            attributedString = NSAttributedString()
		}
		return attributedString
	}

	// MARK: Constructor for a localized NSAttributedString for every type of Notification

	private func friendInvitationString(notification: Notification) -> NSAttributedString {
		let localizedString = NSLocalizedString("%@ has sent you a friend request", comment: "") as NSString
		let result = self.attributedStringWithOneHighlightedArgument(localizedString, highlight: notification.actorName!)
		return result
	}

	private func newParticipantString(notification: Notification) -> NSAttributedString {
		let localizedString = NSLocalizedString("%@ has joined %@", comment: "") as NSString
		let result = self.attributedStringWithTwoHighlightedArguments(localizedString, firstHighlight: notification.actorName!, secondHighlight: notification.eventName!)
		return result
	}
    
    private func participantLeftString(notification: Notification) -> NSAttributedString {
        let localizedString = NSLocalizedString("%@ has left %@", comment: "") as NSString
        let result = self.attributedStringWithTwoHighlightedArguments(localizedString, firstHighlight: notification.actorName!, secondHighlight: notification.eventName!)
        return result
    }
    
    private func userAcceptedInvitationString(notification: Notification) -> NSAttributedString {
        let localizedString = NSLocalizedString("%@ has accepted your friend invitation", comment: "") as NSString
        let result = self.attributedStringWithOneHighlightedArgument(localizedString, highlight: notification.actorName!)
        return result
    }
    
    private func userDeclinedInvitationString(notification: Notification) -> NSAttributedString {
        let localizedString = NSLocalizedString("%@ has declined your friend invitation", comment: "") as NSString
        let result = self.attributedStringWithOneHighlightedArgument(localizedString, highlight: notification.actorName!)
        return result
    }

	private func eventModifiedString(notification: Notification) -> NSAttributedString {
		let localizedString = NSLocalizedString("%@ details were changed by %@", comment: "") as NSString
		let result = self.attributedStringWithTwoHighlightedArguments(localizedString, firstHighlight: notification.eventName!, secondHighlight: notification.actorName!)
		return result
	}

	private func eventCancelledString(notification: Notification) -> NSAttributedString {
		let localizedString = NSLocalizedString("%@ was cancelled by %@", comment: "") as NSString
		let result = self.attributedStringWithTwoHighlightedArguments(localizedString, firstHighlight: notification.eventName!, secondHighlight: notification.actorName!)
		return result
	}

	// MARK: Localized NSAttributedString formatting

    /* Perhaps I'm missing some Cocoa/Swift API that will make this code redundant,
       but constructing NSAttributedStrings while using NSLocalizedString macros makes
       it impossible to conveniently use stringWithFormat: approach */

	private func attributedStringWithOneHighlightedArgument(string: NSString, highlight: NSString) -> NSAttributedString {
		let attributedMutableString = NSMutableAttributedString.init(string: string as String, attributes: self.defaultStringStyle())
		let range = string.rangeOfString("%@")
		let attributedActorName = NSAttributedString.init(string: highlight as String, attributes: self.highlightedStringStyle())
		attributedMutableString.replaceCharactersInRange(range, withAttributedString: attributedActorName)
		let result = attributedMutableString.copy() as! NSAttributedString
		return result
	}

	private func attributedStringWithTwoHighlightedArguments(string: NSString, firstHighlight: NSString, secondHighlight: NSString) -> NSAttributedString {
		var mutableString = string
		let attributedMutableString = NSMutableAttributedString.init(string: mutableString as String, attributes: self.defaultStringStyle())

		var replacementRange = mutableString.rangeOfString("%@")
		let attributedActorName = NSAttributedString.init(string: firstHighlight as String, attributes: self.highlightedStringStyle())
		attributedMutableString.replaceCharactersInRange(replacementRange, withAttributedString: attributedActorName)

		mutableString = attributedMutableString.string
		replacementRange = mutableString.rangeOfString("%@")
		let attributedRecipientName = NSAttributedString.init(string: secondHighlight as String, attributes: self.highlightedStringStyle())
		attributedMutableString.replaceCharactersInRange(replacementRange, withAttributedString: attributedRecipientName)

		let result = attributedMutableString.copy() as! NSAttributedString
		return result
	}

	// MARK: NSAttributedString styles

	private func defaultStringStyle() -> [String: AnyObject] {
        //TODO: fetch style
        let style = self.styleProvider.defaultTextStyle
		let attributedStringDictionary = [NSForegroundColorAttributeName: style.fontColor, NSFontAttributeName: style.font]
		return attributedStringDictionary
	}

	private func highlightedStringStyle() -> [String: AnyObject] {
        let style = self.styleProvider.highlightedTextStyle
		let attributedStringDictionary = [NSForegroundColorAttributeName: style.fontColor, NSFontAttributeName:style.font]
		return attributedStringDictionary
	}
}
