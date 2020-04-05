//
//  ActionCreator.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

final class ActionCreator {
    private static let dispatcher: Dispatcher = .shared

    static func fetchTrendArticles() {
        GetTrendArticles().execute(in: .background).then(in: .main) { [dispatcher] articles in
            dispatcher.dispatch(.addTrendArticles(articles))
        }
    }

    static func didTapCardArticle(cell: ArticleCardCell, article: TrendArticle) {
        dispatcher.dispatch(.showArticleDetails(cell, article))
    }
}
