//
//  PhotoCollectionViewCell.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/08/03.
//

import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    // Reusable cell identifier
    static let identifier =  "PhotoCollectionViewCell"
    
    // 애완동물 사진을 표시하는 이미지 뷰
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60/2
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(petImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        petImageView.frame = contentView.bounds
    }
    
    // MARK: - Configuration
    
    public func configure(with name: String) {
        petImageView.image = UIImage(named: name)
    }
    
    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        petImageView.image = nil
    }
}
