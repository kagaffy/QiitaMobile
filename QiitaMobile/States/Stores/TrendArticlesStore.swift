//
//  TrendArticlesStore.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import RxCocoa
import RxSwift

final class TrendArticlesStore {
    static let shared: TrendArticlesStore = .init()

    private let _dailyTrendArticles = BehaviorRelay<[TrendArticle]>(value: [])
    private let _weeklyTrendArticles = BehaviorRelay<[TrendArticle]>(value: [])
    private let _monthlyTrendArticles = BehaviorRelay<[TrendArticle]>(value: [])
    private let _selectedCard = BehaviorRelay<(ArticleCardCell?, TrendArticle?)>(value: (nil, nil))
    private let _selectedArticleDetails = BehaviorRelay<Article?>(value: nil)

    private let disposeBag = DisposeBag()

    private init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }

            switch action {
            case let .addTrendArticles(articles):
                self._dailyTrendArticles.accept(articles)

            case let .showArticleDetails(cell, article):
                self._selectedCard.accept((cell, article))

            case let .addArticleDetails(article):
                self._selectedArticleDetails.accept(article)

            case .removeSelectedArticle:
                self._selectedCard.accept((nil, nil))
                self._selectedArticleDetails.accept(nil)

            default: break
            }
        }
        .disposed(by: disposeBag)
    }
}

//
// MARK: Value
//

extension TrendArticlesStore {
    var dailyTrendArticles: [TrendArticle] {
        return _dailyTrendArticles.value
    }

    var weeklyTrendArticles: [TrendArticle] {
        return _weeklyTrendArticles.value
    }

    var monthlyTrendArticles: [TrendArticle] {
        return _monthlyTrendArticles.value
    }

    var selectedArticle: TrendArticle? {
        return _selectedCard.value.1
    }

    var selectedCell: ArticleCardCell? {
        return _selectedCard.value.0
    }

    var selectedArticleDetails: Article? {
        return _selectedArticleDetails.value
    }
}

//
// MARK: Observable
//

extension TrendArticlesStore {
    var dailyTrendArticlesObservable: Observable<[TrendArticle]> {
        return _dailyTrendArticles.asObservable()
    }

    var weeklyTrendArticlesObservable: Observable<[TrendArticle]> {
        return _weeklyTrendArticles.asObservable()
    }

    var monthlyTrendArticlesObservable: Observable<[TrendArticle]> {
        return _monthlyTrendArticles.asObservable()
    }

    var selectedArticleObservable: Observable<(ArticleCardCell?, TrendArticle?)> {
        return _selectedCard.asObservable()
    }

    var selectedArticleDetailsObservable: Observable<Article?> {
        return _selectedArticleDetails.asObservable()
    }
}
