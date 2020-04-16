//
//  ArticleDetailsVC.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import MarkdownView
import RxCocoa
import RxSwift
import UIKit

class ArticleDetailsVC: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardContentView: ArticleCardContentView!
    @IBOutlet weak var mdView: MarkdownView!
    @IBOutlet weak var cardBottomToRootBottomConstraint: NSLayoutConstraint!
    private let mdView: MarkdownView = .init()

    private let store: TrendArticlesStore = .shared
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

//        store.selectedArticleDetailsObservable
//            .subscribe { [weak self] in
//                guard let `self` = self else { return }
//                guard let article = $0.element else { return }
//
//                self.mdView.load(markdown: article?.bodyString)
//                self.mdView.frame = self.view.bounds
//                self.view.addSubview(self.mdView)
//            }
//            .disposed(by: disposeBag)
        store.selectedArticleObservable
            .subscribe { [weak self] in
                guard let article = $0.element?.1 else { return }
                self?.cardContentView.loadView(article: article)
            }
            .disposed(by: disposeBag)

        store.selectedArticleDetailsObservable
            .subscribe { [weak self] in
                guard let article = $0.element else { return }
                self?.mdView.load(markdown: article?.bodyString)
            }
            .disposed(by: disposeBag)

        ActionCreator.fetchArticleDetails()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        ActionCreator.disappearDetailsPage()
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
