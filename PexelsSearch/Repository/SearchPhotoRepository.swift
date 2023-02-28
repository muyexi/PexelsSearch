import Foundation
import SwiftUI
import Combine

protocol SearchPhotoService {
    func search(query: String) -> AnyPublisher<SearchResult, Error>
}

class SearchPhotoRepository: SearchPhotoService, WebRepository {
    var baseURL: String {
        return "https://api.pexels.com/v1/"
    }

    var path: String {
        return "search"
    }

    var method: String {
        return "GET"
    }

    var headers: [String: String]? {
        return ["Authorization": "CxUQicuoiLEZylKgFloBJGGFPmaRyLmv2x7aE5maBrSnSx670powednn"]
    }

    func search(query: String) -> AnyPublisher<SearchResult, Error> {
        return request(params: [
            "query": query,
            "per_page": "20",
        ])
    }
}
