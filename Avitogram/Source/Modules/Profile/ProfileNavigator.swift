//
//  ProfileProfileNavigator.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 19/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import UIKit
import Swinject

class ProfileNavigator: Navigator {
	var resolver: Resolver!

	enum Destination {
		case someDestination
	}
  
	internal weak var sourceViewController: UIViewController?

	// MARK: - Initializer
	init(sourceViewController: UIViewController?) {
		self.sourceViewController = sourceViewController
	}

	// MARK: - Navigator
	func navigate(to destination: ProfileNavigator.Destination) {
		if let destinationViewController = makeViewController(for: destination) {
			if let navVC = sourceViewController?.navigationController {
				navVC.pushViewController(destinationViewController, animated: true)
			}
		}
	}
	
	// MARK: - Private
	internal func makeViewController(for destination: Destination) -> UIViewController? {
		switch destination {
		case .someDestination:
//			return resolver.resolve(SomeViewType.self) as? SomeViewController
			return nil
		}
	}
}
