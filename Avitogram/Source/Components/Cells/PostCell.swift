//
//  PostCell.swift
//  Avitogram
//
//  Created by Maxim Petrenko on 23.10.2019.
//  Copyright © 2019 MadTeam IT Lab. All rights reserved.
//

import UIKit
import EasyPeasy
import FirebaseUI

final class PostCell: BaseTableViewCell {
	override var value: Any? {
		didSet {
			guard let post = value as? Post else { return }
			fillUI(post: post)
		}
	}

	// MARK: - subviews
	private let gradient = CAGradientLayer()

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
		view.clipsToBounds = true
		view.layer.cornerRadius = 4
		return view
	}()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.textColor = .white
		label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		return label
	}()

	private let dateLabel: UILabel = {
		let label = UILabel()
		label.textColor = UIColor.white.withAlphaComponent(0.8)
		label.font = UIFont.systemFont(ofSize: 13)
		label.textAlignment = .right
		return label
	}()

	override func configure() {
		super.configure()
		addSubview(imgView)
		addSubview(titleLabel)
		addSubview(dateLabel)
		imgView.easy.layout(Left(8), Right(8), Top(16), Height().like(imgView, .width), Bottom())
		titleLabel.easy.layout(Left(16),
													 Bottom(16).to(imgView, .bottom),
													 Height(>=20).with(.required))
		dateLabel.easy.layout(Left(10).to(titleLabel, .right),
													Top(10).to(imgView, .bottom),
													Height(20),
													Right(16),
													Bottom(16).to(imgView, .bottom))
		imgView.addSubview(indicator)
		indicator.easy.layout(Center())
	}

	// MARK: - private

	private func fillUI(post: Post) {
		titleLabel.text = post.title
		if Calendar.current.isDateInToday(post.createdAt) {
			dateLabel.text = post.createdAt.hh．mm
		} else {
			dateLabel.text = post.createdAt.dd．MM．yy
		}
		guard let reference = post.reference else { return }
		imgView.sd_setImage(with: reference, placeholderImage: nil) { [weak self] _, _, _, _ in
			self?.indicator.stopAnimating()
			
			guard let gradient = self?.gradient else { return }
			gradient.removeFromSuperlayer()

			gradient.frame = self?.imgView.frame ?? .zero
			gradient.position.x -= 8
			gradient.colors = [
					UIColor(white: 0, alpha: 0).cgColor,
					UIColor(white: 0, alpha: 0).cgColor,
					UIColor(white: 0, alpha: 0.6).cgColor
			]
			self?.imgView.layer.insertSublayer(gradient, at: 0)
		}
	}
}
