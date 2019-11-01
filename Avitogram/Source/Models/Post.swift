//
//  Post.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

struct Post {
	var title: String
	var createdAt: Date
	var userId: String
	var imageName: String

	var image: Data?

	enum Fields: String {
		case id = "id"
		case createdAt = "created_at"
		case userId = "user_id"
		case imageName = "image_name"
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
