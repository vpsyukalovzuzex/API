//
// Api.swift
//

import Foundation
import Alamofire
import PromiseKit

public class Api {
    
    // MARK: - Public static var
    
    public static var parameters = [String: String]()
    
    // MARK: - Private static let
    
    private static let rootQueue = DispatchQueue(
        label: "com.nordicwise.api.session.queue.root",
        qos: .default
    )
    
    private static let requestQueue = DispatchQueue(
        label: "com.nordicwise.api.session.queue.request",
        qos: .default,
        attributes: .concurrent
    )
    
    private static let serializationQueue = DispatchQueue(
        label: "com.nordicwise.api.session.queue.serialization",
        qos: .default,
        attributes: .concurrent
    )
    
    private static let session: Session = {
        let result = Session(
            rootQueue: rootQueue,
            requestQueue: requestQueue,
            serializationQueue: serializationQueue
        )
        return result
    }()
    
    // MARK: - Public func
    
    @discardableResult
    public static func getLanguages(_ block: @escaping (Swift.Result<LanguagesResponse, Error>) -> Void) -> DataRequest {
        return request(.getLanguages, nil, LanguagesResponse.self, block).dataRequest
    }
    
    @discardableResult
    public static func getLanguages() -> Promise<LanguagesResponse> {
        return request(.getLanguages, nil, LanguagesResponse.self, nil).promise
    }
    
    @discardableResult
    public static func translate(
        _ data: String,
        _ from: String,
        _ to: String,
        _ enableTransliteration: Bool,
        _ block: @escaping (Swift.Result<TranslateResponse, Error>) -> Void
    ) -> DataRequest {
        let parameters = [
            "data": data,
            "from": from,
            "to": to,
            "enableTransliteration": "\(enableTransliteration)"
        ]
        return request(.translate, parameters, TranslateResponse.self, block).dataRequest
    }
    
    @discardableResult
    public static func  translate(
        _ data: String,
        _ from: String,
        _ to: String,
        _ enableTransliteration: Bool
    ) -> Promise<TranslateResponse> {
        let parameters = [
            "data": data,
            "from": from,
            "to": to,
            "enableTransliteration": "\(enableTransliteration)"
        ]
        return request(.translate, parameters, TranslateResponse.self, nil).promise
    }
    
    // MARK: - Private func
    
    @discardableResult
    private static func request<T: Decodable>(
        _ route: Route,
        _ parameters: [String: String]?,
        _ decodable: T.Type,
        _ block: ((Swift.Result<T, Error>) -> Void)?
    ) -> (dataRequest: DataRequest, promise: Promise<T>) {
        let dataRequest = Api.session
            .request(route, method: route.method, parameters: Api.parameters.merged(with: parameters), headers: route.headers)
            .validate()
        let promise = Promise<T> { seal in
            dataRequest.responseDecodable(of: decodable) { response in
                switch response.result {
                case .success(let value):
                    block?(.success(value))
                    seal.fulfill(value)
                case .failure(let error):
                    block?(.failure(error))
                    seal.reject(error)
                }
            }
        }
        return (dataRequest, promise)
    }
}
