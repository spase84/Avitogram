//
//  CreatePostCreatePostAssembly.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

import Swinject

class CreatePostAssembly: Assembly {
	func assemble(container: Container) {
		container.register(CreatePostViewType.self) { _ in 
			CreatePostViewController()
		}.initCompleted { (resolver: Resolver, view: CreatePostViewType) in
			if let presenter = resolver.resolve(CreatePostPresenterType.self, argument: view) as? CreatePostPresenter {
				if let navigator = resolver.resolve(CreatePostNavigator.self, argument: view) {
					navigator.resolver = resolver
					presenter.navigator = navigator
				}
				view.set(presenter: presenter)
			}
		}

		container.register(CreatePostNavigator.self) { (_, view: CreatePostViewType) in
			CreatePostNavigator(sourceViewController: view as? CreatePostViewController)
		}
		
		container.register(CreatePostPresenterType.self) { (resolver, view: CreatePostViewType) in
			CreatePostPresenter(view: view, postService: resolver.resolve(PostService.self)!)
		}
	}
}
