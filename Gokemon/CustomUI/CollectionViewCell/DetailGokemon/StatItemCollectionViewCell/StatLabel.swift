//
//  StatLabel.swift
//  Gokemon
//
//  Created by Jan Sebastian on 19/04/24.
//

import UIKit

class StatLabel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private let stackContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let lblKeterangan: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.numberOfLines = 1
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let lblNumber: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private var keterangan: String = ""
    
    init(keterangan: String) {
        super.init(frame: .zero)
        self.keterangan = keterangan
        setupView()
        setupConstraints()
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        lblKeterangan.text = self.keterangan
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        self.layer.cornerRadius = 9
        self.clipsToBounds = true
        lblKeterangan.text = self.keterangan
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(red: 0.05, green: 0.12, blue: 0.25, alpha: 1.00)
        self.addSubview(stackContainer)
        stackContainer.addArrangedSubview(lblKeterangan)
        stackContainer.addArrangedSubview(lblNumber)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["stackContainer": stackContainer]
        var constraints: [NSLayoutConstraint] = []
        
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        let v_stackContainer = "V:|-10-[stackContainer]-10-|"
        let h_stackContainer = "H:|-15-[stackContainer]-15-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_stackContainer, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_stackContainer, options: .alignAllTop, metrics: nil, views: views)
        
        lblNumber.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblNumber, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension StatLabel {
    func setValue(value: Int) {
        lblNumber.text = "\(value)"
    }
    
    func setValue(value: Int, keterangan: String) {
        lblNumber.text = "\(value)"
        lblKeterangan.text = keterangan
    }
}
