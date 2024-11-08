//
//  DetailPicturesViewController.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit
import Alamofire

class DetailPicturesViewController: UIViewController {
    
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addPictureToFavoriteButton = UIBarButtonItem(title: "Add to favorite", style: .plain, target: self, action: #selector(addPictureToFavorite))
    private lazy var authorNameLabel = UILabel(lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    private lazy var creationDateLabel = UILabel(lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    private lazy var locationLabel = UILabel(lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    private lazy var quantityOfDownloadsLabel = UILabel(lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        updateAddToFavotiteButtonTitle()
    }
    
    //MARK: - properties
    private var model: Model
    private let dataManager = DataManager.shared
    
    //MARK: - init
    init(model: Model) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public methods
    func configureWith(image: UIImage?) {
        imageView.image = image
        
        authorNameLabel.text = "Автор: \(model.user.name)"
        locationLabel.text = "Локация: \(model.location?.name ?? "данные не найдены")"
        quantityOfDownloadsLabel.text = "Загружено раз: \(model.downloads ?? 0)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let creationDate = model.createdAt, let date = dateFormatter.date(from: creationDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            creationDateLabel.text = "Дата создания: \(displayFormatter.string(from: date))"
        } else {
            creationDateLabel.text = "Дата создания: данные не найдены"
        }
    }
}

//MARK: - private methods
private extension DetailPicturesViewController {
    func configureUI() {
        view.addSubview(imageView)
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = addPictureToFavoriteButton
        
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
            labelsStack.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func addPictureToFavorite() {
        if dataManager.getFavorite().contains(where: { $0.id == model.id }) {
            dataManager.removeFromFavorite(model)
        } else {
            dataManager.addToFavorite(model)
        }
        updateAddToFavotiteButtonTitle()
    }
    
    func updateAddToFavotiteButtonTitle() {
        let isFavorite = dataManager.getFavorite().contains(where: { $0.id == model.id })
        addPictureToFavoriteButton.title = isFavorite ? "Remove from favorites" : "Add to favorites"
    }
}


