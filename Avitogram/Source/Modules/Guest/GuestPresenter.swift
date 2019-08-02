//
//  GuestGuestPresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31/07/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

class GuestPresenter {
	private weak var view: GuestViewType?
	var navigator: GuestNavigator!
}

extension GuestPresenter: GuestPresenterType {
	func attach(view: GuestViewType) {
		self.view = view
	}

	func viewIsReady() {}
}
