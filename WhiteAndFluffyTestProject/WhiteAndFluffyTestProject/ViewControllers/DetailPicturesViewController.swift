//
//  DetailPicturesViewController.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class DetailPicturesViewController: UIViewController {
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var authorNameLabel = UILabel(text: "Автор:", lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    private lazy var creationDateLabel = UILabel(text: "Дата создания:", lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    private lazy var locationLabel = UILabel(text: "Локация:", lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    private lazy var quantityOfDownloadsLabel = UILabel(text: "Количество загрузок:", lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

private extension DetailPicturesViewController {
    func configureUI() {
        view.addSubview(imageView)
        view.backgroundColor = .cyan
        imageView.backgroundColor = .darkGray
        
        let labelsStack = UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 5, arrangedSubviews: [authorNameLabel, creationDateLabel, locationLabel, quantityOfDownloadsLabel])
        view.addSubview(labelsStack)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            labelsStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            labelsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            labelsStack.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
