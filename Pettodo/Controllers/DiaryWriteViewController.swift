///
//  DiaryWriteViewController.swift
//  Pettodo
//
//  Created by 최민경 on 2023/09/04.
//

import UIKit
import PhotosUI
import SnapKit

final class DiaryWriteViewController: UIViewController {
    
    // MARK: - Properties
    
    var album: Album?
    
    private let diaryWriteView = DiaryWriteView()
    //    let toolbar = UIToolbar()
    let dimmingView = UIView()
    
    var selectedIndexPath: IndexPath?
    
    
    
    // MARK: - UI Components
    
    private let datePickerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.layer.cornerRadius = 15
        picker.clipsToBounds = true
        return picker
    }()
    
    private let cancellButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.pettodoBlack, for: .normal)
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.pettodoBlack, for: .normal)
        return button
    }()
    
//    lazy var emojiButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("😊", for: .normal)
//        button.setTitleColor(.pettodoBlack, for: .normal)
//        button.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
//        return button
//    }()
    
//    lazy var emoji: UIButton = {
//        let button = UIButton()
//        button.setTitle("😊", for: .normal)
//        button.setTitleColor(.pettodoBlack, for: .normal)
//        button.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
//        return button
//    }()
    
    
    
    
        
      
    
    lazy var trashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let toolTextView: UITextView = {
        let textView = UITextView(frame: CGRect(x: -1000, y: -1000, width: 1, height: 1))
        textView.alpha = 0.0
        textView.keyboardType = .default
        return textView
    }()
    
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        return toolbar
    }()
    
    lazy var keyboardtoolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        return toolbar
    }()
    
    //    var toolbarBottomConstraint: Constraint?
    
    
    
    
    // MARK: - View Lifecycle
    
    override func loadView() {
        view = diaryWriteView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        setUpDelegate()
        setUpAddTarget()
        setupData()
        setUPDatePicker()
        setupToolbarItems()
        keybord()
        scrollToCursorPosition()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = true
        view.backgroundColor = .white
        
    }
    
    // MARK: - NaviBar Setup
    
    private func setUpNaviBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션 바 타이틀
//        let currentDate = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        let diaryTitle = UILabel()
//        diaryTitle.text = dateFormatter.string(from: currentDate)
//        diaryTitle.backgroundColor = .yellow
//        diaryTitle.isUserInteractionEnabled = true
//        diaryTitle.adjustsFontSizeToFitWidth = true // 타이틀 너비 제약 조건
        navigationItem.titleView = diaryWriteView.diaryTitle
        
        // 네비게이션 바 완료 버튼
        let saveButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(saveButtonTapped))
        self.navigationItem.rightBarButtonItem = saveButtonItem
        saveButtonItem.tintColor = .gray
    }
    
    // MARK: - ToolBar Setup
    private func setupToolbarItems() {
        
        
        // 이모지 버튼 생성
        //        let emojiButton   : UIBarButtonItem   =
        //        UIBarButtonItem(title:"😊", style:.plain,target:self,action:#selector(emojiButtonTapped))
        let emojiButton = UIBarButtonItem(customView: diaryWriteView.emojiButton)
        let emojiB = UIBarButtonItem(customView: diaryWriteView.emoji)
        
        // 쓰레기통 버튼 생성
        let trashButton   : UIBarButtonItem   =
        UIBarButtonItem(image:UIImage(systemName:"trash"),style:.plain,target:self,action:#selector(trashButtonTapped))
        
        
        //        let trashButton = UIBarButtonItem(customView: trashButton)
        
        // Flexible Space 생성
        let flexibleSpace : UIBarButtonItem   =
        UIBarButtonItem(barButtonSystemItem:.flexibleSpace,target:nil ,action:nil)
        
        
        toolbar.backgroundColor = .blue
        
        
        
        // 툴바에 아이템 추가
        toolbar.setItems([emojiButton, flexibleSpace ,trashButton],animated:false)
        
        keyboardtoolbar.setItems([emojiB], animated: false)
        toolTextView.inputAccessoryView = keyboardtoolbar
    }
    
    func keybord() {
        view.addSubview(toolbar)
        view.addSubview(keyboardtoolbar)
        view.addSubview(toolTextView)
        
        // Set up constraints using SnapKit.
        toolbar.snp.makeConstraints { make in
            //            self.toolbarBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        // 노티피케이션을 추가
        // 키보드가 나타날 때 앱에게 알리는 메서드
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillShow(notification:) ),
                                               name:UIResponder.keyboardWillShowNotification,
                                               object:nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillHide(notification:) ),
                                               name:UIResponder.keyboardWillHideNotification,
                                               object:nil)
    }
    @objc func keyboardWillShow(notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardSize.cgRectValue

        // Add an offset if needed (e.g., the height of a toolbar above the keyboard)
        let offset: CGFloat = 20.0

        // Adjust the content inset of your scroll view so that it scrolls up by the height of the keyboard
        diaryWriteView.scrollView.contentInset.bottom += (keyboardFrame.height + offset)

       if let selectedRange = diaryWriteView.diaryTextView.selectedTextRange {
            var caretRect = diaryWriteView.diaryTextView.caretRect(for: selectedRange.start)
            
            // Convert to scrollView's coordinate system.
            caretRect = diaryWriteView.scrollView.convert(caretRect, from: diaryWriteView.diaryTextView)

           // Scroll to show cursor
           diaryWriteView.scrollView.scrollRectToVisible(caretRect, animated: true)
       }
    }
    
    
    @objc func keyboardWillHide(notification:NSNotification) {
        //        self.toolbarBottomConstraint?.update(offset: 0)
        
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
    private func scrollToCursorPosition() {
        
        
        
        print("ddddddd")
        let caret = diaryWriteView.diaryTextView.caretRect(for: diaryWriteView.diaryTextView.selectedTextRange!.start)
        diaryWriteView.diaryTextView.scrollRectToVisible(caret, animated: true)
    }
    
    // MARK: - DatePicker Setup
    
    private func setUPDatePicker() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
    }
    
    // MARK: - Delegate Setup
    
    private func setUpDelegate() {
        diaryWriteView.diaryTextView.delegate = self
        //        textField.delegate = self
        toolTextView.delegate = self
    }
    
    // MARK: - AddTarget Setup
    
    private func setUpAddTarget(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoViewTapped))
        diaryWriteView.photoView.addGestureRecognizer(tapGesture)
        
        let titleTapGesture = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
        navigationItem.titleView?.addGestureRecognizer(titleTapGesture)
        
        
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        cancellButton.addTarget(self, action: #selector(cancellButtonTapped), for: .touchUpInside)
//        diaryWriteView.emojiButton.addTarget(self, action: #selector(emojiButtonTapped), for: .touchUpInside)
        
        let emojitapGesture = UITapGestureRecognizer(target: self, action: #selector(emojiButtonTapped))
        diaryWriteView.emojiButton.addGestureRecognizer(emojitapGesture)
    }
    
    // MARK: - Data Setup
    
    private func setupData() {
        diaryWriteView.album = album
    }
    
    // MARK: - Button Action
    
    @objc private func titleTapped(){
        
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5) // 반투명 검은색
        dimmingView.frame = self.view.bounds
        self.view.addSubview(dimmingView)
        
        view.addSubview(datePickerContainerView)
        
        datePickerContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(400)
        }
        
        datePickerContainerView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        datePickerContainerView.addSubview(cancellButton)
        cancellButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(datePicker.snp.left).offset(40)
        }
        
        datePickerContainerView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(datePicker.snp.right).offset(-40)
        }
        print(#function)
    }
    
    @objc private func cancellButtonTapped(){
        print("DiaryWriteVC - cacellButtonTapped")
        dimmingView.removeFromSuperview()
        datePickerContainerView.removeFromSuperview()
    }
    
    @objc private func doneButtonTapped(){
        print("DiaryWriteVC - doneButtonTapped")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let selectedDatestr = dateFormatter.string(from: datePicker.date)
        
        if let titleViewLabel = navigationItem.titleView as? UILabel {
            titleViewLabel.text = selectedDatestr
        }
        
        dimmingView.removeFromSuperview() // 배경 흐리게 없애기
        datePickerContainerView.removeFromSuperview() // 데이퍼 피커 없애기
    }
    
    @objc private func trashButtonTapped() {
        print("쓰레기통 클릭")
        diaryWriteView.photoView.image = nil
        diaryWriteView.photoView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        diaryWriteView.assetsImageView.image = UIImage(named: "footPrint")
        diaryWriteView.titleLabel.text = "이 곳을 클릭하여\n나의 반려동물 사진을 추가하세요"
        diaryWriteView.diaryTextView.text = "오늘의 하루를 기록해 보세요!"
        
        
        
    }
    
    @objc private func emojiButtonTapped(){
        print("이모지 클릭=========================================================")
        self.toolTextView.becomeFirstResponder()
        print("\(toolTextView) gkgkgkkdkafdkjaslkdfjasldfjasldjdasl")
        print("dddd")
    }
    
    @objc private func saveButtonTapped(){
        print("DiaryAlbumVC - 저장버튼 클릭 완료")
        
        // [1] 앨범이 없다면 (새로운 멤버를 추가하는 화면)
        if album == nil {
            // 입력이 안되어 있다면.. (일반적으로) 빈문자열로 저장
            
            let image = diaryWriteView.photoView.image ?? UIImage(systemName: "teddybear.fill")
            let date = diaryWriteView.diaryTitle.text
            let contents = diaryWriteView.diaryTextView.text ?? ""
            let emoji = diaryWriteView.emojiButton.text ?? ""
            

            let newAlbum = Album(image: image, date: date, contents: contents, emoji: emoji)

            
            // 1) 델리게이트 방식이 아닌 구현⭐️
            let index = navigationController!.viewControllers.count - 2
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! DiaryAlbumViewController
            // 전 화면의 모델에 접근해서 멤버를 추가
            vc.albumManager.makeNewAlbum(newAlbum)
            
            
            
            
            // 2) 델리게이트 방식으로 구현⭐️
            //delegate?.addNewMember(newMember)
            
            
        // [2] 멤버가 있다면 (멤버의 내용을 업데이트 하기 위한 설정)
        } else {
            // 이미지뷰에 있는 것을 그대로 다시 멤버에 저장
            album!.image = diaryWriteView.photoView.image ?? UIImage(systemName: "teddybear.fill")
            album!.contents = diaryWriteView.diaryTextView.text ?? ""
            album!.date = diaryWriteView.diaryTitle.text ?? ""
            album!.emoji = diaryWriteView.emojiButton.text ?? "🐱"
            
            // 뷰에도 바뀐 멤버를 전달 (뷰컨트롤러 ==> 뷰)
//            detailView.member = member
            diaryWriteView.album = album
            
            // 1) 델리게이트 방식이 아닌 구현⭐️
//            let index = navigationController?.viewControllers.count - 2
            let index = navigationController!.viewControllers.count - 2
            // 전 화면에 접근하기 위함
            let vc = navigationController?.viewControllers[index] as! DiaryAlbumViewController
            
            guard let indexPathRow = selectedIndexPath?.row else { return }
                
            // 전 화면의 모델에 접근해서 멤버를 업데이트
            vc.albumManager.updateAlbumInfo(index: indexPathRow, album!)
            
            
            
            // 델리게이트 방식으로 구현⭐️
            //delegate?.update(index: memberId, member!)
        }
        
        // (일처리를 다한 후에) 전화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
//    deinit {
//        print("디테일 뷰컨트롤러 해제")
//    }
//    }
    
    @objc private func photoViewTapped() {
        print("DiaryWriteVC - PhotoViewTapped")
        
        // PHPickerViewController 호출
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate

extension DiaryWriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "오늘의 하루를 기록해 보세요!" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "오늘의 하루를 기록해 보세요!"
            textView.textColor = .gray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !text.isEmpty && textView == self.toolTextView { // 툴바 텍스트 뷰만
            // 입력된 문자(이 경우에는 이모지)를 바로 버튼으로 설정합니다.
            diaryWriteView.emojiButton.text = text
            diaryWriteView.emoji.text = text
//            diaryWriteView.emojiButton.setTitle(text, for: .normal)
//            self.emojiButton.setTitle(text, for: .normal)
//            diaryWriteView.emoji.setTitle(text, for: .normal)
//            self.emoji.setTitle(text, for: .normal)
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height > 300 ? estimatedSize.height : 500
//                constraint.constant = estimatedSize.height
            }
        }
        print("하하하핳ㅎ")
    }
}

    // MARK: - PHPickerViewControllerDelegate
    
    extension DiaryWriteViewController: PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true, completion: nil)
            
            //        DiaryAlbumView 업데이트를 호출할 수 있음
            guard let provider = results.first?.itemProvider, provider.canLoadObject(ofClass: UIImage.self) else {
                return
            }
            
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        // 선택된 사진을 PhotoView에 표시
                        self?.diaryWriteView.photoView.image = image
                        self?.diaryWriteView.titleLabel.isHidden = true // 사진을 선택하면 타이틀 숨기기
                        self?.diaryWriteView.assetsImageView.isHidden = true // 사진을 선택하면 assetsImageView 숨기기
                        self?.diaryWriteView.photoView.backgroundColor = .white
                    }
                }
            }
        }
    }
    
