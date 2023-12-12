//
//  NewTaskViewController.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/08/22.
//

import UIKit

final class NewTaskViewController: UIViewController {
    
    // MARK: - Properties

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.4)
        return view
    }()
    
    private lazy var newTaskView: NewTaskView = {
        let view = NewTaskView()
        return view
    }()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
        setupConstraints()
        setupGesture()
        observeKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set the modal presentation style to overCurrentContext
        modalPresentationStyle = .overCurrentContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newTaskView.becomeFirstResponder()
    }
    
    // MARK: - View Setup

    private func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(newTaskView)
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        newTaskView.snp.makeConstraints { make in
               make.edges.equalToSuperview()
           }
    }
    
    // MARK: - Gesture Setup
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Button Action
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    // MARK: - Keyboard Handling
    
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification: notification)
        print("keyboardHeight: \(keyboardHeight)")
        
        newTaskView.containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().inset(keyboardHeight)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
    
        newTaskView.containerView.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return 0 }
        return keyboardHeight
    }
}
