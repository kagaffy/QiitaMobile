//
//  TrendArticle.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import SwiftDate
import SwiftyJSON

public final class TrendArticle {
    public let id: String
    public var title: String
    public var createdAt: DateInRegion
    public var likesCount: Int
    public var isNew: Bool
    public var hasCodeBlock: Bool
    public var authorId: String
    public var authorImageUrl: URL

    public init?(_ json: JSON) {
        guard
            let id = json["node"]["uuid"].string,
            let title = json["node"]["title"].string,
            let createdAt = DateInRegion(json["node"]["createdAt"].stringValue),
            let likesCount = json["node"]["likesCount"].int,
            let isNew = json["isNewArrival"].bool,
            let hasCodeBlock = json["hasCodeBlock"].bool,
            let authorId = json["node"]["author"]["urlName"].string,
            let authorImageUrl = URL(string: json["node"]["author"]["profileImageUrl"].stringValue)
        else { return nil }

        self.id = id
        self.title = title
        self.createdAt = createdAt
        self.likesCount = likesCount
        self.isNew = isNew
        self.hasCodeBlock = hasCodeBlock
        self.authorId = authorId
        self.authorImageUrl = authorImageUrl
    }

    public static func load(_ list: [JSON]) -> [TrendArticle] {
        return list.compactMap { TrendArticle($0) }
    }
}

public class GetTrendArticles: PromiseOperation<[TrendArticle]> {
    public init(type: String = "") {
        super.init()

        request = Request(
            trendEndpoint: "/daily",
            method: .get
        )

        jsonResponse = { json in
            TrendArticle.load(json.arrayValue)
        }
    }
}
