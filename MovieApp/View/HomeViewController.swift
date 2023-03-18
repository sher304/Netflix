//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 18/03/2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //MARK: SIZE
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 350)
    
    //MARK: SCROLL VIEW
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView(frame: .zero)
        scrollV.contentSize = contentSize
        scrollV.frame = self.view.bounds
        scrollV.contentInsetAdjustmentBehavior = .never
        scrollV.delegate = self
        return scrollV
    }()
    
    //MARK: CONTENT VIEW
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        view.backgroundColor = .black
        return view
    }()
    
    //MARK: NETFLIX LOGO
    private lazy var netflixLogo: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "netflix-logo")
        return imageV
    }()
    
    //MARK: POSTER
    private lazy var posterImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(systemName: "person")
//        imageV.backgroundColor = .green
        return imageV
    }()
    
    //MARK: GRADIENT VIEW
    private lazy var gradientView: GradientView = {
        let view = GradientView(gradientStartColor: .black, gradientEndColor: .clear)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    //MARK: SETUP CONSTRAINTS
    private func setupConstraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //MARK: NETFLIX LOGO - CONSTRAINT
        contentView.addSubview(netflixLogo)
        netflixLogo.snp.makeConstraints { make in
            make.leading.equalTo(35)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(53)
            make.width.equalTo(57)
        }
        
        //MARK: POSTER - CONSTRAINT
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(415)
        }
        
        //MARK: POSTER'S BOTTOM GRADIENT - CONSTRAINT
        posterImage.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension HomeViewController: UIScrollViewDelegate{
    
}

