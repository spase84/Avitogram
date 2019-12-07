//
//  ProfileProfileViewController.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 19/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
	private var presenter: ProfilePresenterType?
	
	// MARK: Life cycle

	override func loadView() {
		view = ProfileView(delegate: self)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.viewIsReady()
	}

	// MARK: - private

	internal override func setupUI() {
		super.setupUI()
		navigationItem.title = "profile".localized.firstUppercased
	}
}

extension ProfileViewController: ProfileViewType {
	func set(presenter: ProfilePresenterType) {
		self.presenter = presenter
	}
}

extension ProfileViewController: ProfileViewDelegate {}
