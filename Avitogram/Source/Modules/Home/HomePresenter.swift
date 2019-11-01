//
//  HomeHomePresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation

class HomePresenter {
	private weak var view: HomeViewType?
	private var navigator: HomeNavigator!
	private var postService: PostService!
	private var userService: UserService!
	
	init(navigator: HomeNavigator, postService: PostService, userService: UserService) {
		self.navigator = navigator
		self.postService = postService
		self.userService = userService
	}

	// MARK: - private

	private func handle(error: Error) {
		debugPrint(error.localizedDescription)
	}
}

extension HomePresenter: HomePresenterType {
	func attach(view: HomeViewType) {
		self.view = view
	}

	func viewIsReady() {
		postService.getPosts { [weak self] posts, error in
			guard nil == error else { self?.handle(error: error!); return }
			self?.view?.update(collection: posts)
		}
	}

	func signOut() {
		userService.signOut()
		(AppService.getAppDelegate() as? AppDelegate)?.reloadRootScreen()
	}

	func imagePicked(data: Data) {
		debugPrint(data)
	}
}
