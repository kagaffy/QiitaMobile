//
//  ActionCreator.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

final class ActionCreator {
    private static let dispatcher: Dispatcher = .shared
    
    static func didTapCardArticle(cell: ArticleCardCell, article: TrendArticle) {
        dispatcher.dispatch(.showArticleDetails(cell, article))
    }
}
