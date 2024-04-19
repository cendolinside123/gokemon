//
//  AuthViewModelImpl.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation
import UIKit
import RxSwift
import GoogleSignIn

class AuthViewModelImpl {
    var delegate: AuthDelegate?
    private var disposableBag = DisposeBag()
    @Service private var usecaseGokemon: AuthUseCase
}


extension AuthViewModelImpl: AuthViewModel {
    func loginGoogle(vc: UIViewController) {
        usecaseGokemon
            .googleLogin(vc: vc)
            .asObservable()
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.delegate?.onSuccess()
            }, onError: { [weak self] error in
                self?.delegate?.onError(error: error)
            }).disposed(by: disposableBag)
    }
    
    
}
