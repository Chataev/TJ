//
//  PostActionsView.swift
//  TJ_test
//
//  Created by Gleb Chataev on 27.06.23.
//

import UIKit
import SnapKit

// MARK: - PostActionsView
final class PostActionsView: UIView {
    // MARK: - Views
    
    private lazy var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        return stack
    }()
    
    
    let commentButton = ActionView(style: .comments)
    let repostButton = ActionView(style: .repost)
    let saveButton = ActionView(style: .save)
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        addSubview(contentView)
        contentView.addArrangedSubviews([commentButton, repostButton, saveButton])
        commentButton.setTitle("200")
        repostButton.setTitle("300")
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.bottom.equalToSuperview().inset(16)
            make.right.lessThanOrEqualToSuperview().inset(16)
            make.height.equalTo(22)
        }
    }
}

// MARK: - ViewModel
extension PostActionsView {
    struct ViewModel {
        let comments: String
        let reposts: String
        let saved: String
    }
    
    func configure(with viewModel: ViewModel) {
        commentButton.setTitle(viewModel.comments)
        repostButton.setTitle(viewModel.reposts)
        saveButton.setTitle(viewModel.saved)
    }
}

