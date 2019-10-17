//
//  MPRoundedButton.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit

final class MPRoundedButton: UIButton {
	
	convenience init(radius: CGFloat, backgroundColor: UIColor, textColor: UIColor) {
		self.init()
		layer.cornerRadius = radius
		clipsToBounds = true
		self.setBackgroundImage(UIImage(color: backgroundColor), for: .normal)
		self.setBackgroundImage(UIImage(color: .gray), for: .disabled)
		setTitleColor(textColor, for: .normal)
	}
}
