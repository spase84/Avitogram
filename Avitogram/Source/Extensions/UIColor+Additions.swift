//
//  UIColor+Additions.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit

public extension UIColor {
	@nonobjc class var SLBlack: UIColor {
		return UIColor(white: 38.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLDullYellow: UIColor {
		return UIColor(red: 235.0 / 255.0, green: 196.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLWarmGrey: UIColor {
		return UIColor(white: 153.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLDarkishGreen: UIColor {
		return UIColor(red: 46.0 / 255.0, green: 125.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLBlackTwo: UIColor {
		return UIColor(white: 46.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLPastelRed: UIColor {
		return UIColor(red: 234.0 / 255.0, green: 92.0 / 255.0, blue: 92.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLDodgerBlue: UIColor {
		return UIColor(red: 59.0 / 255.0, green: 143.0 / 255.0, blue: 1.0, alpha: 1.0)
	}
	
	@nonobjc class var SLGreyishBrown: UIColor {
		return UIColor(white: 60.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLWhite: UIColor {
		return UIColor(white: 228.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLGreyishBrownTwo: UIColor {
		return UIColor(white: 61.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLFacebookBlue: UIColor {
		return UIColor(red: 59.0 / 255.0, green: 89.0 / 255.0, blue: 152.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLBlackThree: UIColor {
		return UIColor(white: 54.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLBlackFour: UIColor {
		return UIColor(white: 51.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLGreyishBrownThree: UIColor {
		return UIColor(white: 62.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLPinkishGrey: UIColor {
		return UIColor(white: 195.0 / 255.0, alpha: 1.0)
	}
	
	@nonobjc class var SLFernGreen: UIColor {
		return UIColor(red: 58.0 / 255.0, green: 133.0 / 255.0, blue: 62.0 / 255.0, alpha: 1.0)
	}
}

// Sample text styles

extension UIFont {
	
	class var SLHeader: UIFont {
		return UIFont.systemFont(ofSize: 24.0, weight: .bold)
	}
	
}
