//
//  RandomPicturesViewController.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class RandomPicturesViewController: UIViewController {
    
    //MARK: - UI
    private lazy var picturesCollectionVIew: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(PicturesCollectionViewCell.self, forCellWithReuseIdentifier: PicturesCollectionViewCell.reuseID)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search images"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - UI methods
private extension RandomPicturesViewController {
    func configureUI() {
        view.backgroundColor = .yellow
        picturesCollectionVIew.backgroundColor = .cyan
        
        view.addSubview(picturesCollectionVIew)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            picturesCollectionVIew.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 16),
            picturesCollectionVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            picturesCollectionVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            picturesCollectionVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSourse
extension RandomPicturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionViewCell.reuseID, for: indexPath) as? PicturesCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension RandomPicturesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailPicturesViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
}

//MARK: - UICollectionVIewDelegateFlowLayout
extension RandomPicturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 2
        return CGSize(width: width, height: width)
    }
    
    
}
