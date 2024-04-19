//
//  StatInfoCollectionViewCell.swift
//  Gokemon
//
//  Created by Jan Sebastian on 19/04/24.
//

import UIKit

class StatInfoCollectionViewCell: UICollectionViewCell {
    private let stackViewCore: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 15
        return stackView
    }()
    
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
    
    private let stackViewAllStats: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    private let lblAttack: StatLabel = {
        let label = StatLabel(keterangan: "Attack : ")
        return label
    }()
    
    private let lblHP: StatLabel = {
        let label = StatLabel(keterangan: "HP : ")
        return label
    }()
    
    private let lblDefence: StatLabel = {
        let label = StatLabel(keterangan: "Defence : ")
        return label
    }()
    
    private let lblSpeed: StatLabel = {
        let label = StatLabel(keterangan: "Speed : ")
        return label
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
        self.contentView.addSubview(stackViewCore)
        stackViewCore.addArrangedSubview(stackViewKeterangan)
        stackViewKeterangan.addArrangedSubview(lblKeterangan)
        stackViewKeterangan.addArrangedSubview(line)
        stackViewCore.addArrangedSubview(stackViewAllStats)
        stackViewAllStats.addArrangedSubview(lblAttack)
        stackViewAllStats.addArrangedSubview(lblHP)
        stackViewAllStats.addArrangedSubview(lblDefence)
        stackViewAllStats.addArrangedSubview(lblSpeed)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["stackViewCore": stackViewCore]
        
        var constraints: [NSLayoutConstraint] = []
        
        stackViewCore.translatesAutoresizingMaskIntoConstraints = false
        let v_stackViewCore = "V:|-10-[stackViewCore]-10-|"
        let h_stackViewCore = "H:|-10-[stackViewCore]-10-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_stackViewCore, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_stackViewCore, options: .alignAllTop, metrics: nil, views: views)
        
        line.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension StatInfoCollectionViewCell {
    func setValue(value: GokemonInfoModel) {
        if value.typeInfo == .StatsInfo {
//            value.detail?.stats[0]
        }
    }
}
