//
//  FavoritePicturesTableCell.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class FavoritePicturesTableCell: UITableViewCell {
    
    static let reuseID = "FavoritePicturesTableCell"
    
    //MARK: - UI
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.text = "Author name"
        
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI methods
private extension FavoritePicturesTableCell {
    func configureUI() {
        addSubview(pictureImageView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pictureImageView.heightAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        
    }
}
