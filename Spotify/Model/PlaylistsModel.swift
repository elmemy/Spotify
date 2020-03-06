//
//  PlaylistsModel.swift
//  Spotify
//
//  Created by ahmed elmemy on 3/6/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//


import Foundation

// MARK: - PlaylistsModel
struct PlaylistsModel: Codable {
    let message: String
    let playlists: Playlists
}

// MARK: - Playlists
struct Playlists: Codable {
    let href: String
    let items: [Item]
    let limit: Int
    let next: JSONNull?
    let offset: Int
    let previous: JSONNull?
    let total: Int
}

// MARK: - Item
struct Item: Codable {
    let collaborative: Bool
    let itemDescription: String
    let externalUrls: ExternalUrls
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let owner: Owner
    let primaryColor, itemPublic: JSONNull?
    let snapshotID: String
    let tracks: Tracks
    let type: ItemType
    let uri: String

    enum CodingKeys: String, CodingKey {
        case collaborative
        case itemDescription = "description"
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case primaryColor = "primary_color"
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Image
struct Image: Codable {
    let height: JSONNull?
    let url: String
    let width: JSONNull?
}

// MARK: - Owner
struct Owner: Codable {
    let displayName: DisplayName
    let externalUrls: ExternalUrls
    let href: String
    let id: ID
    let type: OwnerType
    let uri: URI

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri
    }
}

enum DisplayName: String, Codable {
    case spotify = "Spotify"
}

enum ID: String, Codable {
    case spotify = "spotify"
}

enum OwnerType: String, Codable {
    case user = "user"
}

enum URI: String, Codable {
    case spotifyUserSpotify = "spotify:user:spotify"
}

// MARK: - Tracks
struct Tracks: Codable {
    let href: String
    let total: Int
}

enum ItemType: String, Codable {
    case playlist = "playlist"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
