//
//  PostCell.swift
//  TJ_test
//
//  Created by Gleb Chataev on 27.06.23.
//

import UIKit
import SnapKit

// MARK: - PostCellDelegate
protocol PostCellDelegate: AnyObject {
    func openImage(_ image: UIImage)
}

// MARK: - PostCell
final class PostCell: UITableViewCell {
    // MARK: - Views
    
    private lazy var postView = PostView()
    
    // MARK: - Properties
    
    weak var delegate: PostCellDelegate?
    var indexPath: IndexPath?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupSubviews() {
        contentView.addSubview(postView)
        postView.delegate = self
        postView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - PostViewDelegateProtocol
extension PostCell: PostViewDelegateProtocol {
    func openImage(_ image: UIImage) {
        delegate?.openImage(image)
    }
}

// MARK: - Extensions
extension PostCell {
    func configure(with viewModel: PostView.ViewModel) {
        postView.configure(with: viewModel)
    }
}
