//
//  StaticViewModel.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct AlbumChoiceViewModel {

    enum ViewModelType {
        case loading
        case description(String)
        case album(AlbumViewModel)
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
            ] + albumViewModels.map(ViewModelType.album)
        case .failed(let error):
            let errorViewModel = ErrorViewModel.from(error)
            self.viewModels = [
                .failure(errorViewModel)
            ]
        }
    }
}

extension AlbumChoiceViewModel {

    var numberOfItem: Int {
        return viewModels.count
    }

    func cellViewModel(at indexPath: IndexPath) -> ViewModelType {
        return viewModels[indexPath.row]
    }
}

extension AlbumChoiceViewModel.State: Equatable {
    // Suppose this can also be done by creating the enum like enum State: Int and then comparing the rawValue
    static func == (lhs: AlbumChoiceViewModel.State, rhs: AlbumChoiceViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.initialized, .initialized):
            return true
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }

}
