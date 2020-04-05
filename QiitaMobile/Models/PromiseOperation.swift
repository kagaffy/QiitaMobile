//
//  PromiseOperation.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import Hydra
import SwiftyJSON

public class PromiseOperation<Value> {
    public var url: URL?
    public var jsonResponse: ((JSON) -> Value)?

    public init() {
        jsonResponse = { _ in
            fatalError("Must implement `jsonResponse` in PromiseOperation subclass.")
        }
    }

    public func execute(in context: Context? = nil) -> Promise<Value> {
        return .init(in: context) { resolve, reject, _ in
            URLSession.shared.dataTask(with: self.url!) { data, _, error in
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
