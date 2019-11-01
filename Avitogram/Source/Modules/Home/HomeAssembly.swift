//
//  HomeHomeAssembly.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import Swinject

class HomeAssembly: Assembly {
	func assemble(container: Container) {
		container.register(HomeViewType.self) { _ in 
			HomeViewController()
		}.initCompleted { (resolver: Resolver, view: HomeViewType) in
			guard let presenter = resolver.resolve(HomePresenterType.self, argument: view) as? HomePresenter else { return }
			presenter.attach(view: view)
			view.set(presenter: presenter)
		}

		container.register(HomeNavigator.self) { (resolver, view: HomeViewType) in
			HomeNavigator(sourceViewController: view as? HomeViewController, resolver: resolver)
		}
		
		container.register(HomePresenterType.self) { (resolver, view: HomeViewType) in
			HomePresenter(navigator: resolver.resolve(HomeNavigator.self, argument: view)!,
										postService: resolver.resolve(PostService.self)!,
										userService: resolver.resolve(UserService.self)!)
		}
	}
}
