//
//  UITextFieldExtension.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 07.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit

extension UITextField {

	convenience init(padding: Int) {
		self.init()
		let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: padding))
		leftView = paddingView
		leftViewMode = .always
	}
}
