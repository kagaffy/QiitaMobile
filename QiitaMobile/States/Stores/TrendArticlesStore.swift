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
    private let _selectedArticle = BehaviorRelay<TrendArticle?>(value: nil)

    private let disposeBag = DisposeBag()

    private init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }

            switch action {
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
        return _selectedArticle.value
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

    var selectedArticleObservable: Observable<TrendArticle?> {
        return _selectedArticle.asObservable()
    }
}
