//
//  FavoritePicturesViewController.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class FavoritePicturesViewController: UIViewController {
    
    //MARK: - UI
    lazy var tableVIew: UITableView = {
        let tableVIew = UITableView()
        tableVIew.translatesAutoresizingMaskIntoConstraints = false
        tableVIew.register(FavoritePicturesTableCell.self, forCellReuseIdentifier: FavoritePicturesTableCell.reuseID)
        tableVIew.dataSource = self
        tableVIew.delegate = self
        return tableVIew
    }()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableVIew.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - properties
    private let dataSource = DataManager.shared
}

//MARK: - private methods
private extension FavoritePicturesViewController {
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableVIew)
        
        NSLayoutConstraint.activate([
            tableVIew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource
extension FavoritePicturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.getFavorite().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePicturesTableCell.reuseID, for: indexPath) as? FavoritePicturesTableCell else { return UITableViewCell() }
        
        let dataSource = dataSource.getFavorite()[indexPath.row]
        cell.configureWith(model: dataSource)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoritePicturesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSourse = dataSource.getFavorite()[indexPath.row]
        
        if let cell = tableView.cellForRow(at: indexPath) as? FavoritePicturesTableCell, let image = cell.getImageFromImageView() {
            let vc = DetailPicturesViewController(model: dataSourse)
            vc.configureWith(image: image)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

