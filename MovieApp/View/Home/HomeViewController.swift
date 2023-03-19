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
        view.backgroundColor = .red
        return view
    }()
    
    //MARK: NETFLIX LOGO
    private lazy var netflixLogo: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "netflix-logo")
        return imageV
    }()
    
    //MARK: SEARCH BUTTON
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.tintColor = .white
        return button
    }()
    
    //MARK: POSTER
    private lazy var posterImage: UIImageView = {
        let imageV = UIImageView()
        imageV.backgroundColor = .green
        imageV.isUserInteractionEnabled = true
        return imageV
    }()
    
    //MARK: SAVE BUTTON
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark.circle"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        return button
    }()
    
    //MARK: GRADIENT VIEW
    private lazy var gradientView: GradientView = {
        let view = GradientView(gradientStartColor: .black, gradientEndColor: .clear)
        return view
    }()
    //MARK: MOVIE TITLE
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "The Shawshank Redemption"
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var moviesTable: UITableView = {
        let tableV = UITableView()
        tableV.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.showsVerticalScrollIndicator = false
        tableV.isScrollEnabled = false
        tableV.backgroundColor = .black
        return tableV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    //MARK: SETUP CONSTRAINTS
    private func setupConstraints(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        //MARK: POSTER - CONSTRAINT
        contentView.addSubview(posterImage)
        posterImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(415)
        }
        
        //MARK: NETFLIX LOGO - CONSTRAINT
        posterImage.addSubview(netflixLogo)
        netflixLogo.snp.makeConstraints { make in
            make.leading.equalTo(35)
            make.top.equalTo(posterImage.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(53)
            make.width.equalTo(57)
        }
        
        //MARK: SARCH BUTTON - CONSTRAINT
        posterImage.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(netflixLogo)
            make.trailing.equalTo(-25)
            make.width.height.equalTo(45)
        }
        
        //MARK: SAVE BUTTON - CONSTRAINT
        posterImage.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.height.width.equalTo(55)
            make.bottom.equalTo(-60)
        }
        
        //MARK: POSTER'S BOTTOM GRADIENT - CONSTRAINT
        posterImage.addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.height.equalTo(55)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        //MARK: MOVIE TITLE - CONSTRAINT
        gradientView.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        //MARK: MOVIE TABLE VIEW - CONSTRAINT
        contentView.addSubview(moviesTable)
        moviesTable.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(gradientView.snp.bottom)
        }
    }
}

//MARK: TABLE VIEW SETTINGS
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    //MARK: CONNETCT WITH A CUSTOM CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesTableViewCell()

        return cell
    }
    
    //MARK: HEADER TITLE
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Popular on Netflix"
        label.font = .systemFont(ofSize: 21, weight: .semibold)
        return label
    }
    
    //MARK: CELL'S HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

extension HomeViewController: UIScrollViewDelegate{
    
}





