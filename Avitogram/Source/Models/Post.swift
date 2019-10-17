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

	enum Fields: String {
		case id = "id"
		case createdAt = "created_at"
		case userId = "user_id"
	}
}
