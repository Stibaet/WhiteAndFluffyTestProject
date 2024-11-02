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
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    //MARK: - properties
    private var dataSourse: [Model] = []
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getPictures()
    }
    
    override func loadView() {
        super.loadView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
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

//MARK: - private methods
private extension RandomPicturesViewController {
    func configureUI() {
        view.backgroundColor = .white
        
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
    
    func getPictures() {
        NetworkManager.shared.getPictures(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .success(let pictures):
                    DispatchQueue.main.async {
                        self.dataSourse = pictures
                        self.picturesCollectionVIew.reloadData()
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(
                            title: "Ошика",
                            message: "Что-то пошло не так. Проверьте соединение с интернетом",
                            preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ОК", style: .default))
                        self.present(alert, animated: true)
                    }
                    print("Error while getting pictures: \(error.localizedDescription)")
            }
            
        })
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    
}

//MARK: - UICollectionViewDataSourse
extension RandomPicturesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicturesCollectionViewCell.reuseID, for: indexPath) as? PicturesCollectionViewCell else { return UICollectionViewCell() }
        let model = dataSourse[indexPath.row]
        cell.configureWith(model: model)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension RandomPicturesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataSourse[indexPath.item]
        
        if let cell = collectionView.cellForItem(at: indexPath) as? PicturesCollectionViewCell, let image = cell.getImageFromImageView() {
            let vc = DetailPicturesViewController(model: model)
            vc.configureWith(image: image)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - UICollectionVIewDelegateFlowLayout
extension RandomPicturesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20) / 2
        return CGSize(width: width, height: width)
    }
}

//MARK: - UISearchBarDelegate
extension RandomPicturesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            getPictures()
        } else {
            
            guard let query = searchBar.text, !query.isEmpty else { return }
            NetworkManager.shared.searchPhotos(query: query) { [weak self] result in
                switch result {
                    case .success(let searchResults):
                        self?.dataSourse = searchResults.results.map({ searchResult in
                            Model(id: searchResult.id, urls: searchResult.urls, user: searchResult.user, createdAt: searchResult.createdAt, location: nil, downloads: nil)
                        })
                        self?.picturesCollectionVIew.reloadData()
                    case .failure(let error):
                        print("Error searching photos: \(error)")
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: - UIGestureRecognizerDelegate
extension RandomPicturesViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        !(String(describing: touch.view).contains("UICollectionViewCell") ||
          String(describing: touch.view?.superview).contains("UICollectionViewCell"))
    }
}
