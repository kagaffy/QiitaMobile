//
//  TrendArticlesDataSource.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import UIKit

final class TrendArticlesDataSource: NSObject {
    private let store: TrendArticlesStore = .shared

    func configure(_ collectionView: UICollectionView) {
        registerAllCollectionViewCells(to: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TrendArticlesDataSource: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //
    // MARK: UICollectionViewDataSource
    //

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return store.dailyTrendArticles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ArticleCardCell.dequeue(from: collectionView, for: indexPath)
        cell.apply(article: store.dailyTrendArticles[indexPath.item])
        return cell
    }

    //
    // MARK: UICollectionViewDelegate
    //

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ArticleCardCell
        let article = store.dailyTrendArticles[indexPath.item]
        ActionCreator.didTapCardArticle(cell: cell, article: article)
    }

    //
    // MARK: UICollectionViewDelegateFlowLayout
    //

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        return ArticleCardCell.estimatedSize(width: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension TrendArticlesDataSource: CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] {
        return [
            ArticleCardCell.self,
        ]
    }
}
