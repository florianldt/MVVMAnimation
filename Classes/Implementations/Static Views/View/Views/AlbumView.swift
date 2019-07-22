//
//  AlbumView.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

typealias Index = Int

protocol AlbumViewDelegate: class {
    func didSelectViewModel(_ viewModel: AlbumViewModel)
}

class AlbumView: UIView {

    var viewModel: AlbumViewModel?
    weak var delegate: AlbumViewDelegate?

    let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 3
        iv.layer.masksToBounds = true
        return iv
    }()

    let favoriteIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "favorite_on")
        return iv
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    let artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(coverImageView)
        addSubview(favoriteIcon)
        addSubview(nameLabel)
        addSubview(artistLabel)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 240),
            ])

        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            coverImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            coverImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor),
            ])

        NSLayoutConstraint.activate([
            favoriteIcon.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor, constant: 0),
            favoriteIcon.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor, constant: 0),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 48),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 48),
            ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 6),
            nameLabel.leftAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: 0),
            nameLabel.rightAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 0),
            ])

        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            artistLabel.leftAnchor.constraint(equalTo: coverImageView.leftAnchor, constant: 0),
            artistLabel.rightAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 0),
            ])

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCell))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: AlbumViewModel) {
        map(old: self.viewModel, new: viewModel)
        coverImageView.image = UIImage(named: viewModel.coverName)
        nameLabel.text = viewModel.name
        artistLabel.text = viewModel.artiste
        favoriteIcon.isHidden = !viewModel.isFavorite
        self.viewModel = viewModel
        print(self.viewModel)
    }

    private func map(old: AlbumViewModel?,
                     new: AlbumViewModel) {
        guard let old = old else {
            return
        }
        switch (old.isFavorite, new.isFavorite) {
        case (true, true),
             (false, false):
            return
        case (false, true):
            rotate()
        case (true, false):
            return
        }
    }

    @objc
    private func onCell() {
        guard let viewModel = self.viewModel else { return }
        delegate?.didSelectViewModel(viewModel)
    }

    private func rotate() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 0.4
        self.favoriteIcon.layer.add(rotateAnimation, forKey: nil)
    }
}
