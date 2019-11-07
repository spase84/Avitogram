//
//  StorageService.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01.11.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import Firebase

protocol StorageService {
	func create(data: Data, completion: @escaping (_ name: String?, _ error: Error?) -> Void)
}

final class StorageServiceImpl: StorageService {
	private var provider: StorageProvider!
	
	init(storageProvider: StorageProvider) {
		self.provider = storageProvider
	}

	func create(data: Data, completion: @escaping (String?, Error?) -> Void) {
		provider.create(data: data) { name, error in
			completion(name, error)
		}
	}
}
