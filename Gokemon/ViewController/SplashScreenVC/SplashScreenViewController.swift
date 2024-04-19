//
//  SplashScreenViewController.swift
//  Gokemon
//
//  Created by Jan Sebastian on 18/04/24.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    private let imgLogo: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 1, alpha: 0.001)
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFit
        image.sizeToFit()
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 0.05, green: 0.12, blue: 0.25, alpha: 1.00)
        setupView()
        setupConstraints()
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
    }
    
    private func setupConstraints() {
        var constaints: [NSLayoutConstraint] = []
        
        imgLogo.translatesAutoresizingMaskIntoConstraints = false
        constaints += [NSLayoutConstraint(item: imgLogo, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)]
        constaints += [NSLayoutConstraint(item: imgLogo, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)]
        
        
        NSLayoutConstraint.activate(constaints)
    }

}
