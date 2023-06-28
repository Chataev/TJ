//
//  PostHeaderView.swift
//  TJ_test
//
//  Created by Gleb Chataev on 27.06.23.
//

import UIKit
import SnapKit

// MARK: - PostHeaderView
final class PostHeaderView: UIView {
    // MARK: - Views
    private let contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    private var iconView = UIImageView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black.withAlphaComponent(0.65)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "dots_icon"), for: .normal)
        return button
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        addSubviews([iconView, titleLabel, subtitleLabel, editButton])
        iconView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.width.height.equalTo(22)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(8)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(12)
            make.right.greaterThanOrEqualTo(editButton.snp.left)
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
        editButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
            make.height.width.equalTo(22)
        }
    }
}

// MARK: - ViewModel
extension PostHeaderView {
    struct ViewModel {
        let iconURL: String
        let title: String
        let subtitle: String
    }
    
    func configure(with viewModel: ViewModel) {
        if let imageURL = URL(string: viewModel.iconURL) {
            iconView.kf.setImage(with: .network(imageURL))
        } else {
            iconView.image = UIImage(named: "film_avatar")
        }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
}
