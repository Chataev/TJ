//
//  ImageViewerViewController.swift
//  TJ_test
//
//  Created by Gleb Chataev on 28.06.23.
//

import UIKit
import SnapKit

// MARK: - ImageViewerViewController
final class ImageViewerViewController: UIViewController {
    // MARK: - Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.view.frame
        scrollView.delegate = self
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.contentSize = imageView.image!.size
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(closeController), for: .touchUpInside)
        button.setImage(.init(named: "close_button"), for: .normal)
        return button
    }()
    
    private let imageView = UIImageView()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    // MARK: - Initialization
    
    convenience init(image: UIImage) {
        self.init(nibName: nil, bundle: nil)
        self.imageView.image = image
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.imageView.image = UIImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubiews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        setZoomScale(for: scrollView.bounds.size)
        recenterImage()
    }
    
    // MARK: - Private methods
    
    private func setupSubiews() {
        view.backgroundColor = .black.withAlphaComponent(0.15)
        view.addSubviews([blurEffectView, scrollView, closeButton])
        scrollView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.width.equalTo(30)
        }
    }

    private func recenterImage() {
        let scrollViewSize = scrollView.bounds.size
        let imageViewSize = imageView.frame.size
        let horizontalSpace = imageViewSize.width < scrollViewSize.width
        ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        let verticalSpace = imageViewSize.height < scrollViewSize.height
        ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalSpace, left: horizontalSpace, bottom: verticalSpace, right: horizontalSpace)
    }
    
    private func setZoomScale(for scrollViewSize: CGSize) {
        let imageSize = imageView.image!.size
        let widthScale = scrollViewSize.width / imageSize.width
        let heightScale = scrollViewSize.height / imageSize.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    @objc
    private func closeController() {
        self.dismiss(animated: false)
    }
}

// MARK: - UIScrollViewDelegate
extension ImageViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
}
