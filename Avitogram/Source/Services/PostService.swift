//
//  PostService.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

protocol PostService {
	func getPosts(completion: @escaping (_ posts: [Post], _ error: Error?) -> Void)
}

final class PostServiceImpl: PostService {
	private var provider: PostProvider!

	init(provider: PostProvider) {
		self.provider = provider
	}

	func getPosts(completion: @escaping ([Post], Error?) -> Void) {
		provider.getCollection(completion: { (collection, error) in
			completion(collection, error)
		})
	}
}
