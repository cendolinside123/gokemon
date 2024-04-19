//
//  HomeViewController.swift
//  Gokemon
//
//  Created by Jan Sebastian on 17/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    
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
    
    private var viewModel: ListLoadViewModel = ListLoadViewModelImpl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel.delegate = self
        
        viewModel.loadListGokemon(fistLoad: true)
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
        self.view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["collectionView": collectionView]
        
        var constraints: [NSLayoutConstraint] = []
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let v_collectionView = "V:|-[collectionView]-|"
        let h_collectionView = "H:|-0-[collectionView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: v_collectionView, options: .alignAllLeading, metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: h_collectionView, options: .alignAllTop, metrics: nil, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }

}

extension HomeViewController: ListLoadDelegate {
    func onSuccessLoad() {
        collectionView.reloadData()
    }
    
    func onError(error: Error) {
        self.showToast(message: error.localizedDescription, font: UIFont.systemFont(ofSize: 14))
        self.askReload(yesAnswer: { [weak self] in
            self?.viewModel.loadListGokemon(fistLoad: false)
        }, noAnswer: {
        })
    }
    
    func onLoading() {
        self.showLoading()
    }
    
    func finishLoading() {
        self.hideLoading()
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= 0 {
            viewModel.loadListGokemon(fistLoad: true)
        } else {
            if scrollView == collectionView {
                if (Int(scrollView.contentOffset.y) >= Int(scrollView.contentSize.height - scrollView.frame.size.height)) {
                    viewModel.loadListGokemon(fistLoad: false)
                    
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GokemonItemCell", for: indexPath) as? GokemonCollectionViewCell else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        }
        
        let item = viewModel.listData[indexPath.item]
        cell.setValue(value: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.listData[indexPath.item]
        let vc = DetailViewController(gokemon: item)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.collectionView.bounds.width / 2) - 5
        
        return CGSize(width: width, height: width)
    }
}
