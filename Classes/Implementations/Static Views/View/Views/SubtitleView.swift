//
//  SubtitleView.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class SubtitleView: UIView {

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()

    init() {
        super.init(frame: .infinite)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            ])

        NSLayoutConstraint.activate([
            subtitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
