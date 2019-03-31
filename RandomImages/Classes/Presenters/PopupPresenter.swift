//
//  PopupPresenter.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/31/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import Foundation

protocol Popup: class {
	func show()
	func hide()
	func set(title: String, message: String)
}

class PopupPresenter {
	
	// MARK: Private properties
	
	private weak var popupView : Popup?
	
	// MARK: Public methods
	
	public func attach(view: Popup) {
		popupView = view
	}
	
	public func detachView() {
		popupView = nil
	}
	
	public func getInfo() {
		let title = "Created by Vlad Korzun"
		let date = Date()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "d/MM/yy HH:mm"
		let message = "The time now is: \(dateFormatter.string(from: date))."
		popupView?.set(title: title, message: message)
	}
	
}
