//
//  ImagePresenter.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/30/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import RxSwift

protocol ImageView: class {
	func startLoading()
	func stopLoading()
	func set(_ title: String)
	func set(_ image: UIImage)
}

class ImagePresenter {
	
	// MARK: Public properties
	
	public let imageService = ImageService()
	public var currentImage: Image? {
		didSet {
			if let image = currentImage {
				updateView(with: image)
			}
		}
	}
	
	// MARK: Private properties
	
	private weak var imageView : ImageView?
	private let disposeBag = DisposeBag()
	
	// MARK: Public methods
	
	public func attach(view: ImageView) {
		imageView = view
	}
	
	public func detachView() {
		imageView = nil
	}
	
	public func getRandomImage() {
		imageView?.startLoading()
		if let randomImage = imageService.images?.randomElement() {
			currentImage = randomImage
			return
		}
		
		imageService.getImageList().subscribe(onNext: { [weak self] images in
			if let randomImage = images.randomElement() {
				self?.currentImage = randomImage
			}
		}).disposed(by: disposeBag)
	}
	
	public func set(_ title: String) {
		if let image = currentImage {
			imageService.set(title, for: image.id)
		}
	}
	
	// MARK: Private methods
	
	private func updateView(with randomImage: Image) {
		imageView?.set(imageService.getTitle(for: randomImage.id))
		
		imageService.getImage(url: randomImage.url).subscribe(onNext: { [weak self] image in
			self?.imageView?.set(image)
		}, onCompleted: { [weak self] in
			self?.imageView?.stopLoading()
		}).disposed(by: disposeBag)
	}
	
}
