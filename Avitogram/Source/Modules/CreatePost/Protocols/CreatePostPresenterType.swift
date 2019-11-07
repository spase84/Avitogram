//
//  CreatePostCreatePostPresenterType.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 01/11/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation

protocol CreatePostPresenterType {
	func viewIsReady()
	func set(imgData: Data)
	func done(title: String)
}
