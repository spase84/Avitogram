//
//  PostCell.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import EasyPeasy

final class PostCell: BaseTableViewCell {
	override var value: Any? {
		didSet {
			guard let post = value as? Post else { return }
			fillUI(post: post)
		}
	}

	// MARK: - subviews

	private var indicator: UIActivityIndicatorView = {
		let view = UIActivityIndicatorView(style: .whiteLarge)
		view.color = .SLBlackTwo
		view.startAnimating()
		return view
	}()

	private var imgView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleAspectFill
		view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
		return view
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.font = UIFont.systemFont(ofSize: 17)
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		return label
	}()

	private let dateLabel: UILabel = {
		let label = UILabel()
		label.textColor = .lightGray
		label.font = UIFont.systemFont(ofSize: 13)
		label.textAlignment = .right
		return label
	}()

	override func configure() {
		super.configure()
		addSubview(imgView)
		addSubview(titleLabel)
		addSubview(dateLabel)
		imgView.easy.layout(Left(), Right(), Top(), Height().like(imgView, .width))
		titleLabel.easy.layout(Left(16),
													 Top(20).to(imgView, .bottom),
													 Bottom(16),
													 Height(>=20).with(.required))
		dateLabel.easy.layout(Left(10).to(titleLabel, .right),
													Top(20).to(imgView, .bottom),
													Height(20),
													Right(16))
		imgView.addSubview(indicator)
		indicator.easy.layout(Center())
	}

	// MARK: - private

	private func fillUI(post: Post) {
		titleLabel.text = post.title
		dateLabel.text = post.createdAt.dd．MM．yy
		StorageServiceImpl.getImageData(name: post.imageName) { [weak self] data, error in
			guard let imgData = data else { return }
			self?.imgView.image = UIImage(data: imgData)
			self?.indicator.stopAnimating()
		}
	}
}
