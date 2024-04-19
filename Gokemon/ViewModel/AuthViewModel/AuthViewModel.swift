//
//  AuthViewModel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import Foundation
import UIKit

protocol AuthDelegate {
    func onSuccess()
    func onError(error: Error)
}

protocol AuthViewModel {
    var delegate: AuthDelegate? { get set }
    func loginGoogle(vc: UIViewController)
}
