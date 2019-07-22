//
//  AlbumChoiceNextButtonViewModel.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/13/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import Foundation

struct AlbumChoiceNextButtonViewModel {

    enum State {
        case initialized
        case enable
        case disable
    }

    let state: State
    let viewModel: NextButtonViewModel

    init(with state: State) {
        self.state = state
        switch state {
        case .initialized:
            self.viewModel = NextButtonViewModel(isEnabled: false)
        case .enable:
            self.viewModel = NextButtonViewModel(isEnabled: true)
        case .disable:
            self.viewModel = NextButtonViewModel(isEnabled: false)
        }
    }

}
