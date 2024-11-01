//
//  FavoritePicturesViewController.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class FavoritePicturesViewController: UIViewController {
    
    //MARK: - UI
    private lazy var tableVIew: UITableView = {
        let tableVIew = UITableView()
        tableVIew.translatesAutoresizingMaskIntoConstraints = false
        tableVIew.register(FavoritePicturesTableCell.self, forCellReuseIdentifier: FavoritePicturesTableCell.reuseID)
        tableVIew.dataSource = self
//        tableVIew.delegate = self
        return tableVIew
    }()
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - UI methods
private extension FavoritePicturesViewController {
    func configureUI() {
        view.backgroundColor = .green
        tableVIew.backgroundColor = .cyan
        view.addSubview(tableVIew)
        
        NSLayoutConstraint.activate([
            tableVIew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
            
        ])
    }
}

extension FavoritePicturesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePicturesTableCell.reuseID, for: indexPath) as? FavoritePicturesTableCell else { return UITableViewCell() }
        return cell
    }
}
