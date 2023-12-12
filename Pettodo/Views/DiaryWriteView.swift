//
//  DiaryWriteView.swift
//  Pettodo
//
//  Created by 최민경 on 2023/09/04.
//

import UIKit

final class DiaryWriteView: UIView {
    
    // 멤버 데이터가 바뀌면 ===> didSet(속성감시자) 실행
    // 속성감시자도 (저장 속성을 관찰하는) 어쨌든 자체는 메서드임
    var album: Album? {
        didSet {
            guard let album = album else { return }
            // 멤버가 있으면
            assetsImageView.image = nil
            titleLabel.text = nil
            photoView.image = album.image
            diaryTextView.text = album.contents
            diaryTitle.text = album.date
        }
    }
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
//        scroll.backgroundColor = .red
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceVertical = true  //항상 bounce 효과 적용
        return scroll
    }()

    var contentView: UIView = {
        let view = UIView()
//        view.backgroundColor = .blue
        return view
    }()
    
    
    var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        imageView.clipsToBounds = true
        imageView.isOpaque = false
        //        imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true // 사용자 상호작용 가능하도록 설정
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이 곳을 클릭하여\n나의 반려동물 사진을 추가하세요"
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 23)
        label.textAlignment = .center
        return label
    }()
    
    var assetsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "footPrint") // Assets에 추가한 이미지를 설정
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var diaryTextView: UITextView = {
        let textView = UITextView()
//                textView.backgroundColor = UIColor.green
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.text = "오늘의 하루를 기록해 보세요!"
        textView.textColor = .gray
        textView.textAlignment = .center
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = true
        return textView
    }()
    
    
    let diaryTitle: UILabel = {
        let label = UILabel()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let currentDate = Date()
        label.text = dateFormatter.string(from: currentDate)
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var emojiButton: UILabel = {
        let label = UILabel()
        label.text = "😊"
        label.textColor = .pettodoBlack
        return label
    }()
    
    lazy var emoji: UILabel = {
        let label = UILabel()
        label.textColor = .pettodoBlack
        label.text = "😊"
        
//            button.setTitleColor(.pettodoBlack, for: .normal)
//            label.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
        return label
    }()

    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAutoLayout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
//        contentView.addSubview(diaryTextView)
        contentView.addSubview(photoView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(assetsImageView)
        contentView.addSubview(diaryTextView)
//        addSubview(photoView)
//        photoView.addSubview(titleLabel)
//        photoView.addSubview(assetsImageView)
        
        scrollView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.top.leading.trailing.equalToSuperview()
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(50)
        }

        contentView.snp.makeConstraints { make in
//            make.top.bottom.equalTo(scrollView)
//            make.width.centerX.equalTo(scrollView)
//            make.height.equalTo(400)

            
            make.width.equalTo(scrollView)
             make.centerX.equalTo(scrollView)
             make.top.bottom.equalTo(scrollView)
            
//            make.edges.equalTo(scrollView)
//            make.width.centerX.equalTo(scrollView)
            
        }
        
        photoView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.topMargin)
            make.width.equalToSuperview()
            make.height.equalTo(photoView.snp.width)
        }
        
        assetsImageView.snp.makeConstraints { make in
            make.centerX.equalTo(photoView)
            make.top.equalTo(photoView).offset(60)
            make.width.height.equalTo(125)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(assetsImageView.snp.bottom).offset(20)
        }
        
        diaryTextView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(100)
            make.height.equalTo(300)
//            make.bottom.equalTo(contentView).inset(400)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
}

