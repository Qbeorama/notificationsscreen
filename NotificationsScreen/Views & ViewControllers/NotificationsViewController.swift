//
//  NotificationsViewController.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 23/08/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController, NotificationsDataSourceDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var placeholderTextContainerView: UIView!
    @IBOutlet weak var placeholderTextLabel: UILabel!
    
    private lazy var notificationRouter:NotificationRouter = {
     let router = NotificationRouter()
        router.parentViewController = self
        return router
    }()
    
	@IBOutlet var dataSource: NotificationsDataSource! {
		didSet {
			dataSource.delegate = self
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
        self.title = NSLocalizedString("Notifications", comment: "")
        self.subscribeToNotificationCenter()
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
        self.updatePlaceholderViewVisibility()
        self.reloadData()
	}
        
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: NotificationsPlistStore.DataChangedNotification, object: nil)
    }
    
    //MARK: Public methods
    
    func reloadData(){
        self.dataSource.getNotifications { [weak self] (notifications, error) in
            self?.updatePlaceholderViewVisibility()
            self?.tableView.reloadData()
        }
    }
    
    // MARK: NotificationsDataSourceDelegate methods
    
    func userDidTapNotification(dataSource: NotificationsDataSource, notification: Notification, cell: UITableViewCell) {
        self.notificationRouter.routeNotification(notification)
    }
    
    func userDidTapProfilePicture(notification: Notification, cell: UITableViewCell) {
        self.notificationRouter.routeToUserProfileScreen(notification)
    }
    
    func notificationTapResultedInError(notification: Notification, error: NSError) {
        /* In production, the user is presented with a dialog informing him
         about the reason why loading the notification failed, ie. user does not exist anymore etc. */
        NSLog("Error while loading notification: %@", error)
    }
    
    //MARK: Private methods

    private func subscribeToNotificationCenter(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NotificationsViewController.reloadData), name: NotificationsPlistStore.DataChangedNotification, object: nil)
    }
    
    private func updatePlaceholderViewVisibility(){
        if (self.dataSource.notifications == nil){
            self.placeholderView.alpha = 0.0
            self.placeholderView.hidden = true
            return
        }
        let hasNotifications = self.dataSource.notifications!.count > 0
        self.placeholderView.alpha = hasNotifications ? 1.0 : 0.0
        self.placeholderView.hidden = hasNotifications
    }
}
