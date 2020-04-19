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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarBottomBorder: UIView!
    @IBOutlet weak var searchLabel: UILabel!

    private let store: SearchArticlesStore = .shared
    private let dataSource: ArticleSearchDataSource = .init()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupSearchBar()

        dataSource.configure(collectionView)

        store.searchResultArticlesObservable
            .bind(to: Binder(collectionView) { collectionView, _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)

        searchBar.rx.text
            .filter { $0 == "" }
            .subscribe(onNext: { _ in
                ActionCreator.didClearQuery()
            })
            .disposed(by: disposeBag)

        searchBar.rx.textDidBeginEditing
            .subscribe(onNext: { [weak self] in
                self?.searchBarAnimate(isHidden: true)
            })
            .disposed(by: disposeBag)

        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.cancelButtonClicked()
            })
            .disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchButtonClicked()
            })
            .disposed(by: disposeBag)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupSearchBar() {
        searchBar.backgroundImage = UIImage()
    }

    private func searchBarAnimate(isHidden: Bool) {
        navigationController?.setNavigationBarHidden(isHidden, animated: true)
        searchBar.setShowsCancelButton(isHidden, animated: true)
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.searchBarBottomBorder.alpha = isHidden ? 1 : 0
            self?.searchLabel.isHidden = isHidden
            self?.searchLabel.alpha = isHidden ? 0 : 1
        })
    }

    private func cancelButtonClicked() {
        searchBar.text = nil
        ActionCreator.didTapCancelButton()
        searchBar.resignFirstResponder()
        searchLabel.alpha = -1
        searchBarAnimate(isHidden: false)
    }

    private func searchButtonClicked() {
        guard let term = searchBar.text else { return }

        ActionCreator.fetchSearchResults(by: term)
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
