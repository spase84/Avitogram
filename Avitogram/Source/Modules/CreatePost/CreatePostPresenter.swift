//
//  CreatePostCreatePostPresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation

class CreatePostPresenter {
	private weak var view: CreatePostViewType?
	var navigator: CreatePostNavigator!
	private var postService: PostService!
	private var post = Post()

	init(view: CreatePostViewType, postService: PostService) {
		self.view = view
		self.postService = postService
		post.userId = UserServiceImpl.currentUser.id
	}
}

extension CreatePostPresenter: CreatePostPresenterType {
	func viewIsReady() {
		if let data = post.image {
			view?.set(imageData: data)
		}
	}

	func set(imgData: Data) {
		post.image = imgData
	}

	func done(title: String) {
		post.title = title
		postService.create(post: post) { [weak self] error in
			if let error = error {
				self?.view?.show(message: error.localizedDescription)
			} else {
				// success
				self?.view?.unfreeze()
				self?.navigator.navigateBack()
			}
		}
	}
}
