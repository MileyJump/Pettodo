//
//  DiaryAlbumViewController.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/07/31.
//


import UIKit

final class DiaryAlbumViewController: UIViewController {
    
    enum BarButtonItemMode {
        case pullDownMode
        case cancelMode
    }
    
    var naviBarButtonItemMode: BarButtonItemMode = .pullDownMode
    
    func barButtonChange(){
        
        
        
        switch naviBarButtonItemMode {
        case .pullDownMode:
            let rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis"), menu: menu)

            rightBarButtonItem.tintColor = .pettodoBlack
            self.navigationItem.rightBarButtonItem = rightBarButtonItem

            self.navigationItem.leftBarButtonItem = nil

            navigationItem.title = "일기장"
        case .cancelMode:
            self.hidesBottomBarWhenPushed = true
            print("\(hidesBottomBarWhenPushed)")
            
            let cancleBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancleButtonTapped))
            let SelectAllBarButtonItem = UIBarButtonItem(title: "전체 선택", style: .plain, target: self, action: #selector(selectAllButtonTapped))
            
            self.navigationItem.rightBarButtonItem = cancleBarButtonItem
            self.navigationItem.leftBarButtonItem = SelectAllBarButtonItem
            
            cancleBarButtonItem.tintColor = .pettodoBrown
            SelectAllBarButtonItem.tintColor = .pettodoBrown
            
            navigationItem.title = "일기장 삭제"
//        @unknown case _:  // default와 같은 표현
//            print("^^")
            
        }
    }
  
   
    
    // MARK: - Properties
    
    let cellItemForRow: CGFloat = 3
    let minimumSpacing: CGFloat = 8
    
    private let floatingButton = FloatingButton()
    
    let albumManager = AlbumManager()
    
    
    
    // MARK: - UI Components
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
     lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .pettodoPink
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        setupConstraints()
        view.backgroundColor = .pettodoPink
        setUpNaviBar()
        hidesBottomBarWhenPushed = false
        self.navigationController?.isToolbarHidden = true
        collectionView.reloadData()
    }
    
    
    // MARK: - NaviBar Setup
    
    private func setUpNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .pettodoPink
        appearance.shadowColor = .clear
        let customFont = UIFont(name: "GamjaFlower-Regular", size: 23)
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.pettodoBlack,
                                          .font: customFont ?? .systemFont(ofSize: 23)]
        
        // 네비게이션 바 메뉴 버튼
        let rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis"), menu: menu)
        
        rightBarButtonItem.tintColor = .pettodoBlack
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        // 네비게이션 바 백 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .pettodoBlack
        self.navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션 바 타이틀
        navigationItem.title = "일기장"
    }
    
    
    
    // MARK: - Pull Down Setup
    
    lazy var pullDownItem: [UIAction] = {
        return [
            UIAction(title: "등록 순",state: .on,  handler: { _ in print("등록순으로 정렬했습니다.")}),
            UIAction(title: "날짜 순", state: .off,  handler: { _ in print("날짜순으로 정렬했습니다.") }),
            UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { _ in self.deleteActionTapped() })]
        
        
    }()
    
    
    lazy var menu: UIMenu = {
        return UIMenu(title: "정렬", children: pullDownItem)
    }()
    
    
    func deleteActionTapped() {
        print("삭제 버튼 클릭 됐습니다")

        naviBarButtonItemMode = .cancelMode

        
    }
    
    
    @objc func cancleButtonTapped(){
        
        naviBarButtonItemMode = .pullDownMode
    
    }
    
    @objc func selectAllButtonTapped(){
        print("전체 선택 버튼 클릭!")
        
        
    }
    
    // MARK: - Datas Setup
    
    func setupDatas() {
        albumManager.makeAlbumsListDatas()
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.addSubview(floatingButton)
        floatingButton.floatingButton.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        
    }
    
    // MARK: - Button Action
    
    
    
    @objc private func didTapFloatingButton() {
        print(#function)
        let diaryWriteVC = DiaryWriteViewController()
        diaryWriteVC.modalPresentationStyle = .fullScreen
        diaryWriteVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(diaryWriteVC, animated: true)
    }
    
    // MARK: - Constraints Setup
    
    private func setupConstraints() {
        print(#function)
        floatingButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DiaryAlbumViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumManager.getAlbumList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as! AlbumCollectionViewCell
        
                cell.albumImageView.image = albumManager.getAlbumList()[indexPath.row].image
                cell.dateLabel.text = albumManager.getAlbumList()[indexPath.row].date
                cell.emojiLabel.text = albumManager.getAlbumList()[indexPath.row].emoji
        
        cell.album = albumManager.getAlbumList()[indexPath.row]
        
        return cell
    }
}

extension DiaryAlbumViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 다음 화면으로 넘어가는 코드
        let diaryWriteVC = DiaryWriteViewController()
        
        let array = albumManager.getAlbumList()
        diaryWriteVC.album = array[indexPath.row]
        
        diaryWriteVC.selectedIndexPath = indexPath
        
        navigationController?.pushViewController(diaryWriteVC, animated: true)
    }
}

extension DiaryAlbumViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - (cellItemForRow + 1) * minimumSpacing) / cellItemForRow
        
        return CGSize(width: width, height: width + 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: minimumSpacing, left: minimumSpacing, bottom: minimumSpacing, right: minimumSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt sectionIndex:Int) -> CGFloat {
        return minimumSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumSpacing
    }
    
    
}

