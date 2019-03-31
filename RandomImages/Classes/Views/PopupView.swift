//
//  PopupView.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/31/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import UIKit

class PopupView: UIView, Popup {
	
	// MARK: IB outlets
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var messageLabel: UILabel!
	
	// MARK: Private properties
	
	private let presenter = PopupPresenter()
	
	// MARK: Instance initialization
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		initialize()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		initialize()
	}
	
	private func initialize() {
		fromNib()
		
		presenter.attach(view: self)
	}
	
	// MARK: Interface methods
	
	public func show() {
		if let window = UIApplication.shared.keyWindow {
			presenter.getInfo()
			window.addSubview(self)
			constraintsToSuperview()
			frame = window.frame
			window.bringSubviewToFront(self)
		}
	}
	
	public func hide() {
		removeFromSuperview()
	}
	
	public func set(title: String, message: String) {
		titleLabel.text = title
		messageLabel.text = message
	}
	
	// MARK: IB actions
	
	@IBAction private func hide(sender: Any) {
		hide()
	}
	
}
