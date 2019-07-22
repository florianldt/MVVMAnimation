//
//  Album.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct Album {
    let id: String
    let coverName: String
    let name: String
    let artiste: String
    let isFavorite: Bool
}

extension Album {

    func toggleFavoriteState() -> Album {
        return Album(id: self.id,
                     coverName: self.coverName,
                     name: self.name,
                     artiste: self.artiste,
                     isFavorite: !self.isFavorite)
    }
}

extension Album {

    static func load() -> [Album] {
        return [
            Album(id: "0", coverName: "cover_0", name: "The Dark Side of the Moon", artiste: "Pink Floyd", isFavorite: false),
            Album(id: "1", coverName: "cover_1", name: "Sgt. Pepper's Lonely Hearts Club Band", artiste: "The Beatles", isFavorite: false),
            Album(id: "2", coverName: "cover_2", name: "Abbey Road", artiste: "The Beatles", isFavorite: false),
            Album(id: "3", coverName: "cover_3", name: "Led Zeppelin IV", artiste: "Led Zeppelin", isFavorite: false),
            Album(id: "4", coverName: "cover_4", name: "The White Album", artiste: "The Beatles", isFavorite: false),
            Album(id: "5", coverName: "cover_5", name: "Revolver", artiste: "The Beatles", isFavorite: false),
            Album(id: "6", coverName: "cover_6", name: "Who's Next", artiste: "The Who", isFavorite: false),
            Album(id: "7", coverName: "cover_7", name: "Nevermind", artiste: "Nirvana", isFavorite: false),
            Album(id: "8", coverName: "cover_8", name: "Pet Sounds", artiste: "The Beach Boys", isFavorite: false),
            Album(id: "9", coverName: "cover_9", name: "Rumours", artiste: "Fleetwood Mac", isFavorite: false),
            Album(id: "10", coverName: "cover_10", name: "The Doors", artiste: "The Doors", isFavorite: false),
            Album(id: "11", coverName: "cover_11", name: "Led Zeppelin", artiste: "Led Zeppelin", isFavorite: false),
            Album(id: "12", coverName: "cover_12", name: "Rubber Soul", artiste: "The Beatles", isFavorite: false),
            Album(id: "13", coverName: "cover_13", name: "Are You Experienced", artiste: "The Jimi Hendrix Experience", isFavorite: false),
            Album(id: "14", coverName: "cover_14", name: "The Rise and Fall of Ziggy Stardust and the Spiders From Mars", artiste: "David Bowie", isFavorite: false),
            Album(id: "15", coverName: "cover_15", name: "Wish You Were Here", artiste: "Pink Floyd", isFavorite: false),
            Album(id: "16", coverName: "cover_16", name: "London Calling", artiste: "The Clash", isFavorite: false),
            Album(id: "17", coverName: "cover_17", name: "Led Zeppelin II", artiste: "Led Zeppelin", isFavorite: false),
            Album(id: "18", coverName: "cover_18", name: "A Night at the Opera", artiste: "Queen", isFavorite: false),
            Album(id: "19", coverName: "cover_19", name: "Back in Black", artiste: "AC/DC", isFavorite: false),

        ]
    }
}

extension Album: Equatable {}
