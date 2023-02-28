import Foundation

// MARK: - SearchResult
struct SearchResult: Codable, Equatable {
    let totalResults, page, perPage: Int
    let photos: [Photo]
    let nextPage: String?
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        return lhs.photos == rhs.photos
    }
}

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

extension SearchResult {
    static var mockedData: SearchResult? {
        if let path = Bundle.main.path(forResource: "sample", ofType: "json"),
            let string = try? String(contentsOfFile: path, encoding: .utf8)
        {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try? decoder.decode(SearchResult.self, from: Data(string.utf8))
        } else {
            return nil
        }
    }
}
