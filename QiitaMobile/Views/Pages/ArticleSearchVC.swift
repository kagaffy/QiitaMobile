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

        searchBar.delegate = self

        dataSource.configure(collectionView)

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        searchBar.backgroundImage = UIImage()

        store.searchResultArticlesObservable
            .bind(to: Binder(collectionView) { collectionView, _ in
                collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension ArticleSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {}

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.setNavigationBarHidden(true, animated: true)
        searchBar.setShowsCancelButton(true, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            self?.searchBarBottomBorder.alpha = 1
            self?.searchLabel.isHidden = true
            self?.searchLabel.alpha = 0
        })
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ActionCreator.didTapCancelButton()
        searchBar.resignFirstResponder()
        searchLabel.alpha = -1
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.setShowsCancelButton(false, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            self?.searchBarBottomBorder.alpha = 0
            self?.searchLabel.isHidden = false
            self?.searchLabel.alpha = 1
        })
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }

        ActionCreator.fetchSearchResults(by: term)
        searchBar.resignFirstResponder()
    }
}
