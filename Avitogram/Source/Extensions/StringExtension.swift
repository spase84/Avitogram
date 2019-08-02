//
//  StringExtension.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

public extension String {
	
	func attributed(attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
		return NSAttributedString(string: self, attributes: attributes)
	}
	
	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
	
	var firstUppercased: String {
		guard let first = first else { return "" }
		return String(first).uppercased() + dropFirst()
	}
}
