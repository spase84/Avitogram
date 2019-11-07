//
//  DateExtension.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 24.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

extension Date {
	public var dd．MM．yy: String {
		return DateFormatter.dd．MM．yy.string(from: self)
	}

	public var hh．mm: String {
		return DateFormatter.hh．mm.string(from: self)
	}
}
