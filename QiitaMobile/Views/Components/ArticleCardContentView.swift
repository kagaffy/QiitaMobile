//
//  ArticleCardContentView.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import Kingfisher
import UIKit

class ArticleCardContentView: CustomComponentView {
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        authorImageView.backgroundColor = .lightGray
    }

    func loadView(article: TrendArticle) {
        authorImageView.image = nil
        authorImageView.kf.setImage(with: article.authorImageUrl)
        titleLabel.text = article.title
        newLabel.isHidden = !article.isNew
        authorNameLabel.text = "@\(article.authorId)"
        likesCountLabel.text = String(article.likesCount)
    }

    func loadView(article: Article) {
        authorImageView.image = nil
        authorImageView.kf.setImage(with: article.author.profileImageUrl)
        titleLabel.text = article.title
        newLabel.isHidden = true
        authorNameLabel.text = "@\(article.author.id)"
        likesCountLabel.text = String(article.likesCount)
    }
}
