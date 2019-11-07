//
//  FormatterExtension.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 24.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation

extension DateFormatter {
	static let dd．MM．yyyy: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yyyy"
		return formatter
	}()

	static let dd．MM．yy: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd.MM.yy"
		return formatter
	}()

	static let hh．mm: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm"
		return formatter
	}()
}
