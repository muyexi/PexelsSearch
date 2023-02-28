import SwiftUI
import Combine

enum LoadingStatus<T> {
    case none
    case loading
    case loaded(T)
    case failed(Error)
    
    var value: T? {
        switch self {
        case let .loaded(value):
            return value
        default:
            return nil
        }
    }
}

class PhotoListViewModel: ObservableObject {
    @Published var status: LoadingStatus<SearchResult> = .none
    @Published var searchText: String = ""

    let service: SearchPhotoRepository
    private var cancelBag = Set<AnyCancellable>()

    var statusMessage: String {
        switch status {
        case .none:
            return "Type to search"
        case .loading:
            return "Searching for \"\(searchText)\"..."
        case let .loaded(result):
            return "\(result.totalResults) results"
        case let .failed(error):
            return "An Error Occured: \(error.localizedDescription)"
        }
    }

    init(service: SearchPhotoRepository) {
        self.service = service

        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map({ query -> AnyPublisher<SearchResult, Error> in
                self.status = .loading
                return service.search(query: query)
            })
            .switchToLatest()
            .sink { completion in
                if case let .failure(error) = completion {
                    self.status = .failed(error)
                }
            } receiveValue: { result in
                self.status = .loaded(result)
            }.store(in: &cancelBag)
    }
}
