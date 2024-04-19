//
//  GokemonCollectionViewCell.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import UIKit
import Kingfisher

class GokemonCollectionViewCell: UICollectionViewCell {
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.05, green: 0.12, blue: 0.25, alpha: 1.00)
        return view
    }()
    
    private let imgPokemon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor(white: 1, alpha: 0.001)
        image.image = UIImage(named: "GokemonPlaceholder")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let lblGokemonName: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(white: 1, alpha: 0.001)
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgPokemon.image = UIImage(named: "GokemonPlaceholder")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
        baseView.layer.cornerRadius = 10
        baseView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        self.backgroundColor = UIColor(white: 1, alpha: 0.001)
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(stackView)
        stackView.addArrangedSubview(imgPokemon)
        stackView.addArrangedSubview(lblGokemonName)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["baseView": baseView,
                                    "stackView": stackView]
        
        var constraints: [NSLayoutConstraint] = []
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        let v_baseView = "V:|-5-[baseView]-5-|"
        let h_baseView = "H:|-5-[baseView]-5-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_baseView, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_baseView, options: .alignAllTop, metrics: nil, views: views)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let v_stackView = "V:|-8-[stackView]-8-|"
        let h_stackView = "H:|-5-[stackView]-5-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_stackView, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_stackView, options: .alignAllTop, metrics: nil, views: views)
        
        imgPokemon.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: imgPokemon, attribute: .height, relatedBy: .equal, toItem: baseView, attribute: .height, multiplier: 1/2, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension GokemonCollectionViewCell {
    func setValue(value: GokemonModel) {
        if let url = URL(string: value.url),
            let imgUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(url.lastPathComponent).png") {
//            print("last path: \(url.lastPathComponent)")
            imgPokemon.kf.setImage(with: imgUrl)
        }
        lblGokemonName.text = value.name
    }
    
    func setValue(value: ChainModel) {
        if let url = URL(string:  value.species.url), 
            let imgUrl = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(url.lastPathComponent).png") {
            imgPokemon.kf.setImage(with: imgUrl)
        }
        lblGokemonName.text = value.species.name
    }
}
