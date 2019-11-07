//
//  HomeView.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import EasyPeasy
import RxSwift
import RxCocoa

protocol HomeViewDelegate: class {
	func refresh()
}

final class HomeView: BaseView {
	private weak var delegate: HomeViewDelegate?
	private let data = PublishSubject<[Post]>()
	
	// MARK: - subviews

	private let tableView: UITableView = {
		let table = UITableView()
		table.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
		table.separatorStyle = .none
		table.backgroundColor = .clear
		table.tableFooterView = UIView()
		table.showsVerticalScrollIndicator = false
		table.showsHorizontalScrollIndicator = false
		return table
	}()

	private let refresher: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.tintColor = .SLDullYellow
		return refreshControl
	}()

	// MARK: - inits
	init(delegate: HomeViewDelegate) {
		super.init(frame: .zero)
		self.delegate = delegate
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: - methods
	func prepareView() {
		addSubview(tableView)
		tableView.easy.layout(Edges(), Bottom(10))
		bindTable()
		refresher.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
		tableView.refreshControl = refresher
	}

	func update(collection: [Post]) {
		data.onNext(collection)
		refresher.endRefreshing()
	}

	// MARK: - private

	private func bindTable() {
		data.bind(to: tableView.rx.items(cellIdentifier: PostCell.identifier, cellType: PostCell.self)) { _, post, cell in
			cell.value = post
		}.disposed(by: disposeBag)
	}

	// MARK: - actions

	@objc private func refreshAction() {
		delegate?.refresh()
	}
}
