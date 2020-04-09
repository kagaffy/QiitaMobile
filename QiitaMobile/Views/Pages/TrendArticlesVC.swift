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

//                cell.freezeAnimations()
//
//                // Get current frame on screen
//                let currentCellFrame = cell.layer.presentation()!.frame
//
//                // Convert current frame to screen's coordinates
//                let cardPresentationFrameOnScreen = cell.superview!.convert(currentCellFrame, to: nil)
//
//                // Get card frame without transform in screen's coordinates  (for the dismissing back later to original location)
//                let cardFrameWithoutTransform = { () -> CGRect in
//                    let center = cell.center
//                    let size = cell.bounds.size
//                    let r = CGRect(
//                        x: center.x - size.width / 2,
//                        y: center.y - size.height / 2,
//                        width: size.width,
//                        height: size.height
//                    )
//                    return cell.superview!.convert(r, to: nil)
//                }()
//
//                let params = CardTransition.Params(
//                    fromCardFrame: cardPresentationFrameOnScreen,
//                    fromCardFrameWithoutTransform: cardFrameWithoutTransform,
//                    fromCell: cell
//                )
//                let transition: CardTransition? = .init(params: params)
//
//                // Set up ArticleDetailsVC
//                let vc = ArticleDetailsVC()
//                vc.transitioningDelegate = transition
//
//                // If `modalPresentationStyle` is not `.fullScreen`, this should be set to true to make status bar depends on presented vc.
//                vc.modalPresentationCapturesStatusBarAppearance = true
//                vc.modalPresentationStyle = .custom
//
//                self.present(vc, animated: true, completion: { [cell] in
//                    cell.unfreezeAnimations()
//                })
                let vc = ArticleDetailsVC()
                self.navigationController?.pushViewController(vc, animated: true)
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
