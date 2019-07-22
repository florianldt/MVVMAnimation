//
//  SubtitleCell.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/22/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class SubtitleCell: UICollectionViewCell {

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            subtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with text: String) {
        subtitleLabel.text = text
    }
}
