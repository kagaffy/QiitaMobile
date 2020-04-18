//
//  ArticleDetailsVC.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import markymark
import RxCocoa
import RxSwift
import UIKit

class ArticleDetailsVC: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var dismissButton: UIBarButtonItem!
    @IBOutlet weak var cardContentView: ArticleCardContentView!
    @IBOutlet weak var mdView: MarkDownTextView!
    @IBOutlet weak var cardBottomToRootBottomConstraint: NSLayoutConstraint!

    private let store: TrendArticlesStore = .shared
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()

        QiitaMarkDownStyling.apply(to: mdView)

        store.selectedArticleObservable
            .subscribe { [weak self] in
                guard let article = $0.element?.1 else { return }
                self?.cardContentView.loadView(article: article)
            }
            .disposed(by: disposeBag)

        store.selectedArticleDetailsObservable
            .subscribe { [weak self] in
                guard let article = $0.element else { return }
                self?.mdView.text = article?.bodyString
            }
            .disposed(by: disposeBag)

        scrollView.rx.didScroll
            .subscribe(onNext: { [weak self] in
                self?.changeCardContentViewScaleIfNeeded()
                self?.setNavigationTitleIfNeeded()
            })
            .disposed(by: disposeBag)

        scrollView.rx.willEndDragging
            .subscribe(onNext: { [weak self] velocity, _ in
                self?.dismissIfNeeded(velocity: velocity)
            })
            .disposed(by: disposeBag)

        dismissButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        ActionCreator.fetchArticleDetails()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        ActionCreator.disappearDetailsPage()
    }

    private func setupNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

    private func setNavigationTitleIfNeeded() {
        if scrollView.contentOffset.y > cardContentView.bounds.height {
            navigationBar.items?.first?.title = store.selectedArticle?.title
        } else {
            navigationBar.items?.first?.title = nil
        }
    }

    private func changeCardContentViewScaleIfNeeded() {
        guard scrollView.contentOffset.y < 0 else { return }

        let width = cardContentView.bounds.width
        let scale: CGFloat = (width - scrollView.contentOffset.y) / width
        cardContentView.transform = .init(scaleX: scale, y: scale)
    }

    private func dismissIfNeeded(velocity: CGPoint) {
        guard scrollView.contentOffset.y < 0 else { return }

        if velocity.y < 0 {
            dismiss(animated: true)
        }
    }
}
