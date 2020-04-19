//
//  SearchArticlesStore.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/13.
//

import RxCocoa
import RxSwift

final class SearchArticlesStore {
    static let shared: SearchArticlesStore = .init()

    private let _searchResultArticles = BehaviorRelay<[Article]>(value: [])
    private let _selectedCard = BehaviorRelay<(ArticleCardCell?, Article?)>(value: (nil, nil))

    private let disposeBag = DisposeBag()

    private init(dispatcher: Dispatcher = .shared) {
        dispatcher.register { [weak self] action in
            guard let `self` = self else { return }

            switch action {
            case .clearSearchResults:
                self._searchResultArticles.accept([])

            case let .addSearchResults(articles):
                self._searchResultArticles.accept(articles)

            default: break
            }
        }
        .disposed(by: disposeBag)
    }
}

//
// MARK: Value
//

extension SearchArticlesStore {
    var articles: [Article] {
        return _searchResultArticles.value
    }
}

//
// MARK: Observable
//

extension SearchArticlesStore {
    var searchResultArticlesObservable: Observable<[Article]> {
        return _searchResultArticles.asObservable()
    }
}
