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
