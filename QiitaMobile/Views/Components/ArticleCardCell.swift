//
//  ArticleCardCell.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import UIKit

class ArticleCardCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var articleCardContentView: ArticleCardContentView!

    private var disabledHighlightedAnimation: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 8
    }

    static func estimatedSize(width: CGFloat) -> CGSize {
        return .init(width: width, height: 100)
    }

    func apply(article: TrendArticle) {
        articleCardContentView.loadView(article: article)
    }

    func resetTransform() {
        transform = .identity
    }

    func freezeAnimations() {
        disabledHighlightedAnimation = true
        layer.removeAllAnimations()
    }

    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }

    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)? = nil) {
        guard !disabledHighlightedAnimation else { return }

        let animationOptions: AnimationOptions = [.allowUserInteraction]
        if isHighlighted {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: { [weak self] in
                    self?.transform = .init(scaleX: 0.96, y: 0.96)
                }, completion: completion
            )
        } else {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: animationOptions,
                animations: { [weak self] in
                    self?.transform = .identity
                }, completion: completion
            )
        }
    }
}
