//
//  ImageService.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/30/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import RxSwift

class ImageService {
	
	// MARK: Public properties
	
	public var images: [Image]?
	
	// MARK: Public methods
	
	public func getImageList() -> Observable<[Image]> {
		let url = "https://gist.githubusercontent.com/VladKorzun/2cca7ba7aeab04c220ebc797ef74302a/raw/b141b602485dffd15fc4571c2b2a0a579f5c3c7e/images.json"
		return Observable.create { observer -> Disposable in
			let request = Alamofire.request(url).validate().responseData { response in
				switch response.result {
				case .success(let data):
					do {
						let images = try data.decoded() as [Image]
						self.images = images
						observer.onNext(images)
						observer.onCompleted()
					} catch let error {
						observer.onError(error)
					}
					
				case .failure(let error):
					observer.onError(error)
				}
			}
			
			return Disposables.create {
				request.cancel()
			}
		}
	}
	
	public func getImage(url: String) -> Observable<UIImage> {
		return Observable.create { observer -> Disposable in
			let request = Alamofire.request(url).responseImage { response in
				if let image = response.result.value {
					observer.onNext(image)
					observer.onCompleted()
				} else if let error = response.error {
					observer.onError(error)
				}
			}
			
			return Disposables.create {
				request.cancel()
			}
		}
	}
	
	public func getTitle(for imageId: Int) -> String {
		return UserDefaults.standard.value(forKey: "imageId:\(imageId)") as? String ?? "Image Title"
	}
	
	public func set(_ title: String, for imageId: Int) {
		UserDefaults.standard.set(title, forKey: "imageId:\(imageId)")
	}
	
}
