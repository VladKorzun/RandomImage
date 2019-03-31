//
//  ImageListViewController.swift
//  RandomImages
//
//  Created by Vladyslav Korzun on 3/30/19.
//  Copyright © 2019 VladKorzun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ImageListViewController: UIViewController, ImageListView {
	
	// MARK: IB outlets

	@IBOutlet private weak var tableView: UITableView!
	
	// MARK: Public properties
	
	public var presenter: ImageListPresenter!
	
	// MARK: Private properties
	
	private let disposeBag = DisposeBag()
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		presenter.attachView(view: self)
		setupTableView()
    }
	
	// MARK: Public methods
	
	public func set(image: UIImage, for index: Int) {
		if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ImageListTableViewCell {
			cell.picture = image
		}
	}
	
	// MARK: Private methods
	
	private func setupTableView() {
		Observable.just(presenter.images).bind(to: tableView.rx
			.items(cellIdentifier: String(describing: ImageListTableViewCell.self), cellType: ImageListTableViewCell.self)) { [weak self] row, element, cell in
				cell.number = row + 1
				cell.title = self?.presenter.getTitle(forCellAt: row)
				cell.picture = nil
				self?.presenter.getImage(forCellAt: row)
			}
			.disposed(by: disposeBag)
		
		tableView.rx
			.modelSelected(Image.self)
			.subscribe(onNext:  { [weak self] image in
				self?.presenter.select(image)
				self?.navigationController?.popViewController(animated: true)
			})
			.disposed(by: disposeBag)
	}
	
}
