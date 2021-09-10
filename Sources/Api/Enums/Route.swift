//
// Route.swift
//

import Foundation
import Alamofire

enum Route: URLConvertible {
    
    case getLanguages
    case translate
    
    // MARK: - Internal var
    
    var method: HTTPMethod {
        switch self {
        case .getLanguages:
            return .get
        case .translate:
            return .post
        }
    }
    
    var headers: HTTPHeaders {
        var result = HTTPHeaders.default
        result.add(name: "Accept", value: "application/json")
        result.add(name: "Content-Type", value: "application/json")
        result.add(name: "Authorization", value: "Bearer sdf2fsd34lkkdfg")
        switch self {
        case .getLanguages:
            break
        case .translate:
            result.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        }
        return result
    }
    
    // MARK: - Private var
    
    private var baseUrl: URL {
        return URL(string: "https://backenster.com/v2/api/v3/")!
    }
    
    private var path: String {
        switch self {
        case .getLanguages:
            return "getLanguages"
        case .translate:
            return "translate"
        }
    }
    
    // MARK: - URLConvertible
    
    func asURL() throws -> URL {
        return baseUrl.appendingPathComponent(path)
    }
}
