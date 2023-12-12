//
//  PhotoCollectionViewController.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/08/03.
//

import UIKit
import SnapKit

final class PhotoCollectionViewController: UIViewController {
    
    // MARK: - Properties

    private let todoListView = TodoListView()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.addSubview(todoListView)
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {

        todoListView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
}
