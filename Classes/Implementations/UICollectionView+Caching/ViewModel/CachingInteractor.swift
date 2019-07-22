//
//  CachingInteractor.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/22/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

protocol CachingInteractorDelegate: class {
    func didUpdateAlbumChoiceViewModel(_ viewModel: AlbumChoiceViewModel)
    func didUpdateAlbumChoiceNextButtonViewModel(_ viewModel: NextButtonViewModel)
}

class CachingInteractor {

    var albumViewModelsCache: [IndexPath: AlbumViewModel] = [:]
    
    var albumChoiceViewModel: AlbumChoiceViewModel {
        didSet {
            delegate?.didUpdateAlbumChoiceViewModel(albumChoiceViewModel)
        }
    }

    var nextButtonViewModel: AlbumChoiceNextButtonViewModel {
        didSet {
            delegate?.didUpdateAlbumChoiceNextButtonViewModel(nextButtonViewModel.viewModel)
        }
    }

    weak var delegate: CachingInteractorDelegate?

    init() {
        albumChoiceViewModel = AlbumChoiceViewModel(with: .initialized)
        nextButtonViewModel = AlbumChoiceNextButtonViewModel(with: .initialized)
    }

    func initialize() {
        delegate?.didUpdateAlbumChoiceViewModel(albumChoiceViewModel)
        delegate?.didUpdateAlbumChoiceNextButtonViewModel(nextButtonViewModel.viewModel)
    }
}

extension CachingInteractor {

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
