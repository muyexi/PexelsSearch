import Foundation

// MARK: - Photo
struct Photo: Codable, Hashable, Identifiable {
    let id, width, height: Int
    let url: String
    let photographer: String
    let photographerURL: String?
    let photographerID: Int?
    let avgColor: String
    let src: PhotoSrc
    let liked: Bool?
    let alt: String

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Src
struct PhotoSrc: Codable, Hashable {
    let original, large, medium: String
    let small, portrait, landscape, tiny: String
}
