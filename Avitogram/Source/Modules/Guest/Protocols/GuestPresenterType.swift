//
//  GuestGuestPresenterType.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 31/07/2019.
//  Copyright © 2019 Max Petrenko. All rights reserved.
//

protocol GuestPresenterType {
	func attach(view: GuestViewType)
	func viewIsReady()
}
