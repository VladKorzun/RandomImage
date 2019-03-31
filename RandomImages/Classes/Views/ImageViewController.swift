//
//  ImageViewController.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/30/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import UIKit
import RxSwift

class ImageViewController: UIViewController, ImageView {
	
	// MARK: IB outlets
	
	@IBOutlet private weak var titleTextField: UITextField!
	@IBOutlet private weak var imageView: UIImageView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK: Private properties
	
	private let presenter = ImagePresenter()
	private let disposeBag = DisposeBag()
	private var popupView: PopupView?
	
	// MARK: View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.attach(view: self)
		setupTextField()
		showRandomImage(self)
	}
	
	// MARK: Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == String(describing: ImageListViewController.self), let vc = segue.destination as? ImageListViewController {
			vc.presenter = ImageListPresenter(parentPresenter: presenter)
		}
	}
	
	// MARK: Public methods
	
	public func startLoading() {
		titleTextField.isHidden = true
		imageView.isHidden = true
		activityIndicator.startAnimating()
	}
	
	public func stopLoading() {
		titleTextField.isHidden = false
		imageView.isHidden = false
		activityIndicator.stopAnimating()
	}
	
	public func set(_ title: String) {
		titleTextField.text = title
	}
	
	public func set(_ image: UIImage) {
		imageView.image = image
	}
	
	// MARK: Private methods
	
	private func setupTextField() {
		titleTextField.rx.controlEvent([.editingDidEndOnExit]).subscribe { [weak self] text in
			if let title = self?.titleTextField.text {
				self?.presenter.set(title)
			}
		}.disposed(by: disposeBag)
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
	}
	
	@objc private func dismissKeyboard() {
		view.endEditing(true)
	}
	
	@objc private func hidePopup() {
		popupView?.hide()
		popupView = nil
	}

	// MARK: IB actions
	
	@IBAction private func showRandomImage(_ sender: Any) {
		presenter.getRandomImage()
	}
	
	@IBAction private func showPopup(_ sender: Any) {
		popupView = PopupView()
		popupView?.show()
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hidePopup), object: nil)
		perform(#selector(hidePopup), with: nil, afterDelay: 10.0)
	}
	
}
