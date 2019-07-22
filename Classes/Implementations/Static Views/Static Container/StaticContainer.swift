//
//  StaticContainer.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class StaticContainer: UIScrollView {

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()

    init() {
        super.init(frame: .zero)
        setupStackView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            ])
    }

    func addRow(_ view: UIView,
                withMargin margin: UIEdgeInsets) {
        let cell = StackViewCell()
        cell.layoutMargins = margin
        cell.insert(view)
        stackView.addArrangedSubview(cell)
    }

    func clear() {
        for view in stackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
}
