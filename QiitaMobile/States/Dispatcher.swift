//
//  Dispatcher.swift
//  QiitaMobile
//
//  Created by Tsukada Yoshiki on 2020/04/04.
//

import RxCocoa
import RxSwift

final class Dispatcher {
    static let shared: Dispatcher = .init()

    private let _action = PublishRelay<Action>()

    func register(callback: @escaping (Action) -> Void) -> Disposable {
        return _action.subscribe(onNext: callback)
    }

    func dispatch(_ action: Action) {
        _action.accept(action)
    }
}
