//
//  DiffingInteractor.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/22/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

protocol DiffingInteractorDelegate: class {
    func reloadData()
    func didUpdateViewModel(_ viewModel: AlbumViewModel)
    func didUpdateAlbumChoiceNextButtonViewModel(_ viewModel: NextButtonViewModel)
}

class DiffingInteractor {

    var albumViewModelsCache: [IndexPath: AlbumViewModel] = [:]

    var albumChoiceViewModel: AlbumChoiceViewModel {
        willSet(newViewModel) {
            diff(left: albumChoiceViewModel, right: newViewModel)
        }
    }

    var nextButtonViewModel: AlbumChoiceNextButtonViewModel {
        didSet {
            delegate?.didUpdateAlbumChoiceNextButtonViewModel(nextButtonViewModel.viewModel)
        }
    }

    weak var delegate: DiffingInteractorDelegate?

    init() {
        albumChoiceViewModel = AlbumChoiceViewModel(with: .initialized)
        nextButtonViewModel = AlbumChoiceNextButtonViewModel(with: .initialized)
    }

    func initialize() {
        delegate?.reloadData()
        delegate?.didUpdateAlbumChoiceNextButtonViewModel(nextButtonViewModel.viewModel)
    }
}

extension DiffingInteractor {

    func fetchAlbums() {
        albumChoiceViewModel = AlbumChoiceViewModel(with: .loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            let albums = Album.load()
            self.albumChoiceViewModel = AlbumChoiceViewModel(with: .loaded(albums))
        }
    }

    func toggleFavoriteState(for viewModel: AlbumViewModel) {
        guard case .loaded(let albums) = self.albumChoiceViewModel.state else { return }
        var updatedAlbums = [Album]()
        for album in albums {
            if album.id == viewModel.id {
                updatedAlbums.append(album.toggleFavoriteState())
            } else {
                updatedAlbums.append(album)
            }
        }
        self.albumChoiceViewModel = AlbumChoiceViewModel(with: .loaded(updatedAlbums))
        manageNextButton()
    }

    private var favoriteCount: Int {
        guard case .loaded(let albums) = albumChoiceViewModel.state else { return 0 }
        return albums
            .filter { $0.isFavorite }
            .count
    }

    private func manageNextButton() {
        nextButtonViewModel = AlbumChoiceNextButtonViewModel(with: favoriteCount > 2 ? .enable : .disable)
    }

    func favoriteAlbumList() -> String {
        guard case .loaded(let albums) = albumChoiceViewModel.state else { return "" }
        let albumTitles = albums
            .filter { $0.isFavorite }
            .map { $0.name }
        var formattedString: String {
            var returnString = ""
            for (offset, title) in albumTitles.enumerated() {
                returnString += title
                if offset < albumTitles.count - 1 {
                    returnString += "\n"
                }
            }
            return returnString
        }
        return formattedString
    }
}

extension DiffingInteractor {

    private func diff(left: AlbumChoiceViewModel, right: AlbumChoiceViewModel) {
        if left.state != right.state {
            delegate?.reloadData()
        } else {
            guard
                case .loaded(let oldModels) = left.state,
                case .loaded(let newModels) = right.state
                else {
                    delegate?.reloadData()
                return
            }
            if oldModels.count != newModels.count {
                delegate?.reloadData()
            }
            for (offset, oldModel) in oldModels.enumerated()
                where oldModel != newModels[offset] {
                    let newViewModel = AlbumViewModel.from(newModels[offset])
                    delegate?.didUpdateViewModel(newViewModel)
                    return
            }
        }
    }
}
