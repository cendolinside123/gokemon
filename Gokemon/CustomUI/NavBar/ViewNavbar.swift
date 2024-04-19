//
//  ViewNavbar.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import UIKit

class ViewNavbar: UIView {

    private let btnExit: UIButton = {
        let button = UIButton()
        button.setTitle("<", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.sizeToFit()
        return button
    }()
    
    private let lblName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.80, green: 0.76, blue: 0.76, alpha: 1.00)
        return view
    }()
    
    var onExit: (() -> Void)?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(btnExit)
        self.addSubview(lblName)
        self.addSubview(line)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["btnExit": btnExit,
                                    "lblName": lblName,
                                    "line": line]
        
        var constraints: [NSLayoutConstraint] = []
        
        btnExit.translatesAutoresizingMaskIntoConstraints = false
        lblName.translatesAutoresizingMaskIntoConstraints = false
        let v_btnExit = "V:|-0-[btnExit]-0-|"
//        let h_btnExit = "H:|-16-[btnExit]"
        let v_lblName = "V:|-0-[lblName]-0-|"
        let h_content = "H:|-16-[btnExit]-16-[lblName]-16-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_btnExit, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_lblName, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_content, options: .alignAllTop, metrics: nil, views: views)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        let h_line = "H:|-16-[line]-16-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_line, options: .alignAllBottom, metrics: nil, views: views)
        constraints += [NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)]
        constraints += [NSLayoutConstraint(item: line, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension ViewNavbar {
    private func setupAction() {
        btnExit.addTarget(self, action: #selector(exitPage), for: .touchDown)
    }
    
    @objc private func exitPage() {
        onExit?()
    }
    
    func setTitle(value: String) {
        lblName.text = value
    }
}
