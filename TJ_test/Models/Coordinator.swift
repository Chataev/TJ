//
//  Coordinator.swift
//  TJ_test
//
//  Created by Gleb Chataev on 28.06.23.
//

import UIKit

final class Coordinator {
    static let shared: Coordinator = Coordinator()
    var navigation = UINavigationController()
    
    private init() { }
    
    func openThreadsViewController() {
        let controller = ThreadsAssembly().make()
        navigation.pushViewController(controller, animated: true)
    }
    
    func openImageViewerViewControllr(image: UIImage) {
        let controller = ImageViewerViewController(image: image)
        controller.modalPresentationStyle = .overCurrentContext
        navigation.present(controller, animated: false)
    }
}
