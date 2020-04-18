//
//  ZoomUpTransition.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/15.
//

import UIKit

class ZoomUpTransition: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    fileprivate var isPresent = false
    fileprivate let cell: ArticleCardCell

    init(cell: ArticleCardCell) {
        self.cell = cell
    }

    // MARK: - UIViewControllerTransitioningDelegate
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 遷移時にTrasitionを担当する（UIViewControllerAnimatedTransitioningプロトコルを実装した）クラスを返す
        isPresent = true
        return self
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        // 復帰時にTrasitionを担当する（UIViewControllerAnimatedTransitioningプロトコルを実装した）クラスを返す
        isPresent = false
        return self
    }

    // MARK: - UIViewControllerAnimatedTransitioning
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            presentTransition(transitionContext: transitionContext)
        } else {
//            dissmissalTransition(transitionContext: transitionContext)
        }
    }

    // 遷移時のTrastion処理
    func presentTransition(transitionContext: UIViewControllerContextTransitioning) {
        // 遷移元、遷移先及び、遷移コンテナの取得
        let secondViewController = transitionContext.viewController(forKey: .to) as! ArticleDetailsVC
        let containerView = transitionContext.containerView

        //
        // MARK: cardView
        //

        // 遷移元のセルのイメージビューからアニメーション用のビューを作成
        let cardView = ArticleCardContentView()
        guard let article = TrendArticlesStore.shared.selectedArticle else { return }
        cardView.loadView(article: article)
        cardView.frame = containerView.convert(cell.articleCardContentView.frame, from: cell.articleCardContentView.superview)

        // 遷移元のセルのイメージビューを非表示にする
        cell.articleCardContentView.isHidden = true

        // 遷移後のビューコントローラを、予め最後の位置まで移動完了させ非表示にする
        secondViewController.view.frame = transitionContext.finalFrame(for: secondViewController)
        secondViewController.view.alpha = 0

        // 遷移後のイメージは、アニメーションが完了するまで非表示にする
        secondViewController.cardContentView.isHidden = true

        // 遷移コンテナに、遷移後のビューと、アニメーション用のビューを追加する
        containerView.addSubview(secondViewController.view)
        containerView.addSubview(cardView)

        //
        // MARK: NavigationBar
        //

        let navBar = UINavigationBar()
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.frame = containerView.convert(secondViewController.navigationBar.frame, from: secondViewController.view)
        navBar.frame.origin.y -= navBar.frame.height
        let navItem = UINavigationItem()
        navItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "dismiss"), style: .plain, target: nil, action: nil)
        navItem.leftBarButtonItem?.tintColor = .lightGray
        navBar.pushItem(navItem, animated: false)
        containerView.addSubview(navBar)
        navItem.leftBarButtonItem?.imageInsets = .init(top: 0, left: 8, bottom: 0, right: 0)

        //
        // MARK: MarkDownTextView
        //

        let mdView = UIView()
        mdView.backgroundColor = .white
        mdView.frame = containerView.convert(secondViewController.mdView.frame, from: secondViewController.scrollView)
        mdView.frame.origin.y -= 50 // 50 is top space
        mdView.alpha = -1
        containerView.addSubview(mdView)

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            cardView.frame = containerView.convert(secondViewController.cardContentView.frame, from: secondViewController.scrollView)
            navBar.frame = containerView.convert(secondViewController.navigationBar.frame, from: secondViewController.view)
            mdView.alpha = 1
        }, completion: { [cell] _ in
            secondViewController.view.alpha = 1
            // 遷移後のイメージを表示する
            secondViewController.cardContentView.isHidden = false
            // セルのイメージの非表示を元に戻す
            cell.articleCardContentView.isHidden = false
            // アニメーション用のビューを削除する
            cardView.removeFromSuperview()
            navBar.removeFromSuperview()
            mdView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

//    // 復帰時のTrastion処理
//    func dissmissalTransition(transitionContext: UIViewControllerContextTransitioning) {
//        // 遷移元、遷移先及び、遷移コンテナの取得
//        let secondViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! SecondViewController
//        let firstViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! FirstViewController
//        let containerView = transitionContext.containerView
//
//        // 遷移元のイメージビューからアニメーション用のビューを作成
//        let animationView = secondViewController.photoView.snapshotView(afterScreenUpdates: false)
//        animationView?.frame = containerView.convert(secondViewController.photoView.frame, from: secondViewController.photoView.superview)
//        // 遷移元のイメージを非表示にする
//        secondViewController.photoView.isHidden = true
//
//        // 遷移先のセルを取得
//        let cell:CollectionViewCell = firstViewController.collectionView?.cellForItem(at: secondViewController.indexPath) as! CollectionViewCell
//
//        // 遷移先のセルのイメージを非表示
//        cell.photoView.isHidden = true
//
//        //遷移後のビューコントローラを、予め最後の位置まで移動完了させ非表示にする
//        firstViewController.view.frame = transitionContext.finalFrame(for: firstViewController)
//
//        // 遷移コンテナに、遷移後のビューと、アニメーション用のビューを追加する
//        containerView.insertSubview(firstViewController.view, belowSubview: secondViewController.view)
//        containerView.addSubview(animationView!)
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//            // 遷移元のビューを徐々に非表示にする
//            secondViewController.view.alpha = 0
//            // アニメーションビューは、遷移後のイメージの位置まで、アニメーションする
//            animationView?.frame = containerView.convert(cell.photoView.frame, from: cell.photoView.superview)
//        }, completion: {
//            finished in
//            // アニメーション用のビューを削除する
//            animationView?.removeFromSuperview()
//            // 遷移元のイメージの非表示を元に戻す
//            secondViewController.photoView.isHidden = false
//            // セルのイメージの非表示を元に戻す
//            cell.photoView.isHidden = false
//            transitionContext.completeTransition(true)
//        })
//    }
}
