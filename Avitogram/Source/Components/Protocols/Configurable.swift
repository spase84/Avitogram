//
//  Configurable.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

protocol Configurable {
	var value: Any? { get set }
	func configure()
}
