//
//  PostProvider.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol PostProvider: BaseProvider {
	func getCollection()
}

final class PostProviderImpl: PostProvider {
	internal var collectionName = "posts"
	private let db = Firestore.firestore()

	func getCollection() {
		db.collection(collectionName)
			.whereField(Post.Fields.userId.rawValue, isEqualTo: UserServiceImpl.currentUser.id ?? "")
			.getDocuments { snapshot, error in
				debugPrint(snapshot?.documents, error)
		}
	}
}
