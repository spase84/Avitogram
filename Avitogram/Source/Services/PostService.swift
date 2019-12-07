//
//  PostService.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import RxSwift

protocol PostService {
	var trigger: PublishSubject<TriggerEvent> { get }
	func getPosts(completion: @escaping (_ posts: [Post], _ error: Error?) -> Void)
	func create(post: Post, completion: @escaping (_ error: Error?) -> Void)
}

final class PostServiceImpl: PostService {
	private var provider: PostProvider!
	private var storageService: StorageService!
	
	private(set) var trigger: PublishSubject<TriggerEvent> = PublishSubject<TriggerEvent>()

	init(provider: PostProvider, storageService: StorageService) {
		self.provider = provider
		self.storageService = storageService
	}

	func getPosts(completion: @escaping ([Post], Error?) -> Void) {
		provider.getCollection(completion: { (collection, error) in
			completion(collection, error)
		})
	}

	func create(post: Post, completion: @escaping (Error?) -> Void) {
		if let error = validate(post: post).first {
			return completion(error)
		}
		guard let imgData = post.image else { return completion(Post.ValidationError.imageEmpty) }
		imgData.fullResolutionImageData { data in
			guard let imgData = data else { return }
			self.storageService.create(data: imgData) { name, error in
				guard nil == error else { return completion(error) }
				var post = post
				post.imageName = name
				self.provider.create(post: post) { error in
					self.trigger.onNext(.saved)
					completion(error)
				}
			}
		}
	}

	// MARK: - private

	private func validate(post: Post) -> [Post.ValidationError] {
		var errors = [Post.ValidationError]()
		if post.title.isEmpty {
			errors.append(Post.ValidationError.titleEmpty)
		}
		if nil == post.image {
			errors.append(Post.ValidationError.imageEmpty)
		}
		if nil == post.userId {
			errors.append(Post.ValidationError.userIdEmpty)
		}
		return errors
	}
}
