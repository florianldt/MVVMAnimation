//
//  AlbumChoiceStaticViewModel.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/22/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct AlbumChoiceStaticViewModel {

    enum ViewModelType {
        case loading
        case description(String)
        case albums([AlbumViewModel])
        case failure(ErrorViewModel)
    }

    enum State {
        case initialized
        case loading
        case loaded([Album])
        case failed(Error)
    }

    let state: State
    let viewModels: [ViewModelType]

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            self.viewModels = []
        case .loading:
            self.viewModels = [
                .description("Pick your favorite albums:"),
                .loading,
            ]
        case .loaded(let albums):
            let albumViewModels = AlbumViewModel.from(albums)
            self.viewModels = [
                .description("Pick your favorite albums:"),
                .albums(albumViewModels)
            ]
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            self.viewModels = [
                .failure(errorViewModel)
            ]
        }
    }
}

extension AlbumChoiceStaticViewModel {

    var numberOfItem: Int {
        return viewModels.count
    }

    func cellViewModel(at index: Index) -> ViewModelType {
        return viewModels[index]
    }
}
