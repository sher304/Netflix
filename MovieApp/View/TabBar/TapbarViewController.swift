//
//  TapbarViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import UIKit
import SnapKit

class TapbarViewController: UITabBarController {
    
    private lazy var middleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.frame = CGRect(x: (self.view.bounds.width / 2) - 30, y: -20, width: 60, height: 60)
        button.layer.cornerRadius = 30
        button.setImage(UIImage(systemName: "house.fill"), for: .normal)
        button.addTarget(self, action: #selector(middleButtonTapped), for: .touchUpInside)
        button.contentMode = .scaleToFill
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTapBar()
        setTabBarAppearance()
        selectedIndex = 1
    }
    
    //MARK: Generate VC in TapBar
    private func generateTapBar(){
        viewControllers = [
            genercateVC(vc: SearchViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass")),
            genercateVC(vc: HomeViewController(), title: " ", image: UIImage()),
            genercateVC(vc: SaveViewController(), title: "Saves", image: UIImage(systemName: "books.vertical.fill"))
        ]
    }
    
    //MARK: Generate VC
    private func genercateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController{
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
    
    //MARK: Setup Constraints and View of TapBar
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2

        let roundLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )

        roundLayer.path = bezierPath.cgPath

        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1).cgColor
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray

        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
        tabBar.addSubview(middleButton)
    }
    
    //MARK: Middle Button Index
    @objc func middleButtonTapped(){
        selectedIndex = 1
    }
    
}
