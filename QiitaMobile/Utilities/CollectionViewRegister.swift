//
//  CollectionViewRegister.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/05.
//

import UIKit

protocol CollectionViewRegister: class {
    var cellTypes: [UICollectionViewCell.Type] { get }
    var headerCellTypes: [UICollectionReusableView.Type] { get }
    func registerAllCollectionViewCells(to collectionView: UICollectionView)
    func registerCollectionViewCell(to collectionView: UICollectionView, cellType: UICollectionViewCell.Type)
    func registerCollectionViewHeaderCell(to collectionView: UICollectionView, cellType: UICollectionReusableView.Type)
}

extension CollectionViewRegister {
    var cellTypes: [UICollectionViewCell.Type] { return [] }
    var headerCellTypes: [UICollectionReusableView.Type] { return [] }

    func registerAllCollectionViewCells(to collectionView: UICollectionView) {
        cellTypes.forEach { cellType in
            registerCollectionViewCell(to: collectionView, cellType: cellType)
        }
        headerCellTypes.forEach { cellType in
            registerCollectionViewHeaderCell(to: collectionView, cellType: cellType)
        }
    }

    func registerCollectionViewCell(to collectionView: UICollectionView, cellType: UICollectionViewCell.Type) {
        let typeString = String(describing: cellType)
        collectionView.register(UINib(nibName: typeString, bundle: nil), forCellWithReuseIdentifier: typeString)
    }

    func registerCollectionViewHeaderCell(to collectionView: UICollectionView, cellType: UICollectionReusableView.Type) {
        let typeString = String(describing: cellType)
        collectionView.register(UINib(nibName: typeString, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: typeString)
    }
}
