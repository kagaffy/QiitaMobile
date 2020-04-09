//
//  ArticleDetailsVC.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import RxCocoa
import RxSwift
import UIKit

class ArticleDetailsVC: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardContentView: ArticleCardContentView!
    @IBOutlet weak var cardBottomToRootBottomConstraint: NSLayoutConstraint!

    private let store: TrendArticlesStore = .shared
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupContentView()
    }

    private func setupContentView() {
        guard let article = store.selectedArticle else { return }
        cardContentView.loadView(article: article)
    }
}
