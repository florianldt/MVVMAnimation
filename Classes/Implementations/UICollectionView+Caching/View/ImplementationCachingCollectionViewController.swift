//
//  ImplementationCachingCollectionViewController.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/22/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class ImplementationCachingCollectionViewController: UICollectionViewController {

    let interactor: CachingInteractor

    lazy var nextBarButtonItem: UIBarButtonItem = {
        let bbi = UIBarButtonItem(barButtonSystemItem: .save,
                                  target: self,
                                  action: #selector(onNextBarButtonItem))
        return bbi
    }()

    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()

    init(title: String,
         interactor: CachingInteractor) {
        self.interactor = interactor
        super.init(collectionViewLayout: layout)
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
        setupCollectionView()
        interactor.fetchAlbums()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = nextBarButtonItem
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LoadingCell.self)
        collectionView.register(SubtitleCell.self)
        collectionView.register(AlbumCell.self)
        collectionView.contentInset = UIEdgeInsets(top: 0,
                                                   left: 18,
                                                   bottom: 0,
                                                   right: 18)
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

extension ImplementationCachingCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.albumChoiceViewModel.numberOfItem
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let returnCell: UICollectionViewCell
        let cellViewModel = interactor.albumChoiceViewModel.cellViewModel(at: indexPath)
        switch cellViewModel {
        case .description(let text):
            let cell = collectionView.dequeue(SubtitleCell.self, for: indexPath)
            cell.configure(with: text)
            returnCell = cell
        case .album(let viewModel):
            let cell = collectionView.dequeue(AlbumCell.self, for: indexPath)
            cell.configure(with: interactor.albumViewModelsCache[indexPath], newViewModel: viewModel)
            interactor.albumViewModelsCache[indexPath] = viewModel
            returnCell = cell
        case .loading:
            let cell = collectionView.dequeue(LoadingCell.self, for: indexPath)
            cell.activityIndicator.startAnimating()
            returnCell = cell
        case .failure(_):
            preconditionFailure("TODO")
        }
        return returnCell
    }

}

extension ImplementationCachingCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellViewModel = interactor.albumChoiceViewModel.cellViewModel(at: indexPath)
        switch cellViewModel {
        case .description, .loading, .failure: break
        case .album(let viewModel):
            interactor.toggleFavoriteState(for: viewModel)
        }
    }
}

extension ImplementationCachingCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let returnSize: CGSize
        let screenW: CGFloat = UIScreen.main.bounds.width
        let cellViewModel = interactor.albumChoiceViewModel.cellViewModel(at: indexPath)
        switch cellViewModel {
        case .description:
            returnSize = CGSize(width: screenW - 18 * 2, height: 40)
        case .album:
            returnSize = CGSize(width: (screenW - 10) / 2 - 18, height: 240)
        case .loading, .failure:
            returnSize = CGSize(width: screenW - 18 * 2, height: 60)
        }
        return returnSize
    }
}

extension ImplementationCachingCollectionViewController: CachingInteractorDelegate {

    func didUpdateAlbumChoiceViewModel(_ viewModel: AlbumChoiceViewModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func didUpdateAlbumChoiceNextButtonViewModel(_ viewModel: NextButtonViewModel) {
        nextBarButtonItem.isEnabled = viewModel.isEnabled
    }
}

