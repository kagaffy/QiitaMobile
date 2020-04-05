//
//  ArticleCardCell.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import UIKit

class ArticleCardCell: UICollectionViewCell, CollectionViewCellPresenter {
    @IBOutlet weak var articleCardContentView: ArticleCardContentView!

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

    func apply() {
    }
}
