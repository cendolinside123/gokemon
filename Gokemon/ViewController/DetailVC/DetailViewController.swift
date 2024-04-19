//
//  DetailViewController.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var navBar = ViewNavbar()
    
    private let stackViewContent: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.alwaysBounceVertical = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0.001)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultCell")
        collectionView.register(BasicInfoCollectionViewCell.self, forCellWithReuseIdentifier: "BasicInfoCell")
//        collectionView.register(StatInfoCollectionViewCell.self, forCellWithReuseIdentifier: "StatInfoCell")
        collectionView.register(StatItemCollectionViewCell.self, forCellWithReuseIdentifier: "StatItemCell")
        collectionView.register(KeteranganCollectionViewCell.self, forCellWithReuseIdentifier: "KeteranganCell")
        collectionView.register(EvolveInfoCollectionViewCell.self, forCellWithReuseIdentifier: "EvolveInfoCell")
        return collectionView
    }()
    
    private var viewModelDetail: GokemonDetailViewModel = GokemonDetailViewModelImpl()
    
    private var gokemon: GokemonModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    init(gokemon: GokemonModel) {
        super.init(nibName: nil, bundle: nil)
        self.gokemon = gokemon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
        setupActions()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModelDetail.delegate = self
        if let gokemon {
            navBar.setTitle(value: gokemon.name)
            viewModelDetail.loadGokemonDetail(url: gokemon.url, name: gokemon.name)
        }
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
        self.view.addSubview(stackViewContent)
        stackViewContent.addArrangedSubview(navBar)
        stackViewContent.addArrangedSubview(collectionView)
    }

    private func setupConstraints() {
        let views: [String: Any] = ["stackViewContent": stackViewContent]
        
        var constraints: [NSLayoutConstraint] = []
        
        stackViewContent.translatesAutoresizingMaskIntoConstraints = false
        let v_stackViewContent = "V:|-[stackViewContent]-|"
        let h_stackViewContent = "H:|-0-[stackViewContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_stackViewContent, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_stackViewContent, options: .alignAllTop, metrics: nil, views: views)
        
        navBar.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: navBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}

extension DetailViewController {
    private func setupActions() {
        navBar.onExit = {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension DetailViewController: GokemonDetailDelegate {
    func onEndLoad() {
        self.hideLoading()
    }
    
    func onLoading() {
        self.showLoading()
    }
    
    func onSuccess() {
        collectionView.reloadData()
    }
    
    func onError(error: Error) {
        self.showToast(message: error.localizedDescription, font: UIFont.systemFont(ofSize: 14))
        self.askReload(yesAnswer: { [weak self] in
            if let gokemon = self?.gokemon {
                self?.viewModelDetail.loadGokemonDetail(url: gokemon.url, name: gokemon.name)
            }
        }, noAnswer: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
    }
    
    
}

extension DetailViewController: UICollectionViewDelegate,
                                UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModelDetail.gokeminInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            if let getStat = viewModelDetail.gokeminInformation[1].detail?.stats.count,
                getStat > 0 {
                return getStat + 1
            } else {
                return 0
            }
        } else if section == 2 {
            if let _ = viewModelDetail.gokeminInformation[2].evo {
                return 1
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let getItem = viewModelDetail.gokeminInformation[indexPath.section]
            if getItem.typeInfo == .MainInfo {
                guard let _ = getItem.detail else {
                    return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                }
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicInfoCell", for: indexPath) as? BasicInfoCollectionViewCell else {
                    return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                }
                cell.setValue(value: getItem)
                return cell
            } else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            }
        } else if indexPath.section == 1 {
            
            if indexPath.item == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeteranganCell", for: indexPath) as? KeteranganCollectionViewCell else {
                    return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                }
                cell.setText(text: "Stats")
                return cell
            } else {
                guard let getStat = viewModelDetail.gokeminInformation[indexPath.section].detail?.stats[indexPath.item - 1] else {
                    return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                }
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatItemCell", for: indexPath) as? StatItemCollectionViewCell else {
                    return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
                }
                cell.setValue(value: getStat)
                return cell
            }
            
        } else if indexPath.section == 2 {
            let getItem = viewModelDetail.gokeminInformation[indexPath.section]
            guard let evoValue = getItem.evo else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EvolveInfoCell", for: indexPath) as? EvolveInfoCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
            }
            
            cell.chooseGokemon = { [weak self] item in
                if let url = URL(string: item.species.url) {
                    let detail = GokemonModel(name: item.species.name, url: "https://pokeapi.co/api/v2/pokemon/\(url.lastPathComponent)")
                    let vc = DetailViewController(gokemon: detail)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            cell.setValue(value: evoValue)
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            let getItem = viewModelDetail.gokeminInformation[indexPath.section]
            if getItem.typeInfo == .MainInfo {
                guard let _ = getItem.detail else {
                    return .zero
                }
                return CGSize(width: (Int(self.collectionView.bounds.width) - 5), height: BasicInfoCollectionViewCell.height)
            } else {
                return .zero
            }
        } else if indexPath.section == 1 {
            if indexPath.item == 0 {
                return CGSize(width: (Int(self.collectionView.bounds.width) - 5), height: 35)
            } else {
                if let _ = viewModelDetail.gokeminInformation[indexPath.section].detail?.stats {
                    return CGSize(width: (Int(self.collectionView.bounds.width) - 5), height: 45)
                } else {
                    return .zero
                }
            }
            
        } else if indexPath.section == 2 {
            let getItem = viewModelDetail.gokeminInformation[indexPath.section]
            if getItem.typeInfo == .EvoInfo {
                guard let _ = getItem.evo else {
                    return .zero
                }
                let width = (self.collectionView.bounds.width / 2)
                return CGSize(width: (Int(self.collectionView.bounds.width) - 5), height: (Int(width) + 40))
            } else {
                return .zero
            }
        }
        
        return .zero
        
    }
}

