//
//  ThreadsViewModel.swift
//  TJ_test
//
//  Created by Gleb Chataev on 26.06.23.
//

import Foundation
import UIKit

// MARK: - ThreadsViewModel
final class ThreadsViewModel {
    // MARK: - Properties
    
    private let provider: PostsProviderProtocol
    private var pages: [Page] = []
    var pageModels: [[PostView.ViewModel]] = []
    var isLoading: Bool = false
    var updateUI: (() -> ())?
    
    // MARK: - Initialization
    
    init(provider: PostsProviderProtocol) {
        self.provider = provider
    }
    
    // MARK: - Public methods
    
    func getNewPage() {
        if !isLoading {
            isLoading = true
            provider.getNewPage { [weak self] page in
                guard let self else { return }
                self.isLoading = false
                self.pages.append(page)
                self.pageModels.append(self.makeViewModels(page: page))
                self.updateUI?()
            }
        }
    }
    
    func openImage(_ image: UIImage) {
        Coordinator.shared.openImageViewerViewControllr(image: image)
    }
    
    // MARK: - Private methods
    
    private func makeViewModels(page: Page) -> [PostView.ViewModel]{
        page.posts.map { post in
            let header: PostHeaderView.ViewModel = .init(
                iconURL: post.avatarURL,
                title: post.authorName,
                subtitle: DateFormatter(dateFormat: "dd MMMM HH:mm").string(from: post.date)
            )
            let title: PostTitleView.ViewModel = .init(
                title: post.title,
                subtitle: ""
            )
            let actions: PostActionsView.ViewModel = .init(
                comments: "\(post.counters.comments)",
                reposts: "\(post.counters.reposts)",
                saved: "\(post.counters.favorites)"
            )
            return .init(header: header, title: title, imageURL: post.coverImageURL ?? "", actions: actions)
        }
    }
}
