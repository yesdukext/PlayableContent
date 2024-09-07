
import Foundation

extension StationEntity {
    
    func RMSData(from entity: StationEntity) -> RMSData {
        
        return RMSData(
            type: TypeEnum(rawValue: "music") ?? "",
            id: entity.id ?? "",
            urn: entity.urn ?? "",
            network: Network(id: entity.network ?? ""),
            titles: Titles(primary: entity.title ?? ""),
            synopses: Synopses(short: entity.synopsis ?? ""),
            imageURL: entity.imageUrl ?? "",
            duration: Duration(value: Int(entity.duration ?? 0), label: ""),
            progress: <#T##Duration#>,
            container: <#T##DecodableType?#>,
            download: <#T##DecodableType?#>,
            availability: <#T##Availability#>,
            release: <#T##Release#>,
            guidance: <#T##DecodableType?#>,
            activities: <#T##[DecodableType]#>,
            uris: <#T##[DecodableType]#>,
            playContext: <#T##DecodableType?#>,
            recommendation: <#T##DecodableType?#>)
    }
}
