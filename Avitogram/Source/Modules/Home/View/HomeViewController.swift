//
//  HomeHomeViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit
import Paparazzo
import ImageSource
import Toast_Swift

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
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "profile").withRenderingMode(.alwaysTemplate), style: .plain, target: self,
																											 action: #selector(profileAction))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
	}
	
	private func showPicker() {
		presenter?.pickImage()
	}

	// MARK: - actions

	@objc private func profileAction() {
		presenter?.profile()
	}

	@objc private func signoutAction() {
		let alert = UIAlertController(title: "sign_out".localized.firstUppercased, message: "sign_out_confirmation".localized.firstUppercased,
																	preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "sign_out".localized.firstUppercased, style: .destructive, handler: { _ in
			self.presenter?.signOut()
		}))
		alert.addAction(UIAlertAction(title: "cancel".localized.firstUppercased, style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}

	@objc private func addAction() {
		showPicker()
	}
}

extension HomeViewController: HomeViewType {
	func set(presenter: HomePresenterType) {
		self.presenter = presenter
	}

	func update(collection: [Post]) {
		(view as? HomeView)?.update(collection: collection)
	}

	func show(message: String) {
		view.makeToast(message, duration: 3.0, position: .top)
	}
}

extension HomeViewController: HomeViewDelegate {
	func refresh() {
		presenter?.refresh()
	}
}
