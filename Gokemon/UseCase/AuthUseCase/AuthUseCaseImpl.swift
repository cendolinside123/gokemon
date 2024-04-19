//
//  AuthUseCaseImpl.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation
import GoogleSignIn
import RxSwift


struct AuthUseCaseImpl {
    
}

extension AuthUseCaseImpl: AuthUseCase {
    func googleLogin(vc: UIViewController) -> RxSwift.Maybe<GIDSignInResult> {
        return Maybe.create(subscribe: { emmiter in
            
            GIDSignIn.sharedInstance.signIn(withPresenting: vc, completion: { signInResult, error in
                if let error {
                    let nsError = error as NSError
                    if nsError.code == GIDSignInError.canceled.rawValue {
                        emmiter(.completed)
                    } else {
                        emmiter(.error(error))
                    }
                } else {
                    if let signInResult {
                        emmiter(.success(signInResult))
                        emmiter(.completed)
                    } else {
                        emmiter(.error(ErrorResponse.CustomError("response empty")))
                    }
                }
            })
            
            return Disposables.create()
        })
    }
    
    
}
