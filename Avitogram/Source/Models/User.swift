//
//  User.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

struct User {
	var id: String?
	var name: String?
	var isGuest: Bool { nil == id }
}
