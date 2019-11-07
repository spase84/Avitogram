//
//  PostProvider.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage

protocol PostProvider: BaseProvider {
	func getCollection(completion: @escaping (_ collection: [Post], _ error: Error?) -> Void)
	func create(post: Post, completion: @escaping (_ error: Error?) -> Void)
}

final class PostProviderImpl: PostProvider {
	internal var collectionName = "posts"
	private let db = Firestore.firestore()

	func getCollection(completion: @escaping (_ collection: [Post], _ error: Error?) -> Void) {
		db.collection(collectionName)
//			.whereField(Post.Fields.userId.rawValue, isEqualTo: UserServiceImpl.currentUser.id ?? "")
			.order(by: Post.Fields.createdAt.rawValue, descending: true)
			.getDocuments { snapshot, error in
				guard nil == error else { completion([], error!); return }
				guard let snapshot = snapshot else { completion([], nil); return }
				let collection = snapshot.documents.compactMap { document -> Post? in
					guard var post = try? document.data(as: Post.self) else { return nil }
					guard let imageName = post.imageName else { return post }
					post.reference = Storage.storage().reference().child("images/\(imageName)")
					return post
				}
				completion(collection, nil)
		}
	}

	func create(post: Post, completion: @escaping (Error?) -> Void) {
		do {
			_ = try db.collection(collectionName).addDocument(from: post)
			completion(nil)
			return
		} catch {
			completion(error)
		}
	}
}
