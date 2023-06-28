//
//  ActionView.swift
//  TJ_test
//
//  Created by Gleb Chataev on 28.06.23.
//

import UIKit
import SnapKit

// MARK: - ActionView
final class ActionView: UIView {
    enum Style {
        case repost
        case save
        case comments
    }
    
    // MARK: - Views
    private let contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    private let imageView = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(style: Style) {
        self.init(frame: .zero)
        switch style {
        case .comments:
            imageView.image = .init(named: "comment_icon")
        case .repost:
            imageView.image = .init(named: "repost_icon")
        case .save:
            imageView.image = .init(named: "bookmark_icon")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        addSubview(contentView)
        contentView.addArrangedSubviews([imageView, titleLabel])
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(22)
        }
    }
}
