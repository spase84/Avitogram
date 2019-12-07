//
//  HomeHomeNavigator.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import UIKit
import Swinject
import ImageSource
import Paparazzo

class HomeNavigator: Navigator {
	private var resolver: Resolver!

	enum Destination {
		case createPost(imgItem: MediaPickerItem)
		case showPicker(completion: (_ items: [MediaPickerItem]) -> Void)
		case profile
	}

	internal weak var sourceViewController: UIViewController?

	// MARK: - Initializer
	init(sourceViewController: UIViewController?, resolver: Resolver) {
		self.sourceViewController = sourceViewController
		self.resolver = resolver
	}

	// MARK: - Navigator
	func navigate(to destination: HomeNavigator.Destination) {
		if let destinationViewController = makeViewController(for: destination) {
			switch destination {
			case .showPicker:
				sourceViewController?.present(destinationViewController, animated: true, completion: nil)
			default:
				if let navVC = sourceViewController?.navigationController {
					navVC.pushViewController(destinationViewController, animated: true)
				}
			}
		}
	}
	
	// MARK: - Private
	internal func makeViewController(for destination: Destination) -> UIViewController? {
		switch destination {
		case .createPost(let item):
			if let vc = resolver.resolve(CreatePostViewType.self) as? CreatePostViewController {
				vc.presenter?.set(imageSource: item.image)
				return vc
			}
		case .showPicker(let completion):
			let viewController = PaparazzoFacade.paparazzoViewController(
				theme: PaparazzoUITheme(),
				parameters: MediaPickerData(
					items: [],
					maxItemsCount: 1
				),
				onFinish: { items in
					completion(items)
				}
			)
			return viewController
		case .profile:
			if let vc = resolver.resolve(ProfileViewType.self) as? ProfileViewController {
				return vc
			}
		}
		return nil
	}
}
