//
//  StatItemCollectionViewCell.swift
//  Gokemon
//
//  Created by Jan Sebastian on 19/04/24.
//

import UIKit

class StatItemCollectionViewCell: UICollectionViewCell {
    private let viewLabel: StatLabel = {
        let view = StatLabel()
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
        self.contentView.addSubview(viewLabel)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["viewLabel": viewLabel]
        
        var constraints: [NSLayoutConstraint] = []
        
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        let v_viewLabel = "V:|-5-[viewLabel]-5-|"
        let h_viewLabel = "H:|-10-[viewLabel]-10-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_viewLabel, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_viewLabel, options: .alignAllTop, metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension StatItemCollectionViewCell {
    func setValue(value: StatModel) {
        viewLabel.setValue(value: value.baseStat, keterangan: value.stat.name)
    }
}
