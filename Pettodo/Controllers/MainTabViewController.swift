//
//  MainTabViewController.swift
//  Pettodo
//
//  Created by Jung Hyun Kim on 2023/07/31.
//

import UIKit

final class MainTabViewController: UITabBarController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .pettodoPink
        configureUI()
        self.delegate = self

        // 탭 바 아이템이 초기화되기 전에 잠시 후에 탭 바 인디케이터를 추가
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            self.addTabBarIndicator(index: 0, isFirstTime: true)
        }
    }
    
    // MARK: - Private methods

    private func configureUI() {
        // 각 탭에 대한 뷰 컨트롤러 인스턴스를 생성
        let vc1 = UINavigationController(rootViewController: TodoListViewController())
        let vc2 = UINavigationController(rootViewController: ChatGPTViewController())
        let vc3 = UINavigationController(rootViewController: DiaryAlbumViewController())
        
        // 탭 바에 뷰 컨트롤러들을 설정
        viewControllers = [vc1, vc2, vc3]
        // 모달 프레젠테이션 스타일을 전체 화면으로 설정
        modalPresentationStyle = .fullScreen
        
//        vc1.title = "할 일"
//        vc2.title = "펫GPT"
//        vc3.title = "일기"
        
        // 탭 바 아이템에 이미지를 설정
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: TabImage.checkbox)
        items[1].image = UIImage(named: TabImage.robot)
        items[2].image = UIImage(named: TabImage.album)
        
        // 탭 바 외형을 구성
        let tabAppearance = UITabBarAppearance()
        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundColor = .pettodoPink
        tabBar.tintColor = .pettodoBlack
        
        self.tabBar.standardAppearance = tabAppearance
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
    }
}

// MARK: - UITabBarControllerDelegate

extension MainTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabBarIndicator(index: self.selectedIndex) // 탭이 선택될 때 선택된 인덱스에 대한 탭 바 인디케이터를 추가
    }
}
