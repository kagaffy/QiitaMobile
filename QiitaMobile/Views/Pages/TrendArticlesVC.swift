//
//  TrendArticlesVC.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import RxCocoa
import RxSwift
import UIKit

class TrendArticlesVC: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let store: TrendArticlesStore = .shared
    private let dataSource: TrendArticlesDataSource = .init()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource.configure(collectionView)
    }
}
