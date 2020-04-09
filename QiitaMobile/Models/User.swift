//
//  User.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/09.
//

import SwiftDate
import SwiftyJSON

public class User {
    public let permanentId: Int
    public var id: String
    public var name: String
    public var githubName: String?
    public var description: String?
    public var followeesCount: Int
    public var followersCount: Int
    public var facebookId: String?
    public var itemsCount: Int
    public var linkedinId: String?
    public var location: String?
    public var organization: String?
    public var profileImageUrl: URL
    public var isTeamOnly: Bool
    public var twitterName: String?
    public var websiteUrl: URL?

    public init?(_ json: JSON) {
        guard
            let permanentId = json["permanent_id"].int,
            let id = json["id"].string,
            let name = json["name"].string,
            let followeesCount = json["followees_count"].int,
            let followersCount = json["followers_count"].int,
            let itemsCount = json["items_count"].int,
            let profileImageUrl = URL(string: json["profile_image_url"].stringValue),
            let isTeamOnly = json["team_only"].bool
        else { return nil }

        self.permanentId = permanentId
        self.id = id
        self.name = name
        githubName = json["github_login_name"].string
        description = json["description"].string
        self.followeesCount = followeesCount
        self.followersCount = followersCount
        facebookId = json["facebool_id"].string
        self.itemsCount = itemsCount
        linkedinId = json["linkedin_id"].string
        location = json["location"].string
        organization = json["organization"].string
        self.profileImageUrl = profileImageUrl
        self.isTeamOnly = isTeamOnly
        twitterName = json["twitter_screen_name"].string
        websiteUrl = URL(string: json["website_url"].stringValue)
    }
}
