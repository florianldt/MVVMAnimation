//
//  LoadingView.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/13/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let activityIndicator = UIActivityIndicatorView(style: .gray)

    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 60),
            ])
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

