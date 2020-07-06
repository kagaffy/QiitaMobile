//
//  ArticleSearchVC.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/12.
//

import RxCocoa
import RxSwift
import UIKit

class ArticleSearchVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchResultsUpdater = self
        sc.searchBar.placeholder = "キーワードで検索"
        sc.searchBar.enablesReturnKeyAutomatically = false
        return sc
    }()

    private let store: SearchArticlesStore = .shared
    private let dataSource: ArticleSearchDataSource = .init()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()

        dataSource.configure(collectionView)

        store.searchResultArticlesObservable
            .bind(to: Binder(collectionView) { collectionView, _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        searchController.searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.cancelButtonClicked()
            })
            .disposed(by: disposeBag)

        searchController.searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchButtonClicked()
            })
            .disposed(by: disposeBag)
    }

    private func setupNavigationItem() {
        navigationItem.title = "検索"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func cancelButtonClicked() {
        ActionCreator.didTapCancelButton()
    }

    private func searchButtonClicked() {
        guard let term = searchController.searchBar.text else { return }

        ActionCreator.fetchSearchResults(by: term)
    }
}

extension ArticleSearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {}
}
