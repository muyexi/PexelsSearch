import XCTest

@testable import PexelsSearch

final class PexelsSearchTests: XCTestCase {
    private let debouceDelay: TimeInterval = 0.5
    private let searchDelay: TimeInterval = 5

    private let mockedResult = SearchResult.mockedData!
    private let query = "nature"

    func test_not_loaded() throws {
        let service = MockedSearchPhotoRepository(result: mockedResult)
        let viewModel = PhotoListViewModel(service: service)
        viewModel.searchText = ""

        XCTAssertEqual(viewModel.statusMessage, "Type to search")
    }

    func test_loading() throws {
        let service = MockedSearchPhotoRepository(result: mockedResult, delay: searchDelay)

        let viewModel = PhotoListViewModel(service: service)
        viewModel.searchText = query

        wait(timeInSeconds: debouceDelay)
        XCTAssertEqual(viewModel.statusMessage, "Searching for \"\(viewModel.searchText)\"...")
    }

    func test_loaded() throws {
        let service = MockedSearchPhotoRepository(result: mockedResult)

        let viewModel = PhotoListViewModel(service: service)
        viewModel.searchText = query

        wait(timeInSeconds: debouceDelay)
        XCTAssertTrue(mockedResult == viewModel.status.value)
    }

    func test_loading_failed() throws {
        let error = URLError(.badServerResponse)
        let service = MockedSearchErrorRepository(error: error)

        let viewModel = PhotoListViewModel(service: service)
        viewModel.searchText = query

        wait(timeInSeconds: debouceDelay)
        XCTAssertEqual(viewModel.statusMessage, "An Error Occured: \(error.localizedDescription)")
    }

    // MARK: - Private
    func wait(timeInSeconds: TimeInterval) {
        let expectation = XCTestExpectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: .now() + timeInSeconds) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: timeInSeconds)
    }
}
