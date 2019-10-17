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
	
	var isValidEmail: Bool {
		let pattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
		let test = NSPredicate(format:"SELF MATCHES %@", pattern)
		return test.evaluate(with: self)
	}
}
