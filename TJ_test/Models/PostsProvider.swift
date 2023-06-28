//
//  PostsProvider.swift
//  TJ_test
//
//  Created by Gleb Chataev on 26.06.23.
//

import Foundation
import Alamofire

// MARK: - PostsProviderProtocol
protocol PostsProviderProtocol {
    func getNewPage(completion: @escaping (Page) -> ()?)
}

// MARK: - Constants
extension PostsProvider {
    private enum Constants {
        static let requestURL = "https://api.dtf.ru/v2.1/timeline"
    }
}

// MARK: - PostsProvider
final class PostsProvider: PostsProviderProtocol {
    // MARK: - Properties
    private var lastID: Int?
    
    // MARK: - Public methods
    func getNewPage(completion: @escaping (Page) -> ()?) {
        let params: Parameters = [
            "lastId": lastID ?? 0
        ]
        AF.request(Constants.requestURL, method: .get, parameters: params)
            .validate()
            .responseDecodable(of: PostsResponse.self) { response in
                switch response.result {
                case let .success(posts):
                    self.lastID = posts.result.lastId
                    completion(.init(posts: posts.toDomain()))
                case .failure:
                    break
                }
            }
    }
}
