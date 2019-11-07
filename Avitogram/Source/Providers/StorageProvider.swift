//
//  StorageProvider.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 07.11.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import Firebase

protocol StorageProvider: BaseProvider {
	func create(data: Data, completion: @escaping (_ name: String?, _ error: Error?) -> Void)
}

final class StorageProviderImpl: StorageProvider {
	internal var collectionName = "images"
	
	func create(data: Data, completion: @escaping (String?, Error?) -> Void) {
		let name = UUID().uuidString,
		reference = Storage.storage().reference().child("\(collectionName)/\(name)")
		reference.putData(data, metadata: nil) { metadata, error in
			completion(nil == error ? name : nil, error)
		}
	}
}
