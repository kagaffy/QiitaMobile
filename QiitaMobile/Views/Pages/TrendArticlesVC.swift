//
//  TrendArticlesVC.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import RxCocoa
import RxSwift
import UIKit

class TrendArticlesVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    private let store: TrendArticlesStore = .shared
    private let dataSource: TrendArticlesDataSource = .init()
    private let disposeBag = DisposeBag()

    private lazy var showArticleDetailsDisposable: Disposable = {
        store.selectedArticleObservable
            .flatMap { ($0 != nil && $1 != nil) ? Observable.just(()) : .empty() }
            .bind(to: Binder(self) { `self`, _ in
                guard let cell = self.store.selectedCell else { return }
                guard let article = self.store.selectedArticle else { return }

                cell.freezeAnimations()

                let vc = ArticleDetailsVC()
                let transition: ZoomUpTransition? = .init(cell: cell)
                vc.transitioningDelegate = transition
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true) { [cell] in
                    cell.resetTransform()
                    cell.unfreezeAnimations()
                }
            })
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delaysContentTouches = false
        dataSource.configure(collectionView)

        store.dailyTrendArticlesObservable
            .map { _ in }
            .bind(to: Binder(collectionView) { collectionView, _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        _ = showArticleDetailsDisposable

        ActionCreator.fetchTrendArticles()
    }
}
