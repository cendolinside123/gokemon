//
//  KeteranganCollectionViewCell.swift
//  Gokemon
//
//  Created by Jan Sebastian on 19/04/24.
//

import UIKit

class KeteranganCollectionViewCell: UICollectionViewCell {
    private let stackViewKeterangan: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let lblKeterangan: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Bold", size: 21)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Stats"
        label.sizeToFit()
        return label
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.80, green: 0.76, blue: 0.76, alpha: 1.00)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.addSubview(stackViewKeterangan)
        stackViewKeterangan.addArrangedSubview(lblKeterangan)
        stackViewKeterangan.addArrangedSubview(line)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["stackViewKeterangan": stackViewKeterangan]
        
        var constraints: [NSLayoutConstraint] = []
        
        stackViewKeterangan.translatesAutoresizingMaskIntoConstraints = false
        let v_stackViewKeterangan = "V:|-5-[stackViewKeterangan]-0-|"
        let h_stackViewKeterangan = "H:|-10-[stackViewKeterangan]-10-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_stackViewKeterangan, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_stackViewKeterangan, options: .alignAllTop, metrics: nil, views: views)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension KeteranganCollectionViewCell {
    func setText(text: String) {
        lblKeterangan.text = text
    }
}
