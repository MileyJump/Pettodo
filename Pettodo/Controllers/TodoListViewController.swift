//
//  TodoListViewController.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/07/31.
//

import UIKit
import SnapKit

final class TodoListViewController: UIViewController {
    
    // MARK: - Properties

    private let floatingButton = FloatingButton()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        navigationItem.title = "펫토도"
        
        let photoCollectionViewController = PhotoCollectionViewController()
        addChild(photoCollectionViewController)
        view.addSubview(photoCollectionViewController.view)
        photoCollectionViewController.didMove(toParent: self)
        
        view.addSubview(floatingButton)
        floatingButton.floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
    }
    
    // MARK: - Button Action
    
    @objc private func didTapFloatingButton() {
        print(#function)
        let newTaskVC = NewTaskViewController()
        let navigationController = UINavigationController(rootViewController: newTaskVC)
        navigationController.modalPresentationStyle = .overFullScreen // shows previous vc in the background
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(60)
        }
    }
}
