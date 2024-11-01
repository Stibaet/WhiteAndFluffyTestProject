//
//  PicturesCollectionViewCell.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit

class PicturesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "PicturesCollectionCell"
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UI methods
private extension PicturesCollectionViewCell {
    func configureUI() {
        addSubview(imageView)
        backgroundColor = .red
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
