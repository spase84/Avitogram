//
//  GuestGuestAssembly.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31/07/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import Swinject

class GuestAssembly: Assembly {
	func assemble(container: Container) {
		container.register(GuestViewType.self) { _ in 
			GuestViewController()
		}.initCompleted { (resolver: Resolver, view: GuestViewType) in
			if let presenter = resolver.resolve(GuestPresenterType.self) as? GuestPresenter {
				if let navigator = resolver.resolve(GuestNavigator.self, argument: view) {
					navigator.resolver = resolver
					presenter.navigator = navigator
				}
				presenter.attach(view: view)
				view.set(presenter: presenter)
			}
		}

		container.register(GuestNavigator.self) { (_, view: GuestViewType) in
			GuestNavigator(sourceViewController: view as? GuestViewController)
		}
		
		container.register(GuestPresenterType.self) { _ in
			GuestPresenter()
		}
	}
}
