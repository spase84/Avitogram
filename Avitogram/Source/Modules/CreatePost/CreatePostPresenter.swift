//
//  CreatePostCreatePostPresenter.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation
import ImageSource

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
		if let image = post.image {
			view?.set(image: image)
		}
	}

	func set(imageSource: ImageSource) {
		post.image = imageSource
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
