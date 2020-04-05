//
//  QiitaTabBarController.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import UIKit

class QiitaTabBarController: UITabBarController {
    private struct TabBarItem {
        let title: String
        let image: UIImage
        let rootVC: UIViewController
    }

    private let tabBarItems: [TabBarItem] = [
        .init(
            title: "トレンド",
            image: #imageLiteral(resourceName: "trend"),
            rootVC: TrendArticlesVC()
        ),
        .init(
            title: "検索",
            image: #imageLiteral(resourceName: "search"),
            rootVC: UIViewController()
        ),
        .init(
            title: "LGTM",
            image: #imageLiteral(resourceName: "like"),
            rootVC: UIViewController()
        ),
        .init(
            title: "マイページ",
            image: #imageLiteral(resourceName: "my_page"),
            rootVC: UIViewController()
        ),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        apply()
    }

    private func apply() {
        var navs: [UINavigationController] = []
        tabBarItems.enumerated().forEach { tag, item in
            let nav = UINavigationController(rootViewController: item.rootVC)
            nav.tabBarItem = .init(title: item.title, image: item.image, tag: tag)
            navs.append(nav)
        }
        setViewControllers(navs, animated: false)
    }
}
