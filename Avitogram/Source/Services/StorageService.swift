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
//	static func getImageData(name: String, completion: @escaping ((_ imgData: Data?, _ error: Error?) -> Void))
}

final class StorageServiceImpl: StorageService {

	static func getImageData(name: String, completion: @escaping ((_ imgData: Data?, _ error: Error?) -> Void)) {
		let imgRef = Storage.storage().reference().child("images/\(name)")
		imgRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
			if let error = error {
				debugPrint("ERROR getting image from Storage: \(error.localizedDescription)")
				completion(nil, error)
			} else {
				completion(data, nil)
			}
		}
	}
}
