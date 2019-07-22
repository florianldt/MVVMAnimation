//
//  StackViewCell.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class StackViewCell: UIView {

    let contentView = UIView()

    var contentViewTopConstraint: NSLayoutConstraint!
    var contentViewLeftConstraint: NSLayoutConstraint!
    var contentViewRightConstraint: NSLayoutConstraint!
    var contentViewBottomConstraint: NSLayoutConstraint!

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)

        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        contentViewLeftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: layoutMargins.left)
        contentViewRightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -layoutMargins.right)
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layoutMargins.bottom)

        NSLayoutConstraint.activate([
            contentViewTopConstraint,
            contentViewLeftConstraint,
            contentViewRightConstraint,
            contentViewBottomConstraint,
            ])
    }

    func insert(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ])

        contentViewTopConstraint.constant = layoutMargins.top
        contentViewLeftConstraint.constant = layoutMargins.left
        contentViewRightConstraint.constant = -layoutMargins.right
        contentViewBottomConstraint.constant = -layoutMargins.bottom
    }
}
