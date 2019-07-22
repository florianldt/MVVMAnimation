//
//  ErrorViewModel.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/12/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct ErrorViewModel {
    let description: String
}

extension ErrorViewModel {
    static func from(_ error: Error) -> ErrorViewModel {
        return ErrorViewModel(description: error.localizedDescription)
    }
}
