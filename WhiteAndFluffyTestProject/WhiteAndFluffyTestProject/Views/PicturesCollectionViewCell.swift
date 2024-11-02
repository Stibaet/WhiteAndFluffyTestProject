//
//  PicturesCollectionViewCell.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import UIKit
import Alamofire

class PicturesCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "PicturesCollectionCell"
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - override
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        request?.cancel()
    }
    
    //MARK: - properties
    private var request: DataRequest?
    
    //MARK: - public methods
    func getImageFromImageView() -> UIImage? {
        imageView.image
    }
    
    func configureWith(model: Model) {
        guard let imageUrlString = model.urls["small"], let imageURL = URL(string: imageUrlString) else { return }
        
        request = AF.request(imageURL).responseData(completionHandler: { [weak self] response in
            guard let self = self else { return }
            switch response.result {
                case .success(let data):
                    self.imageView.image = UIImage(data: data)
                case .failure(let error):
                    print("load image failure: \(error.localizedDescription)")
            }
            
        })
    }
}

//MARK: - UI methods
private extension PicturesCollectionViewCell {
    func configureUI() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
}
