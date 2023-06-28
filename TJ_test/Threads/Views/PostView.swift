//
//  PostView.swift
//  TJ_test
//
//  Created by Gleb Chataev on 26.06.23.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: - PostViewDelegateProtocol
protocol PostViewDelegateProtocol: AnyObject {
    func openImage(_ image: UIImage)
}

// MARK: - PostView
final class PostView: UIView {
    // MARK: - Views
    
    private lazy var contentView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(openImage))
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private var spacer: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.07)
        return view
    }()
    
    private let header = PostHeaderView()
    private let titleView = PostTitleView()
    private var actionsView = PostActionsView()
    
    // MARK: - Properties
    
    weak var delegate: PostViewDelegateProtocol?
    
    // MARK: - Initializarion
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        isUserInteractionEnabled = true
        addSubview(contentView)
        contentView.addArrangedSubviews([header, titleView, pictureView, actionsView, spacer])
        contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
        pictureView.snp.makeConstraints { make in
            make.height.equalTo(210)
        }
        spacer.snp.makeConstraints { make in
            make.height.equalTo(16)
        }
    }
    
    @objc
    private func openImage() {
        guard let image = pictureView.image else { return }
        delegate?.openImage(image)
    }
}

// MARK: - ViewModel
extension PostView {
    struct ViewModel {
        let header: PostHeaderView.ViewModel
        let title: PostTitleView.ViewModel
        let imageURL: String?
        let actions: PostActionsView.ViewModel
    }
    
    func configure(with viewModel: ViewModel) {
        header.configure(with: viewModel.header)
        titleView.configure(with: viewModel.title)
        actionsView.configure(with: viewModel.actions)
        
        if let imageURL = URL(string: viewModel.imageURL ?? "") {
            pictureView.isHidden = false
            pictureView.kf.setImage(with: .network(imageURL))
        } else {
            pictureView.isHidden = true
        }
        setNeedsLayout()
    }
}
