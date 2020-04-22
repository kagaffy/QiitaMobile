//
//  PromiseOperation.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import Hydra
import Keys
import SwiftyJSON

public class PromiseOperation<Output> {
    public var request: Request?

    public var jsonResponse: ((JSON) -> Output)?

    public init() {
        jsonResponse = { _ in
            fatalError("Must implement `jsonResponse` in PromiseOperation subclass.")
        }
    }

    public func execute(in context: Context) -> Promise<Output> {
        return .init(in: context) { resolve, reject, _ in
            guard let request = self.request?.urlRequest else {
                // TODO: エラーを定義する
                fatalError("The variable `request` has no velue.")
            }

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    reject(error)
                } else if let data = data {
                    let json = JSON(data)
                    let object = self.jsonResponse!(json)
                    resolve(object)
                }
            }.resume()
        }
    }
}

public typealias ParameterDictionary = [String: Any]

public class Request {
    public static let baseUrl: String = "https://qiita.com/api/v2"
    public let urlRequest: URLRequest

    public init(url: URL, method: RequestMethod, parameters: ParameterDictionary) {
        urlRequest = Request.asUrlRequest(url: url, method: method, parameters: parameters)
    }

    public convenience init(endpoint: String, method: RequestMethod, parameters: ParameterDictionary = [:]) {
        let url = URL(string: "\(Request.baseUrl)\(endpoint)")!
        self.init(url: url, method: method, parameters: parameters)
    }

    public convenience init(trendEndpoint: String, method: RequestMethod, parameters: ParameterDictionary = [:]) {
        let url = URL(string: QiitaMobileKeys().trendBaseUrl)!
        self.init(url: url, method: method, parameters: parameters)
    }

    public static func asUrlRequest(url: URL, method: RequestMethod, parameters: ParameterDictionary) -> URLRequest {
        RequestConvertible.convert(url: url, method: method, parameters: parameters)
    }
}

public class RequestConvertible {
    public static func convert(url: URL, method: RequestMethod, parameters: ParameterDictionary) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if !parameters.isEmpty {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error)
            }
        }

        return request
    }
}

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

/// public class GetAccessToken: PromiseOperation<Void> {
///    public init(id: String = "") {
///        super.init()
///
///        request = Request(
///            endpoint: "/access_tokens",
///            method: .post,
///            parameters: [
///                "client_id": "",
///                "client_secret": "",
///                "code": "",
///            ]
///        )
///
///        jsonResponse = { json in
///            print(json)
///        }
///    }
/// }
