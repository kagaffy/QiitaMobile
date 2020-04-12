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
    @IBOutlet weak var searchLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension ArticleSearchVC: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            self?.searchLabel.alpha = 0
            self?.searchLabel.isHidden = true
        })
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        UIView.animate(withDuration: 0.3, delay: 0, animations: { [weak self] in
            self?.searchLabel.isHidden = false
        }, completion: { [weak self] _ in
            self?.searchLabel.alpha = 1
        })
    }
}
