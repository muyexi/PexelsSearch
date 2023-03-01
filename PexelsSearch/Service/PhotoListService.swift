import Foundation
import Combine

protocol PhotoListServiceProtocol {
    func search(query: String) -> AnyPublisher<SearchResult, Error>
}

class PhotoListService: PhotoListServiceProtocol {
    let webRepository: SearchPhotoWebRepository

    init(webRepository: SearchPhotoWebRepository) {
        self.webRepository = webRepository
    }

    func search(query: String) -> AnyPublisher<SearchResult, Error> {
        return webRepository.request(params: [
            "query": query,
            "per_page": "100",
        ])
    }
}
