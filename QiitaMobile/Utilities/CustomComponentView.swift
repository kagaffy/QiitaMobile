//
//  CustomComponentView.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/23.
//

import UIKit

class CustomComponentView: UIView {
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
}
