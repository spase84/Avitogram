//
//  AppDelegate.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 30.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import PluggableAppDelegate

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
	
	private var rootApplicationService = RootApplicationService()
	
	override var services: [ApplicationService] {
		return [
			rootApplicationService,
			GoogleApplicationService()
		]
	}
	
	func reloadRootScreen() {
		rootApplicationService.reloadStartScreen()
	}
}
