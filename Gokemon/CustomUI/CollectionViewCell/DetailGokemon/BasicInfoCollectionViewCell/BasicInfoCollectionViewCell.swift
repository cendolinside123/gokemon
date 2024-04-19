//
//  BasicInfoCollectionViewCell.swift
//  Gokemon
//
//  Created by Jan Sebastian on 19/04/24.
//

import UIKit
import Kingfisher

class BasicInfoCollectionViewCell: UICollectionViewCell {
    static let height = 150
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.05, green: 0.12, blue: 0.25, alpha: 1.00)
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let imgGokemon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 1, alpha: 0.001)
        image.image = UIImage(named: "GokemonPlaceholder")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.80, green: 0.76, blue: 0.76, alpha: 1.00)
        return view
    }()
    
    private let stackLeft: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
//        stackView.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 30, right: 15)
//        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private let lblGokemonName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.numberOfLines = 0
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let stackBasicInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let lblType: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.numberOfLines = 0
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let lblHeight: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.numberOfLines = 0
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let lblWeight: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Regular", size: 11)
        label.numberOfLines = 0
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        baseView.layer.cornerRadius = 9
        baseView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.addSubview(baseView)
        baseView.addSubview(stackView)
        stackView.addArrangedSubview(imgGokemon)
        stackView.addArrangedSubview(line)
        stackView.addArrangedSubview(stackLeft)
        stackLeft.addArrangedSubview(lblGokemonName)
        stackLeft.addArrangedSubview(stackBasicInfo)
        stackBasicInfo.addArrangedSubview(lblType)
        stackBasicInfo.addArrangedSubview(lblHeight)
        stackBasicInfo.addArrangedSubview(lblWeight)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["baseView": baseView,
                                    "stackView": stackView]
        
        var constraints: [NSLayoutConstraint] = []
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        let v_baseView = "V:|-10-[baseView]-10-|"
        let h_baseView = "H:|-10-[baseView]-10-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_baseView, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_baseView, options: .alignAllTop, metrics: nil, views: views)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let v_stackView = "V:|-5-[stackView]-5-|"
        let h_stackView = "H:|-15-[stackView]-15-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_stackView, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_stackView, options: .alignAllTop, metrics: nil, views: views)
        
        imgGokemon.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: imgGokemon, attribute: .width, relatedBy: .equal, toItem: imgGokemon, attribute: .height, multiplier: 1, constant: 0)]
        
        line.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: line, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 1)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension BasicInfoCollectionViewCell {
    func setValue(value: GokemonInfoModel) {
        if value.typeInfo == .MainInfo {
            if let getUrlString = value.detail?.sprites.frontDefault,
               let imgURL = URL(string: getUrlString) {
                imgGokemon.kf.setImage(with: imgURL)
            }
            lblGokemonName.text = value.detail?.name
            var type: [String] = []
            
            for item in (value.detail?.types ?? []) {
//                type.append(item.type.name)
                if let name = item.type.name {
                    type.append(name)
                }
            }
            
            if type.count > 0 {
                lblType.text = "Type: \(type.joined(separator: ","))"
            } else {
                lblType.text = "Type: -"
            }
            
            if let height = value.detail?.height {
                lblHeight.text = "Height: \(height)m"
            } else {
                lblHeight.text = "Height: -"
            }
            
            if let weight = value.detail?.weight {
                lblWeight.text = "Weight: \(weight) Kg"
            } else {
                lblWeight.text = "Weight: -"
            }
            
        }
    }
}
