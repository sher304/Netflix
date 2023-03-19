//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private lazy var moviePoster: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .orange
        return imageV
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "The Shawshank Redemption"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    private lazy var movieInfrom: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamus bibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa, id ut ipsum aliquam  enim non posuere pulvinar diam."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupconstraints()
        
    }
    
    private func setupconstraints(){
        view.addSubview(moviePoster)
        moviePoster.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(45)
            make.height.equalTo(195)
        }
        
        view.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(moviePoster.snp.bottom).offset(25)
        }
        
        view.addSubview(movieInfrom)
        movieInfrom.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.trailing.equalTo(-20)
            make.top.equalTo(movieTitle.snp.bottom).offset(15)
            make.height.equalTo(45)
        }
        
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.height.width.equalTo(40)
            make.centerY.equalTo(movieTitle)
        }
        
    }
}
