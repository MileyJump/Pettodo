//
//  TodoListView.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/08/03.
//

import UIKit

final class TodoListView: UIView {
    
    // MARK: - Properties
    
    private let models = ["pet1", "pet2", "pet1"]
    private let collectionViewHeight: CGFloat = 60
    private let buttonSize: CGFloat = 60
    private let spacing: CGFloat = 10
    
    // MARK: - UI Components
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: buttonSize, height: buttonSize)
        layout.minimumInteritemSpacing = spacing
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .pettodoPink
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    private let addPhotoButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.setImage(UIImage(named: "pet3"), for: .normal)
        button.backgroundColor = .pettodoGray
        button.layer.cornerRadius = 60/2
        return button
    }()
    
    private let plusImageView: UIImageView = {
        let iconView = UIImageView(image: UIImage(systemName: "plus.circle.fill"))
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        iconView.tintColor = .black
        return iconView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        addSubview(collectionView)
        addSubview(addPhotoButton)
        addPhotoButton.addSubview(plusImageView) // 버튼의 하위 뷰로 아이콘을 추가
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = CGRect(x: 15,
                                      y: 15,
                                      width: calculateCollectionViewWidth(),
                                      height: collectionViewHeight)
        
        // 콜렉션뷰와 addPhotoButton을 포함한 너비 계산
        let combinedWidth = collectionView.frame.width + 5
        
        // 너비에 기반하여 버튼의 X 위치 조정
        let addButtonX = combinedWidth + spacing
        let addButtonY = (collectionViewHeight - buttonSize) / 2
        addPhotoButton.frame = CGRect(x: addButtonX,
                                      y: addButtonY + 15,
                                      width: buttonSize,
                                      height: buttonSize)


        let plusImageViewSize: CGFloat = 20
        plusImageView.frame = CGRect(x: (addPhotoButton.bounds.maxX - plusImageViewSize),
                                     y: (addPhotoButton.bounds.maxY - plusImageViewSize),
                                     width: plusImageViewSize,
                                     height: plusImageViewSize)
    }
    
    // MARK: - Button Setup
    
    private func setupButtons() {
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addPhotoButtonTapped() {
        print(#function)
    }
    
    // 콜렉션뷰가 길어짐에 따라 옆에 있는 addphotobutton도 다이나믹하게 위치가 바뀜. 
    private func calculateCollectionViewWidth() -> CGFloat {
        let itemCount = CGFloat(models.count)
        return itemCount * (layout.itemSize.width + layout.minimumInteritemSpacing)
    }
}

extension TodoListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
}
