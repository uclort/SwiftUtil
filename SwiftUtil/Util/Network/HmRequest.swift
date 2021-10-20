//
//  HmRequest.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/9/1.
//

import Alamofire
import Foundation
import HandyJSON
import PromiseKit

enum HmError: Error, LocalizedError, CancellableError {
    case cancel(callReject: Bool = false)

    var isCancelled: Bool {
        switch self {
        case .cancel(let reject):
            return !reject
        }
    }

    var errorDescription: String? {
        switch self {
        case .cancel:
            return "已取消网络请求"
        }
    }
}

struct HmRequestObject<T> {
    private(set) var promise: Promise<T>
    private var resolver: Resolver<T>
    private(set) var request: DataRequest
    func cancel(reject: Bool = false) {
        request.cancel()
        if reject {
            resolver.reject(HmError.cancel(callReject: reject))
        }
    }

    init(promise: Promise<T>, resolver: Resolver<T>, request: DataRequest) {
        self.promise = promise
        self.resolver = resolver
        self.request = request
    }

    mutating func change(request: DataRequest) {
        self.request = request
    }
}

class HmRequest {
    static let `default` = HmRequest()
    private let manager = Session()
    private init() {}
    
    @discardableResult
    func requestToData(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) -> HmRequestObject<Data?> {
        let (promise, resolver) = Promise<Data?>.pending()
        let request = manager.request(
            convertible,
            method: method,
            parameters: parameters,
            encoding: encoder,
            headers: headers,
            interceptor: interceptor
        ).responseData { result in
            resolver.fulfill(result.value)
        }
        return HmRequestObject(
            promise: promise,
            resolver: resolver,
            request: request
        )
    }

    @discardableResult
    func requestToJSON<T>(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        dataType _: T.Type
    ) -> HmRequestObject<T?> {
        let (promise, resolver) = Promise<T?>.pending()
        let request = manager.request(
            convertible,
            method: method,
            parameters: parameters,
            encoding: encoder,
            headers: headers,
            interceptor: interceptor
        ).responseJSON { result in
            resolver.fulfill(result.value as? T)
        }
        return HmRequestObject(
            promise: promise,
            resolver: resolver,
            request: request
        )
    }

    @discardableResult
    func requestObject(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) -> HmRequestObject<Parameters?> {
        requestToJSON(
            convertible,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor,
            dataType: Parameters.self
        )
    }

    @discardableResult
    func requestArray(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil
    ) -> HmRequestObject<[Any]?> {
        requestToJSON(
            convertible,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor,
            dataType: [Any].self
        )
    }
}

// MARK: HandyJSON
extension HmRequest {
    @discardableResult
    func requestModelFromHandyJSON<T: HandyJSON>(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        _: T.Type
    ) -> HmRequestObject<T?> {
        let requestManager = requestObject(
            convertible,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor
        )
        let (promise, resolver) = Promise<T?>.pending()
        requestManager.promise.done { value in
            resolver.fulfill(T.deserialize(from: value))
        }.catch { error in
            resolver.reject(error)
        }
        return HmRequestObject(
            promise: promise,
            resolver: resolver,
            request: requestManager.request
        )
    }

    @discardableResult
    func requestModelGroupFromHandyJSON<T: HandyJSON>(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        _: T.Type
    ) -> HmRequestObject<[T]?> {
        let requestManager = requestArray(
            convertible,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor
        )
        let (promise, resolver) = Promise<[T]?>.pending()
        requestManager.promise.done { value in
            resolver.fulfill([T].deserialize(from: value)?.compactMap { $0 })
        }.catch { error in
            resolver.reject(error)
        }
        return HmRequestObject(
            promise: promise,
            resolver: resolver,
            request: requestManager.request
        )
    }
}

// MARK: Codable
extension HmRequest {
    @discardableResult
    func requestModelFromCodable<T: Codable>(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        _: T.Type
    ) -> HmRequestObject<T?> {
        let requestManager = requestToData(
            convertible,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor
        )
        let (promise, resolver) = Promise<T?>.pending()
        requestManager.promise.done { value in
            resolver.fulfill(value?.decoded(T.self))
        }.catch { error in
            resolver.reject(error)
        }
        return HmRequestObject(
            promise: promise,
            resolver: resolver,
            request: requestManager.request
        )
    }

    @discardableResult
    func requestModelGroupFromCodable<T: Codable>(
        _ convertible: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoder: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        interceptor: RequestInterceptor? = nil,
        _: T.Type
    ) -> HmRequestObject<[T]?> {
        let requestManager = requestToData(
            convertible,
            method: method,
            parameters: parameters,
            encoder: encoder,
            headers: headers,
            interceptor: interceptor
        )
        let (promise, resolver) = Promise<[T]?>.pending()
        requestManager.promise.done { value in
            resolver.fulfill(value?.decoded([T].self))
        }.catch { error in
            resolver.reject(error)
        }
        return HmRequestObject(
            promise: promise,
            resolver: resolver,
            request: requestManager.request
        )
    }
}
