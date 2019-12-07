//
//  ProfileProfilePresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 19/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

class ProfilePresenter {
	private weak var view: ProfileViewType?
	var navigator: ProfileNavigator!
}

extension ProfilePresenter: ProfilePresenterType {
	func attach(view: ProfileViewType) {
		self.view = view
	}

	func viewIsReady() {}
}
