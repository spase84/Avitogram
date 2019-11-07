//
//  ServicesAssembly.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 14.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Swinject

class ServicesAssembly: Assembly {
	func assemble(container: Container) {
		container.register(UserService.self) { _ in
			UserServiceImpl()
		}
		container.register(StorageService.self) { resolver in
			StorageServiceImpl(storageProvider: resolver.resolve(StorageProvider.self)!)
		}
		container.register(PostService.self) { resolver in
			PostServiceImpl(provider: resolver.resolve(PostProvider.self)!,
											storageService: resolver.resolve(StorageService.self)!)
		}.inObjectScope(.container)
	}
}
