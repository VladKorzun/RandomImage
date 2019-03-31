//
//  ImageListPresenter.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/30/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import UIKit
import RxSwift

protocol ImageListView: class {
	
	func set(image: UIImage, for index: Int)
	
}

class ImageListPresenter {
	
	// MARK: Public properties
	
	public var images: [Image] {
		if let images = imageService?.images {
			return images
		} else {
			return [Image]()
		}
	}
	
	// MARK: Private properties
	
	private weak var imageListView : ImageListView?
	private var imageService: ImageService? {
		return parentPresenter?.imageService
	}
	private weak var parentPresenter: ImagePresenter?
	private let disposeBag = DisposeBag()
	
	// MARK: Instance initialization
	
	init(parentPresenter: ImagePresenter) {
		self.parentPresenter = parentPresenter
	}
	
	// MARK: Public methods
	
	public func attachView(view: ImageListView) {
		imageListView = view
	}
	
	public func detachView() {
		imageListView = nil
	}
	
	public func getTitle(forCellAt index: Int) -> String? {
		return imageService?.getTitle(for: index)
	}
	
	public func getImage(forCellAt index: Int) {
		guard let url = imageService?.images?[index].url else {
			return
		}
		imageService?.getImage(url: url).subscribe(onNext: { [weak self] image in
			self?.imageListView?.set(image: image, for: index)
		}).disposed(by: disposeBag)
	}
	
	public func select(_ image: Image) {
		parentPresenter?.currentImage = image
	}
	
}
