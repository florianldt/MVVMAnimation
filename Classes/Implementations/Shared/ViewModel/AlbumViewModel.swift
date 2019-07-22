//
//  AlbumViewModel.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct AlbumViewModel {
    let id: String
    let coverName: String
    let name: String
    let artiste: String
    let isFavorite: Bool
}

extension AlbumViewModel {
    static func from(_ albums: [Album]) -> [AlbumViewModel] {
        return albums
            .map {
                AlbumViewModel(id: $0.id,
                               coverName: $0.coverName,
                               name: $0.name,
                               artiste: $0.artiste,
                               isFavorite: $0.isFavorite)
        }
    }
}

extension AlbumViewModel {
    static func from(_ album: Album) -> AlbumViewModel {
        return AlbumViewModel(id: album.id,
                               coverName: album.coverName,
                               name: album.name,
                               artiste: album.artiste,
                               isFavorite: album.isFavorite)
    }
}


