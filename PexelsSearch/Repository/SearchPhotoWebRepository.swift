import Foundation
import SwiftUI
import Combine

class SearchPhotoWebRepository: WebRepository {
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
}
