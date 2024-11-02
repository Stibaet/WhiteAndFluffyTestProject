//
//  FavoritePicturesTableCell.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit
import Alamofire

class FavoritePicturesTableCell: UITableViewCell {
    
    static let reuseID = "FavoritePicturesTableCell"
    
    //MARK: - UI
    private lazy var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var label = UILabel(lines: 0, font: .systemFont(ofSize: 16, weight: .medium), alignment: .left)
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - public methods
    func configureWith(model: Model) {
        
        guard let imageUrlString = model.urls["small"], let imageURL = URL(string: imageUrlString) else { return }
        
        AF.request(imageURL).responseData(completionHandler: { [weak self] response in
            guard let self = self else { return }
            switch response.result {
                case .success(let data):
                    self.pictureImageView.image = UIImage(data: data)
                case .failure(let error):
                    print("load image failure: \(error.localizedDescription)")
            }
        })
        
        label.text = model.user.name
    }
    
    func getImageFromImageView() -> UIImage? {
        pictureImageView.image
    }
}

//MARK: - private methods
private extension FavoritePicturesTableCell {
    func configureUI() {
        addSubview(pictureImageView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            pictureImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            pictureImageView.heightAnchor.constraint(equalToConstant: 50),
            pictureImageView.widthAnchor.constraint(equalToConstant: 50),
            
            label.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        
    }
}
