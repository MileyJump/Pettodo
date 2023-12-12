//
//  NewTaskView.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/08/22.
//

import UIKit
import SnapKit

final class NewTaskView: UIView {
    
    // MARK: - Subviews
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let textView: UIView = {
        let textView = UIView()
        textView.backgroundColor = .white
        return textView
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "반려동물과 함께 할 일을 정리해보세요"
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.contentVerticalAlignment = .top
        return textField
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    private let calendarButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "calendar")
        button.setImage(image, for: .normal)
        button.tintColor = .pettodoGray
        return button
    }()
    
    private let priorityButton: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "exclamationmark.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .pettodoGray
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.up.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .pettodoGray
        return button
    }()
    

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(textView)
        textView.addSubview(textField)
        
        containerView.addSubview(calendarButton)
        containerView.addSubview(priorityButton)
        containerView.addSubview(saveButton)

        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            // Height constraint can be added dynamically or based on content
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(13)
//            make.left.right.equalToSuperview().inset(16)
//            make.top.bottom.equalToSuperview().inset(8)
        }
        
        textView.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.top).offset(8)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-13)
            make.height.equalTo(44)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(-50)
            make.leading.equalToSuperview().offset(13)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        priorityButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(-50)
            make.leading.equalTo(calendarButton).offset(40)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(-50)
            make.trailing.equalToSuperview().offset(-13)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
    }
}
