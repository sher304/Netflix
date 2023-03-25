//
//  TapbarViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 25/03/2023.
//

import UIKit
import SnapKit

class TapbarViewController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTapBar()
        setTabBarAppearance()
    }
    
    private func generateTapBar(){
        viewControllers = [
            genercateVC(vc: HomeViewController(), title: "Home", image: UIImage(systemName: "house.fill")),
            genercateVC(vc: SaveViewController(), title: "Search", image: UIImage(systemName: "magnifyingglass")),
        ]
    }
    
    private func genercateVC(vc: UIViewController, title: String, image: UIImage?) -> UIViewController{
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
    
    
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
        
        roundLayer.fillColor = UIColor.gray.cgColor
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray

        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
        tabBar.backgroundColor = .clear
    }
    
}
