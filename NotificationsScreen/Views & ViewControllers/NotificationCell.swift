//
//  NotificationCell.swift
//  NotificationsScreen
//
//  Created by Henryk Ratajczak on 23/08/16.
//  Copyright © 2016 Henryk Ratajczak. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate : class {
    func userDidTapProfilePicture(imageView:UIImageView, cell:UITableViewCell)
}

class NotificationCell: UITableViewCell {
    
    static let CellIdentifier: String = "NotificationCell"

	@IBOutlet weak var actorImageView: UIImageView!
	@IBOutlet weak var notificationLabel: UILabel!
    weak var delegate:NotificationCellDelegate?

	override func awakeFromNib() {
		super.awakeFromNib()
		self.setupImageView()
        
		// Clean up Storyboard placeholder data
		self.notificationLabel.text = nil
	}

	private func setupImageView() {
		self.actorImageView.clipsToBounds = true
		self.actorImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        let tapRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageViewTapped))
        self.actorImageView.userInteractionEnabled = true
        self.actorImageView.addGestureRecognizer(tapRecognizer)
	}
    
    @objc private func imageViewTapped() {
        self.delegate?.userDidTapProfilePicture(self.actorImageView, cell: self)
    }
}
