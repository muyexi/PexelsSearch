import Combine
import Foundation

protocol WebRepository {
    var session: URLSession { get }

    var baseURL: String { get }
    var path: String { get }

    var method: String { get }
    var headers: [String: String]? { get }
}

extension WebRepository {
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true

        return URLSession(configuration: configuration)
    }

    func request<Value>(params: [String: String]) -> AnyPublisher<Value, Error>
    where Value: Decodable {
        do {
            let request = try createRequest(baseURL: baseURL, params: params)
            return
                session
                .dataTaskPublisher(for: request)
                .requestJSON()
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }

    func createRequest(baseURL: String, params: [String: String]) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        components.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers

        return request
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>() -> AnyPublisher<Value, Error> where Value: Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return tryMap { element -> Data in
            guard let httpResponse = element.response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                throw URLError(.badServerResponse)
            }
            return element.data
        }
        .decode(type: Value.self, decoder: decoder)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
