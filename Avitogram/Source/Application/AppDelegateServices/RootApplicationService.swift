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
		ServicesAssembly(),
		ProvidersAssembly(),
		GuestAssembly(),
		HomeAssembly(),
		CreatePostAssembly()
	]

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		self.application = application
		assembler.apply(assemblies: assemblies)
		self.reloadStartScreen()
		return true
	}

	public func reloadStartScreen() {
		DispatchQueue.main.async {
			if UserServiceImpl.currentUser.isGuest ||
				UserServiceImpl.isFirstLaunch {
				self.load(moduleType: .guest, for: self.application)
			} else {
				self.load(moduleType: .home, for: self.application)
			}
		}
	}

	// MARK: - private

	private enum LoadingModuleType {
		case guest, home
	}

	private func load(moduleType: LoadingModuleType, for application: UIApplication) {
		var rootVC = UIViewController()
		rootVC.view.backgroundColor = .SLBlack
		switch moduleType {
		case .home:
			if let vc = assembler.resolver.resolve(HomeViewType.self) as? HomeViewController {
				let navigation = UINavigationController(rootViewController: vc)
				navigation.navigationBar.tintColor = .white
				navigation.navigationBar.barTintColor = .SLBlackTwo
				navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
				rootVC = navigation
			}
		case .guest:
			if let vc = assembler.resolver.resolve(GuestViewType.self) as? GuestViewController {
				rootVC = vc
			}
		}

		UserServiceImpl.isFirstLaunch = false

		if let delegate = application.delegate as? AppDelegate {
			if nil == delegate.window { delegate.window = UIWindow() }
			delegate.window?.rootViewController = rootVC
			delegate.window?.makeKeyAndVisible()
		}
	}
}
