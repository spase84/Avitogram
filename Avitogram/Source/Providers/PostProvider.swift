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

protocol PostProvider: BaseProvider {
	func getCollection(completion: @escaping (_ collection: [Post], _ error: Error?) -> Void)
}

final class PostProviderImpl: PostProvider {
	internal var collectionName = "posts"
	private let db = Firestore.firestore()

	func getCollection(completion: @escaping (_ collection: [Post], _ error: Error?) -> Void) {
		db.collection(collectionName)
//			.whereField(Post.Fields.userId.rawValue, isEqualTo: UserServiceImpl.currentUser.id ?? "")
			.getDocuments { snapshot, error in
				guard nil == error else { completion([], error!); return }
				guard let snapshot = snapshot else { completion([], nil); return }
				let collection = snapshot.documents.compactMap { document -> Post? in
					return try? document.data(as: Post.self)
				}
				completion(collection, nil)
		}
	}

	// MARK: - private
}
