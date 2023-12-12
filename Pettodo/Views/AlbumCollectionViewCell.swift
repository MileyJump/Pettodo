//
//  AlbumCollectionViewCell.swift
//  Pettodo
//
//  Created by 최민경 on 2023/09/19.
//

import UIKit

final class AlbumCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    // Reusable cell identifier
    static let identifier =  "AlbumCollectionViewCell"
    
    //MARK: - 앨범 저장속성 구현
    
    var album: Album? {
        didSet {
            guard let album = album else { return }
            albumImageView.image = album.image
            dateLabel.text = album.date
            emojiLabel.text = album.emoji
            print("속성감시자")
        }
    }
    
    
    // 앨범이 변할때마다 자동으로 업데이트 되도록 구현 didSet(속성 감시자)
//    var album: Album? {
//        didSet {
//            guard var album = album else { return }
//            albumImageView.image = album.albumImage
//            dateLabel.text = album.date
//            emojiLabel.text = album.emoji
//        }
//    }
    
    //MARK: - UI구현
    
    let polaroidView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.pettodoGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .pettodoPink
        imageView.layer.borderColor = UIColor.pettodoGray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let spacerView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.12.31"
        label.font = UIFont(name: "GamjaFlower-Regular", size: 16)
        return label
    }()
    
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.text = "🥰"
        return label
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .black
    }
    
    private func setConstraints() {
        addSubview(polaroidView)
        polaroidView.addSubview(albumImageView)
        polaroidView.addSubview(dateLabel)
        polaroidView.addSubview(emojiLabel)
        polaroidView.addSubview(spacerView)
        
        
        polaroidView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        albumImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(polaroidView).inset(8)
            make.height.equalTo(albumImageView.snp.width)
        }
        
        spacerView.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom)
            make.bottom.equalTo(polaroidView.snp.bottom)
            make.leading.trailing.equalTo(polaroidView)
        }

        // dateLabel 제약 설정 (간격 뷰 중앙에 위치)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalTo(polaroidView).offset(-8)
//            make.leading.equalTo(16)
            make.centerY.equalTo(spacerView)
        }
        
        emojiLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(3)
            make.centerY.equalTo(spacerView)
        }
    }
}
