//
//  ThreadsAssembly.swift
//  TJ_test
//
//  Created by Gleb Chataev on 26.06.23.
//

import Foundation

final class ThreadsAssembly {
    func make() -> ThreadsViewController {
        let provider = PostsProvider()
        let viewModel = ThreadsViewModel(provider: provider)
        let controller = ThreadsViewController(viewModel: viewModel)
        return controller
    }
}
