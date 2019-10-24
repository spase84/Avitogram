//
//  BaseTableViewCell.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell, Configurable {
	var value: Any?
	
	class var identifier: String {
		return String(describing: self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configure()
	}
	
	override init(style: CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		configure()
	}
	
	override final func awakeFromNib() {
		super.awakeFromNib()
		configure()
	}
	
	func configure() {
		selectionStyle = .none
		backgroundColor = .clear
		contentView.backgroundColor = .clear
	}
}
