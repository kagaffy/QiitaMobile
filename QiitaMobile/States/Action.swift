//
//  Action.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

enum Action {
    case addTrendArticles([TrendArticle])
    case showArticleDetails(ArticleCardCell, TrendArticle)
    case addArticleDetails(Article)
    case removeSelectedArticle
}
