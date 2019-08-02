//
//  RootApplicationService.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31.07.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Foundation
import PluggableAppDelegate
import Swinject

final class RootApplicationService: NSObject, ApplicationService {
	
	private var application: UIApplication!
	private let assembler = Assembler([])
	private let assemblies: [Assembly] = [
		GuestAssembly()
//		SignUpAssembly(),
//		SignInAssembly(),
//		HomeAssembly(),
	]
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		self.application = application
		assembler.apply(assemblies: assemblies)
//		_ = Settings.shared // make initial customization for UI components described in Settings.init()
		self.reloadStartScreen()
		return true
	}
	
	public enum LoadingModuleType {
		case home, signin
	}
	
	public func reloadStartScreen() {
		DispatchQueue.main.async {
//			if nil == DefaultsService.accessToken {
				self.load(moduleType: .signin, for: self.application)
//			} else {
//				self.load(moduleType: .home, for: self.application)
//			}
		}
	}
	
	// MARK: - private
	private func load(moduleType: LoadingModuleType, for application: UIApplication) {
		var rootVC = UIViewController()
		rootVC.view.backgroundColor = UIColor.white
		switch moduleType {
		case .home:
//			if let vc = assembler.resolver.resolve(HomeViewType.self) as? HomeViewController {
//				rootVC = vc
//			}
			debugPrint("TEST )))))")
		case .signin:
			if let vc = assembler.resolver.resolve(GuestViewType.self) as? GuestViewController {
				rootVC = vc
			}
		}
		
		if let delegate = application.delegate as? AppDelegate {
			if nil == delegate.window { delegate.window = UIWindow() }
			delegate.window?.rootViewController = rootVC
			delegate.window?.makeKeyAndVisible()
		}
	}
}
