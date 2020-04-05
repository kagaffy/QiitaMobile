//
//  ArticleCardContentView.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import UIKit

class ArticleCardContentView: UIView {
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        authorImageView.backgroundColor = .lightGray
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }

    func loadNib() {
        guard let view = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not load Nibfile.")
        }

        view.frame = bounds
        addSubview(view)
    }

    func loadView() {}
}
