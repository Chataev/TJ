//
//  PostTitleView.swift
//  TJ_test
//
//  Created by Gleb Chataev on 27.06.23.
//

import UIKit
import SnapKit

// MARK: - PostTitleView
final class PostTitleView: UIView {
    // MARK: - Views
    
    private lazy var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
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
        contentView.addArrangedSubviews([title, subtitle])
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
    }
}

// MARK: - ViewModel
extension PostTitleView {
    struct ViewModel {
        let title: String
        let subtitle: String?
    }
    
    func configure(with viewModel: ViewModel) {
        title.text = viewModel.title
        subtitle.text = viewModel.subtitle ?? ""
        subtitle.isHidden = viewModel.subtitle == nil ? true : false
    }
}
