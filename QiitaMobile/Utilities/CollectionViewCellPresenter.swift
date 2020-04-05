//
//  CollectionViewCellPresenter.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import UIKit

// protocol CollectionViewCellPresenter: class {
//    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self
// }
//
// extension CollectionViewCellPresenter where Self: UICollectionViewCell {
//    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as! Self
//        return cell
//    }
// }

protocol CollectionViewCellPresenter: class {
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self
}

extension CollectionViewCellPresenter where Self: UICollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath) as! Self
        return cell
    }
}
