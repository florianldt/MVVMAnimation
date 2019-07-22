//
//  LoadingCell.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/22/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {

    let activityIndicator = UIActivityIndicatorView(style: .gray)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
