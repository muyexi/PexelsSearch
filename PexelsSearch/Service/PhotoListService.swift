import Foundation
import Combine

protocol PhotoListServiceProtocol {
    func search(query: String) -> AnyPublisher<SearchResult, Error>
}

class PhotoListService: PhotoListServiceProtocol {
    let webRepository: PhotoListWebRepository

    init(webRepository: PhotoListWebRepository) {
        self.webRepository = webRepository
    }

    func search(query: String) -> AnyPublisher<SearchResult, Error> {
        return webRepository.request(params: [
            "query": query,
            "per_page": "100",
        ])
    }
}
