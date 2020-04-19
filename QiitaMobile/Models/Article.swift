//
//  Article.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/09.
//

import SwiftDate
import SwiftyJSON

public class Article {
    public let id: String
    public var title: String
    public var author: User
    public var createdAt: DateInRegion
    public var updatedAt: DateInRegion
    public var url: URL
    public var bodyString: String
    public var isPrivate: Bool
    public var group: String?
    public var coediting: Bool
    public var likesCount: Int
    public var commentsCount: Int
    public var reactionsCount: Int
    public var pageViewsCount: Int?
    public var tags: [ArticleTag]

    public init?(_ json: JSON) {
        guard
            let id = json["id"].string,
            let title = json["title"].string,
            let author = User(json["user"]),
            let createdAt = DateInRegion(json["created_at"].stringValue),
            let updatedAt = DateInRegion(json["updated_at"].stringValue),
            let url = URL(string: json["url"].stringValue),
            let bodyString = json["body"].string,
            let isPrivate = json["private"].bool,
            let coediting = json["coediting"].bool,
            let likesCount = json["likes_count"].int,
            let commentsCount = json["comments_count"].int,
            let reactionsCount = json["reactions_count"].int
        else { return nil }

        self.id = id
        self.title = title
        self.author = author
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.url = url
        self.bodyString = bodyString
        self.isPrivate = isPrivate
        group = json["group"].string
        self.coediting = coediting
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.reactionsCount = reactionsCount
        pageViewsCount = json["page_views_count"].int
        tags = ArticleTag.load(json["tags"].arrayValue)
    }

    public static func load(_ list: [JSON]) -> [Article] {
        return list.compactMap { Article($0) }
    }
}

public class GetArticleDetails: PromiseOperation<Article?> {
    public init(id: String) {
        super.init()

        url = URL(string: "https://qiita.com/api/v2/items/\(id)")!

        jsonResponse = { json in
            Article(json)
        }
    }
}

public class GetArticles: PromiseOperation<[Article]> {
    public init(query: String, page: Int = 1, perPage: Int = 30) {
        super.init()

        url = URL(string: "https://qiita.com/api/v2/items?page=\(page)&per_page=\(perPage)&query=\(query.urlEncoded)")!

        jsonResponse = { json in
            Article.load(json.arrayValue)
        }
    }
}
