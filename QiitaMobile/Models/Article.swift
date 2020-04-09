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
    public var attributedText: NSAttributedString
    public var isPrivate: Bool
    public var group: String?
    public var coediting: Bool
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
            let attributedText = json["rendered_body"].string?.convertHtml(),
            let isPrivate = json["private"].bool,
            let coediting = json["coediting"].bool,
            let commentsCount = json["comments_count"].int,
            let reactionsCount = json["reactions_count"].int
        else { return nil }

        self.id = id
        self.title = title
        self.author = author
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.url = url
        self.attributedText = attributedText
        self.isPrivate = isPrivate
        group = json["group"].string
        self.coediting = coediting
        self.commentsCount = commentsCount
        self.reactionsCount = reactionsCount
        pageViewsCount = json["page_views_count"].int
        tags = ArticleTag.load(json["tags"].arrayValue)
    }
}
