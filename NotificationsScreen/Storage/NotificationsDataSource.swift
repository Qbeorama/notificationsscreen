//
//  NotificationsDataSource.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 23/08/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

protocol NotificationsDataSourceDelegate: class {
    func userDidTapProfilePicture(notification: Notification, cell: UITableViewCell)
	func userDidTapNotification(dataSource: NotificationsDataSource, notification: Notification, cell: UITableViewCell)
    func notificationTapResultedInError(notification:Notification, error:NSError)
}

class NotificationsDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, NotificationCellDelegate {
    
    static let EstimatedRowHeight = 100.0
    
	var notifications: [Notification]?
	var delegate: NotificationsDataSourceDelegate?
	let stringFormatter = AttributedStringFormatter()
    let persistentStore = NotificationsPlistStore()

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.rowHeight = UITableViewAutomaticDimension
		}
	}
    
    func getNotifications(completion:FetchNotificationClosure?){
        self.persistentStore.getNotifications({ (fetchedNotifications, error) in
            self.notifications = fetchedNotifications
            self.sortNotifications()
            if (completion != nil) {
                completion!(notifications: fetchedNotifications, error: error)
            }
        })
    }
    
    private func deleteNotification(notification:Notification){
        self.persistentStore.deleteNotification(notification, completion: nil)
    }
    
    private func sortNotifications() {
        if (self.notifications == nil){
            return
        }
        self.notifications!.sortInPlace { (first: Notification, second: Notification) -> Bool in
            let descendingChronogically = (first.timestamp.compare(second.timestamp) == NSComparisonResult.OrderedDescending)
            return descendingChronogically
        }
    }

	// MARK: UITableViewDataSource methods

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let notification = self.notifications?[indexPath.row] else {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCellWithIdentifier(NotificationCell.CellIdentifier) as? NotificationCell else {
            return UITableViewCell()
        }
        
        cell.notificationLabel.attributedText = stringFormatter.attributedStringForNotification(notification)
        cell.actorImageView.setImageWithURL(NSURL.init(string: notification.imageURL)!)
        cell.delegate = self
		return cell
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.notifications?.count else {
            return 0
        }
        return count
	}

	// MARK: UITableViewDelegate methods

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		guard let tableViewCell = tableView.cellForRowAtIndexPath(indexPath) else {
            return
		}
        guard let notification = notifications?[indexPath.row] else {
            return
        }
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
		self.delegate?.userDidTapNotification(self, notification: notification, cell: tableViewCell)
	}

	func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return CGFloat(NotificationsDataSource.EstimatedRowHeight)
	}

	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
    
    //MARK: NotificationCellDelegate methods
    
    func userDidTapProfilePicture(imageView: UIImageView, cell: UITableViewCell) {
        guard let index = self.tableView.indexPathForCell(cell) else {
            return
        }
        guard let notification = self.notifications?[index.row] else {
            return
        }
        self.delegate?.userDidTapProfilePicture(notification, cell: cell)
    }
}
