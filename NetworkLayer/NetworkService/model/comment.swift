//
//  comment.swift
//  NetworkLayer
//
//  Created by hamid on 06.02.25.
//

import Foundation


// MARK: - CommitElement
struct CommitElement: Codable {
    let postID, id: Int?
    let name, email, body: String?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

typealias Commitarray = [CommitElement]
