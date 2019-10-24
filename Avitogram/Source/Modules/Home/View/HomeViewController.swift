//
//  HomeHomeViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
	private var presenter: HomePresenterType?
	
	// MARK: Life cycle

	override func loadView() {
		view = HomeView(delegate: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		(view as? HomeView)?.prepareView()
		setupNavigationBar()
		presenter?.viewIsReady()
	}

	// MARK: - private

	private func setupNavigationBar() {
		navigationItem.title = "home".localized.firstUppercased
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "sign_out".localized.firstUppercased, style: .plain, target: self,
																											 action: #selector(signoutAction))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
	}

	// MARK: - actions

	@objc private func signoutAction() {
		
	}

	@objc private func addAction() {
		
	}
}

extension HomeViewController: HomeViewType {
	func set(presenter: HomePresenterType) {
		self.presenter = presenter
	}

	func update(collection: [Post]) {
		(view as? HomeView)?.update(collection: collection)
	}
}

extension HomeViewController: HomeViewDelegate {}
