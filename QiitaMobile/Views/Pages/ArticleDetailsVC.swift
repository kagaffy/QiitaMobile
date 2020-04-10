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
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cardBottomToRootBottomConstraint: NSLayoutConstraint!

    private let store: TrendArticlesStore = .shared
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        store.selectedArticleObservable
            .subscribe { [weak self] in
                guard let article = $0.element?.1 else { return }
                self?.cardContentView.loadView(article: article)
            }
            .disposed(by: disposeBag)

        store.selectedArticleDetailsObservable
            .subscribe { [weak self] in
                guard let article = $0.element else { return }
                self?.textView.attributedText = article?.attributedText
            }
            .disposed(by: disposeBag)

        ActionCreator.fetchArticleDetails()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        ActionCreator.disappearDetailsPage()
    }
}
