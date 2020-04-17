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
        // MARK: textView
        //

//        let textView = UITextView()
//        textView.font = UIFont(name: "HiraginoSans-W3", size: 15)
//        textView.text = text
//        textView.frame = containerView.convert(secondViewController.textView.frame, from: secondViewController.scrollView)
//        textView.frame.origin.y += 50
//        containerView.addSubview(textView)
//        textView.alpha = -1

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            cardView.frame = containerView.convert(secondViewController.cardContentView.frame, from: secondViewController.scrollView)
//            textView.frame = containerView.convert(secondViewController.textView.frame, from: secondViewController.scrollView)
//            textView.alpha = 1
        }, completion: { [cell] _ in
            secondViewController.view.alpha = 1
            // 遷移後のイメージを表示する
            secondViewController.cardContentView.isHidden = false
            // セルのイメージの非表示を元に戻す
            cell.articleCardContentView.isHidden = false
            // アニメーション用のビューを削除する
            cardView.removeFromSuperview()
//            textView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
//        let options = UIView.KeyframeAnimationOptions(rawValue: UIView.AnimationOptions.curveEaseOut.rawValue)
//        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: options, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6, animations: {
//                cardView.frame = containerView.convert(secondViewController.cardContentView.frame, from: secondViewController.scrollView)
//            })
//            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
//                textView.frame = containerView.convert(secondViewController.textView.frame, from: secondViewController.scrollView)
//                textView.alpha = 1
//            })
//        }, completion: { [cell] _ in
//            secondViewController.view.alpha = 1
//            // 遷移後のイメージを表示する
//            secondViewController.cardContentView.isHidden = false
//            // セルのイメージの非表示を元に戻す
//            cell.articleCardContentView.isHidden = false
//            // アニメーション用のビューを削除する
//            cardView.removeFromSuperview()
//            textView.removeFromSuperview()
//            transitionContext.completeTransition(true)
//        })

//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//            cardView.frame = containerView.convert(secondViewController.cardContentView.frame, from: secondViewController.scrollView)
//            textView.frame = containerView.convert(secondViewController.textView.frame, from: secondViewController.scrollView)
//            textView.alpha = 1
//        }, completion: { [cell] _ in
//            secondViewController.view.alpha = 1
//            // 遷移後のイメージを表示する
//            secondViewController.cardContentView.isHidden = false
//            // セルのイメージの非表示を元に戻す
//            cell.articleCardContentView.isHidden = false
//            // アニメーション用のビューを削除する
//            cardView.removeFromSuperview()
//            textView.removeFromSuperview()
//            transitionContext.completeTransition(true)
//        })
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
    let text = """
    台湾を1週間歩き回ったが、しばしば思うことがあった。それは、台湾の空気が白っぽい、ということだ。そこで、台湾の大気汚染について、台湾人の日常生活と関連づけてまとめた。

    そもそも、空気の色以外にも大気汚染の裏付けとなるような発見をいくつかした。バイクの数が多いこと、タクシーやバスの運転が荒いこと、自転車が全然走っていないこと、そして洗濯物が見当たらないことだ。最初の3つが大気汚染の原因となりうることは予想できるかもしれない。最後の洗濯物については、外干ししている家が見当たらないと言う意味だ。これはかなり偏見じみているのだが、おそらく、大気汚染が酷くて外干ししたくないのだと推測した。以下、調べた結果について記述する。

    まず、大気汚染の原因についてだが、大きく分けて3つある。交通汚染、工業汚染、大陸からの季節風だ。それぞれが3分の1の割合である。台湾の電気は主に火力発電によって賄われているため、大気汚染の大きな要因となっている。しかし、火力発電を減らし、再生可能エネルギーの比率を上げると言う目標を掲げている。ちなみに、写真は高雄で撮った1枚だが、この辺りは工場が密集している地帯である。また、冬季季節風の影響で、中国大陸からのスモッグの飛来も原因として挙げられる。そのため、台湾の大気汚染は冬場がピークを迎える。

    次に、バイクの保有率についてだが、台湾でのバイクの総保有台数は1,270万台であり、これは日本とほぼ変わらない。割合で言うと、1.8人に1台といったところだ(日本は9.7人に1台)。バイクの密度がかなり大きいが、これは日本と比べて鉄道が少なく移動が不便であるという背景があると考えられる。また、バスやタクシーは全体的に急発進、急停車が多かった印象があるが、そのような運転は燃費を低下させる。そのため、交通量と運転方法が大気汚染の大きな要因となったのだろう。

    最後に、洗濯物についてだ。台湾では洗濯物は除湿器を用いて室内に干している。外に干さない理由は大気汚染によるものもあったのだが、それ以外にも、湿度が高くてなかなか乾かない、それによって臭いやすくなってしまう、夏は日差しが強すぎてパリパリになってしまう、などの理由があった。

    台湾と日本は別の国であるため、当然異なる点がいくつもあった。今まではそれを単なる文化の違いで片付けていたが、深く考えてみると、その文化の違いは交通の便や環境の要因が深く結びついているのだと分かり、今回の旅はそれに気づく良い経験となった。
    """
}

extension UIViewController {
    func ensureViewIsLoaded() {
        _ = view
    }
}
