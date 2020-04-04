//
//  BaseViewController.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import UIKit

class BaseViewController: UIViewController {
    override func loadView() {
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView {
            self.view = view
        }
    }
}
