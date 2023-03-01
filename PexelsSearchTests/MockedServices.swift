import XCTest
import Combine

@testable import PexelsSearch

class MockedSearchPhotoService: PhotoListServiceProtocol {
    let result: SearchResult
    let delay: TimeInterval

    init(result: SearchResult, delay: TimeInterval = 0) {
        self.result = result
        self.delay = delay
    }

    func search(query: String) -> AnyPublisher<SearchResult, Error> {
        if delay == 0 {
            return Just(result)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Just(result)
                .delay(for: .seconds(delay), scheduler: DispatchQueue.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

class MockedSearchErrorService: PhotoListServiceProtocol {
    let error: Error

    init(error: Error) {
        self.error = error
    }

    func search(query: String) -> AnyPublisher<SearchResult, Error> {
        return Fail<SearchResult, Error>(error: error).eraseToAnyPublisher()
    }
}
