//
//  LoginViewController.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let imgLogo: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 1, alpha: 0.001)
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        return image
    }()
    
    private let btnGoogleLogin: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GoogleSignIn"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        return button
    }()
    
    private var viewModelAuth: AuthViewModel = AuthViewModelImpl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.12, blue: 0.25, alpha: 1.00)
        setupView()
        setupConstraints()
        viewModelAuth.delegate = self
        setupAction()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupView() {
        self.view.addSubview(imgLogo)
        self.view.addSubview(btnGoogleLogin)
    }
    
    private func setupConstraints() {
//        let views: [String: Any] = ["btnGoogleLogin": btnGoogleLogin]
        
        var constaints: [NSLayoutConstraint] = []
        
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        constaints += [NSLayoutConstraint(item: imgLogo, attribute: .top, relatedBy: .equal, toItem: self.view.layoutMarginsGuide, attribute: .top, multiplier: 1, constant: 144)]
        constaints += [NSLayoutConstraint(item: imgLogo, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)]
        
        btnGoogleLogin.translatesAutoresizingMaskIntoConstraints = false
        constaints += [NSLayoutConstraint(item: btnGoogleLogin, attribute: .top, relatedBy: .equal, toItem: imgLogo, attribute: .bottom, multiplier: 1, constant: 150)]
        constaints += [NSLayoutConstraint(item: btnGoogleLogin, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 220)]
        constaints += [NSLayoutConstraint(item: btnGoogleLogin, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 41)]
        constaints += [NSLayoutConstraint(item: btnGoogleLogin, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constaints)
    }

}

extension LoginViewController {
    private func setupAction() {
        btnGoogleLogin.addTarget(self, action: #selector(doLogin), for: .touchDown)
    }
    
    @objc private func doLogin() {
        viewModelAuth.loginGoogle(vc: self)
    }
}

extension LoginViewController: AuthDelegate {
    func onSuccess() {
        self.showToast(message: "login success", font: UIFont.systemFont(ofSize: 14))
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        let nav = UINavigationController(rootViewController: HomeViewController())
        nav.navigationBar.isHidden = true
        let homeVC = nav
        window?.rootViewController = UINavigationController(rootViewController: homeVC)
        window?.makeKeyAndVisible()
    }
    
    func onError(error: Error) {
        self.showToast(message: error.localizedDescription, font: UIFont.systemFont(ofSize: 14))
    }
    
    
}
