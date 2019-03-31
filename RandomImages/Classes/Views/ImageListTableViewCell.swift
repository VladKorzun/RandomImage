//
//  ImageListTableViewCell.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/30/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import UIKit

class ImageListTableViewCell: UITableViewCell {
	
	// MARK: IB outlets

	@IBOutlet private weak var pictureView: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var numberLabel: UILabel!
	
	// MARK: Public properties
	
	public var number: Int? {
		didSet {
			if let number = number {
				numberLabel.text = "#\(number)"
			} else {
				numberLabel.text = nil
			}
		}
	}
	
	public var title: String? {
		didSet {
			titleLabel.text = title
		}
	}
	
	public var picture: UIImage? {
		didSet {
			pictureView.image = picture
		}
	}

}
