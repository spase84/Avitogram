//
//  AppService.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit

public final class AppService {
	
	public static func getApplication() -> UIApplication {
		return UIApplication.shared
	}
	
	public static func getAppDelegate() -> UIApplicationDelegate? {
		return AppService.getApplication().delegate as? AppDelegate
	}
}
