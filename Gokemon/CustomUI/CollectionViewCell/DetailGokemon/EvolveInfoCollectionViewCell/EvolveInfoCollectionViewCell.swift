//
//  EvolveInfoCollectionViewCell.swift
//  Gokemon
//
//  Created by Jan Sebastian on 19/04/24.
//

import UIKit

class EvolveInfoCollectionViewCell: UICollectionViewCell {
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
        label.text = "Evol"
        label.sizeToFit()
        return label
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.80, green: 0.76, blue: 0.76, alpha: 1.00)
        return view
    }()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        collectionView.register(GokemonCollectionViewCell.self, forCellWithReuseIdentifier: "GokemonItemCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        return collectionView
    }()
    
    var listData: [ChainModel] = []
    var chooseGokemon: ((ChainModel) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
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
        stackViewCore.addArrangedSubview(collectionView)
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

extension EvolveInfoCollectionViewCell {
    func setValue(value: GokemonEvoChainModel) {
        listData = value.chain?.evolvesTo ?? []
        collectionView.reloadData()
    }
    
    func setValue(value: GokemonEvoChainModel, gokemonName: String) {
        
        if let chain = value.chain {
            listData = self.searchEvo(data: chain, name: gokemonName)
            collectionView.reloadData()
        } else {
            
        }
    }
    
    
    private func searchEvo(data: ChainModel, name: String) -> [ChainModel] {
        if data.species.name == name {
            return data.evolvesTo
        } else {
            return self.searchEvo(data: data, name: name)
        }
    }
}

extension EvolveInfoCollectionViewCell: UICollectionViewDelegate,
                                        UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return listData.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GokemonItemCell", for: indexPath) as? GokemonCollectionViewCell else {
              return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
          }
          
          let item = listData[indexPath.item]
          cell.setValue(value: item)
          
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let item = listData[indexPath.item]
          chooseGokemon?(item)
      }
}

extension EvolveInfoCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.collectionView.bounds.width / 2) - 5
        
        return CGSize(width: width, height: width)
    }
}
