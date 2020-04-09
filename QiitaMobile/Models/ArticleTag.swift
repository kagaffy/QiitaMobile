//
//  ArticleTag.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/10.
//

import SwiftyJSON

public class ArticleTag {
    public var name: String
    public var versions: [String]

    public init?(_ json: JSON) {
        guard let name = json["name"].string else { return nil }

        self.name = name
        versions = json["versions"].arrayValue.compactMap { $0.string }
    }

    public static func load(_ list: [JSON]) -> [ArticleTag] {
        return list.compactMap { ArticleTag($0) }
    }
}
