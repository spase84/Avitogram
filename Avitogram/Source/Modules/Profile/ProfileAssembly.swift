//
//  ProfileProfileAssembly.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 19/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import Swinject

class ProfileAssembly: Assembly {
	func assemble(container: Container) {
		container.register(ProfileViewType.self) { _ in 
			ProfileViewController()
		}.initCompleted { (resolver: Resolver, view: ProfileViewType) in
			if let presenter = resolver.resolve(ProfilePresenterType.self) as? ProfilePresenter {
				if let navigator = resolver.resolve(ProfileNavigator.self, argument: view) {
					navigator.resolver = resolver
					presenter.navigator = navigator
				}
				presenter.attach(view: view)
				view.set(presenter: presenter)
			}
		}

		container.register(ProfileNavigator.self) { (_, view: ProfileViewType) in
			ProfileNavigator(sourceViewController: view as? ProfileViewController)
		}
		
		container.register(ProfilePresenterType.self) { _ in
			ProfilePresenter()
		}
	}
}
