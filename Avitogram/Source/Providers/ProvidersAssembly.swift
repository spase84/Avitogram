//
//  ProvidersAssembly.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import Swinject

class ProvidersAssembly: Assembly {
	func assemble(container: Container) {
		container.register(PostProvider.self) { _ in
			PostProviderImpl()
		}
		container.register(StorageProvider.self) { _ in
			StorageProviderImpl()
		}
	}
}
