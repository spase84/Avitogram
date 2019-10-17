//
//  HomeHomePresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

class HomePresenter {
	private weak var view: HomeViewType?
	private var navigator: HomeNavigator!
	private var postService: PostService!
	
	init(navigator: HomeNavigator, postService: PostService) {
		self.navigator = navigator
		self.postService = postService
	}
}

extension HomePresenter: HomePresenterType {
	func attach(view: HomeViewType) {
		self.view = view
	}

	func viewIsReady() {
		let collection = postService.getPosts { posts, error in
			debugPrint(posts, error)
		}
	}
}
