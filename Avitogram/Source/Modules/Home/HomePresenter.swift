//
//  HomeHomePresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation
import RxSwift
import ImageSource

class HomePresenter {
	private weak var view: HomeViewType?
	private var navigator: HomeNavigator!
	private var postService: PostService!
	private var userService: UserService!
	private let disposeBag = DisposeBag()
	
	init(navigator: HomeNavigator, postService: PostService, userService: UserService) {
		self.navigator = navigator
		self.postService = postService
		self.userService = userService
	}

	// MARK: - private

	private func handle(error: Error) {
		view?.show(message: error.localizedDescription)
	}

	private func subscribe() {
		postService.trigger.subscribe(onNext: { event in
			self.updateView()
		})
		.disposed(by: disposeBag)
	}

	private func updateView() {
		postService.getPosts { [weak self] posts, error in
			guard nil == error else { self?.handle(error: error!); return }
			self?.view?.update(collection: posts)
		}
	}
}

extension HomePresenter: HomePresenterType {
	func attach(view: HomeViewType) {
		self.view = view
	}

	func viewIsReady() {
		subscribe()
		updateView()
	}

	func signOut() {
		userService.signOut()
		(AppService.getAppDelegate() as? AppDelegate)?.reloadRootScreen()
	}

	func refresh() {
		updateView()
	}

	func profile() {
		navigator.navigate(to: .profile)
	}

	func pickImage() {
		navigator.navigate(to: .showPicker(completion: { [weak self] items in
			guard let item = items.first else { return }
			self?.navigator.navigate(to: .createPost(imgItem: item))
		}))
	}
}
