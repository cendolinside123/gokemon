//
//  AuthUseCase.swift
//  Gokemon
//
//  Created by Jan Sebastian on 16/04/24.
//

import Foundation
import GoogleSignIn
import RxSwift

protocol AuthUseCase {
    func googleLogin(vc: UIViewController) -> Maybe<GIDSignInResult>
}
