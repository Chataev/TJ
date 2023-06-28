//
//  Post.swift
//  TJ_test
//
//  Created by Gleb Chataev on 26.06.23.
//

import Foundation

// MARK: - Posts response
struct PostsResponse: Codable {
    let message: String?
    let result: ResultResponse
    
    func toDomain() -> [Post] {
        result.items.map { $0.toDomain() }
    }
}

struct ResultResponse: Codable {
    let items: [ItemResponse]
    let lastId: Int
}

struct ItemResponse: Codable {
    let type: String
    let data: PostDataResponse
    
    func toDomain() -> Post {
        var coverURLString: String?
        var coverText: String?
        if
            let imageBlock = data.blocks?.first(where: { $0.type == "media" && $0.cover }),
            let  imageUUID = imageBlock.data.items?.first?.image?.data.uuid {
            coverURLString = "https://leonardo.osnova.io/\(imageUUID)"
        }
        if
            let textBlock = data.blocks?.first(where: { $0.type == "text" && $0.cover }),
            let  text = textBlock.data.text {
            coverText = text
        }
        return Post(
            title: coverText ?? data.title,
            authorName: data.author.name,
            avatarURL: "https://leonardo.osnova.io/\(data.author.avatar.data.uuid)",
            date: Date(timeIntervalSince1970: TimeInterval(data.date)),
            counters: data.counters.toDomain(),
            coverImageURL: coverURLString
        )
    }
}
// MARK: - PostData response
struct PostDataResponse: Codable {
    let id: Int
    let title: String
    let date: Int
    let blocks: [BlockResponse]?
    let counters: CountersResponse
    let author: AuthorResponse
}

// MARK: - Other response models

enum BlockType: String, Codable {
    case text
    case media
}

struct BlockResponse: Codable {
    let type: String
    let data: BlockDataResponse
    let cover: Bool
}

struct BlockDataResponse: Codable {
    let text: String?
    let items: [BlockDataItemResponse]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.text = try container.decodeIfPresent(String.self, forKey: .text)
        do {
            self.items = try container.decodeIfPresent([BlockDataItemResponse].self, forKey: .items)
        } catch {
            self.items = []
        }
    }
}

struct BlockDataItemResponse: Codable {
    let title: String?
    let image: ImageResponse?
    
}

struct AuthorResponse: Codable {
    let name: String
    let avatar: ImageResponse
    let cover: ImageResponse?
}

struct CountersResponse: Codable {
    let comments: Int
    let favorites: Int
    let reposts: Int
    
    func toDomain() -> Counters {
        .init(comments: comments, favorites: favorites, reposts: reposts)
    }
}

struct ImageResponse: Codable {
    let data: ImageDataResponse
}

struct ImageDataResponse: Codable {
    let uuid: String
}

// MARK: - Domain model

struct Post {
    let title: String
    let authorName: String
    let avatarURL: String
    let date: Date
    let counters: Counters
    let coverImageURL: String?
}

struct Counters {
    let comments: Int
    let favorites: Int
    let reposts: Int
}

struct Page {
    let posts: [Post]
}
