//
//  Settings.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 07.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import UIKit

public class Settings {
	
	public static let shared = Settings()
	private init() {}
	
	public let placeholderAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.SLWarmGrey, .font: UIFont.systemFont(ofSize: 17)]
	
	public let passwordMinLength: Int = 4
}
