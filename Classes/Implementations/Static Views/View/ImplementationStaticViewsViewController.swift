//
//  ImplementationStaticViewsViewController.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class ImplementationStaticViewsViewController: StaticContainerViewController {

    let interactor: StaticInteractor

    var albumViews: [Index: AlbumView] = [:]

    lazy var nextBarButtonItem: UIBarButtonItem = {
        let bbi = UIBarButtonItem(barButtonSystemItem: .save,
                                  target: self,
                                  action: #selector(onNextBarButtonItem))
        return bbi
    }()

    init(title: String,
         interactor: StaticInteractor) {
        self.interactor = interactor
        super.init()
        self.title = title
        self.interactor.delegate = self
        self.interactor.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()

        interactor.fetchAlbums()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = nextBarButtonItem
    }

    private func setupViews() {
        for index in 0..<interactor.albumChoiceViewModel.numberOfItem {
            let cellViewModel = interactor.albumChoiceViewModel.cellViewModel(at: index)
            switch cellViewModel {
            case .loading:
                setupLoadingView()
            case .description(let text):
                setupSubtitleView(with: text)
            case .albums(let viewModels):
                setupAlbumViews(with: viewModels)
            case .failure(_):
                break
            }
        }
    }

    private func setupLoadingView() {
        let view = LoadingView()
        view.activityIndicator.startAnimating()
        container.addRow(view, withMargin: .zero)
    }

    private func setupSubtitleView(with text: String) {
        let view = SubtitleView()
        view.subtitleLabel.text = text
        container.addRow(view, withMargin: .init(top: 20,
                                                         left: 0,
                                                         bottom: 6,
                                                         right: 0))
    }

    private func setupAlbumViews(with viewModels: [AlbumViewModel]) {
        var albumStackView = newAlbumStackView()
        for i in 0..<viewModels.count {
            if  albumStackView.arrangedSubviews.count == 2 {
                container.addRow(albumStackView, withMargin: .init(top: 10,
                                                                left: 18,
                                                                bottom: 10,
                                                                right: 18))
                albumStackView = newAlbumStackView()
            }
            if i == viewModels.count - 1 {
                container.addRow(albumStackView, withMargin: .init(top: 10,
                                                                left: 18,
                                                                bottom: 10,
                                                                right: 18))
            }
            let view = AlbumView()
            view.delegate = self
            view.configure(with: viewModels[i])
            albumViews[i] = view
            albumStackView.addArrangedSubview(view)
        }
    }

    private func newAlbumStackView() -> AlbumStackView {
        return AlbumStackView()
    }

    private func updateViews() {
        for i in 0..<interactor.albumChoiceViewModel.numberOfItem {
            let cellViewModel = interactor.albumChoiceViewModel.cellViewModel(at: i)
            switch cellViewModel {
            case .description, .loading, .failure:
                break
            case .albums(let viewModels):
                for (offset, viewModel) in viewModels.enumerated() {
                    albumViews[offset]?.configure(with: viewModel)
                }

            }
        }

    }

    @objc
    private func onNextBarButtonItem() {
        
        let alertController = UIAlertController(title: "You picked",
                                               message: interactor.favoriteAlbumList(),
                                               preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }

}

extension ImplementationStaticViewsViewController: StaticInteractorDelegate {

    func didUpdateAlbumChoiceViewModel(_ viewModel: AlbumChoiceStaticViewModel) {
        DispatchQueue.main.async {
            guard case AlbumChoiceStaticViewModel.State.loaded = viewModel.state else {
                self.container.clear()
                self.setupViews()
                return
            }
            if self.container.stackView.arrangedSubviews.count < 3 {
                self.container.clear()
                self.setupViews()
            } else {
                self.updateViews()
            }

        }
    }

    func didUpdateAlbumChoiceNextButtonViewModel(_ viewModel: NextButtonViewModel) {
        nextBarButtonItem.isEnabled = viewModel.isEnabled
    }
}

extension ImplementationStaticViewsViewController: AlbumViewDelegate {

    func didSelectViewModel(_ viewModel: AlbumViewModel) {
        interactor.toggleFavoriteState(for: viewModel)
    }
}

