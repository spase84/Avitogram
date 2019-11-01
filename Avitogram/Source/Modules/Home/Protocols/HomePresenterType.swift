//
//  HomeHomePresenterType.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 17/10/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//
import Foundation

protocol HomePresenterType {
	func attach(view: HomeViewType)
	func viewIsReady()
	func signOut()
	func imagePicked(data: Data)
}
