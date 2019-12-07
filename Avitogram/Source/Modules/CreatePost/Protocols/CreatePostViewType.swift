//
//  CreatePostCreatePostViewType.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation
import ImageSource

protocol CreatePostViewType: class {
	func set(presenter: CreatePostPresenterType)
	func set(image: ImageSource)
	func show(message: String)
	func unfreeze()
}
