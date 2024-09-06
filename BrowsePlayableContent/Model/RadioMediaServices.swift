//
//
//  Created by Yves Dukuze on 05/09/2024.
//

//RMS (Radio Media Services)
//

import Foundation


struct RMS: Decodable {
    let schema: String
    let data: [RMSResponse]

    enum CodingKeys: String, CodingKey {
        case schema = "$schema"
        case data
    }
}

struct RMSResponse: Decodable {
    let type, id: String
    let style: DecodableType?
    let title: String
    let description: DecodableType?
    let state: String
    let uris, controls, total: DecodableType?
    let data: [RMSData]
    let imageURL: DecodableType?

    enum CodingKeys: String, CodingKey {
        case type, id, style, title, description, state, uris, controls, total, data
        case imageURL = "image_url"
    }
}

struct RMSData: Decodable {
    let type: TypeEnum
    let id, urn: String
    let network: Network
    let titles: Titles
    let synopses: Synopses
    let imageURL: String
    let duration, progress: Duration
    let container, download: DecodableType?
    let availability: Availability
    let release: Release
    let guidance: DecodableType?
    let activities, uris: [DecodableType]
    let playContext, recommendation: DecodableType?

    enum CodingKeys: String, CodingKey {
        case type, id, urn, network, titles, synopses
        case imageURL = "image_url"
        case duration, progress, container, download, availability, release, guidance, activities, uris
        case playContext = "play_context"
        case recommendation
    }
}

struct Availability: Decodable {
    let from, to: DecodableType?
    let label: AvailabilityLabel
}

enum AvailabilityLabel: String, Codable {
    case live = "Live"
}

struct Duration: Codable {
    let value: Int
    let label: String
}

struct Network: Codable {
    let id, key, shortTitle, logoURL: String
    let networkType: NetworkType

    enum CodingKeys: String, CodingKey {
        case id, key
        case shortTitle = "short_title"
        case logoURL = "logo_url"
        case networkType = "network_type"
    }
}

enum NetworkType: String, Codable {
    case masterBrand = "master_brand"
    case service = "service"
}

struct Release: Codable {
    let date: Date?
    let label: ReleaseLabel?
}

enum ReleaseLabel: String, Codable {
    case the01Sep2024 = "01 Sep 2024"
    case the05Sep2024 = "05 Sep 2024"
    case the17Jun2024 = "17 Jun 2024"
    case the19Aug2024 = "19 Aug 2024"
    case the28Sep1990 = "28 Sep 1990"
}

struct Synopses: Codable {
    let short: String
    let medium, long: String?
}

struct Titles: Codable {
    let primary, secondary: String
    let tertiary: Tertiary
    let entityTitle: String

    enum CodingKeys: String, CodingKey {
        case primary, secondary, tertiary
        case entityTitle = "entity_title"
    }
}

enum Tertiary: String, Codable {
    case the05092024 = "05/09/2024"
}

enum TypeEnum: String, Codable {
    case playableItem = "playable_item"
}

enum DecodableType: Decodable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case null
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self = .null
        } else if let strignValue = try? container.decode(String.self) {
            self = .string(strignValue)
        } else if let intValue = try? container.decode(Int.self) {
            self = .int(intValue)
        } else if let doubleValue = try? container.decode(Double.self) {
            self = .double(doubleValue)
        } else if let boolValue = try? container.decode(Bool.self) {
            self = .bool(boolValue)
        } else {
            self = .unknown
        }
    }
}
