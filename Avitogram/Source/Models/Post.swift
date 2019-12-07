//
//  Post.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import Firebase
import ImageSource

struct Post {
	var title: String = ""
	var createdAt: Date = Date()
	var userId: String?
	var imageName: String?

	var image: ImageSource?
	var reference: StorageReference?

	enum Fields: String {
		case id = "id"
		case createdAt = "created_at"
		case userId = "user_id"
		case imageName = "image_name"
	}

	enum ValidationError: Error {
		case titleEmpty
		case imageEmpty
		case userIdEmpty
		
		var localizedDescription: String {
			switch self {
			case .titleEmpty:
				return "error_create_post_empty_title".localized.firstUppercased
			case .imageEmpty:
				return "error_create_post_empty_image".localized.firstUppercased
			case .userIdEmpty:
				return "error_create_post_empty_user".localized.firstUppercased
			}
		}
	}
}

extension Post: Codable {
	private enum CodingKeys: String, CodingKey {
		case title
		case createdAt = "created_at"
		case userId = "user_id"
		case imageName = "image_name"
	}
}
