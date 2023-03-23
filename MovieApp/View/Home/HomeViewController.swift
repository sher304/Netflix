//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 18/03/2023.
//

import UIKit
import Kingfisher
import Hero
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var viewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    //MARK: SIZE
    private lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 460)
    
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
    
    //MARK: SEARCH BUTTON
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didSearchTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: POSTER
    private lazy var posterImage: UIImageView = {
        let imageV = UIImageView()
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
        label.font = .systemFont(ofSize: 26, weight: .heavy)
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
        bindViewModel()
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
            make.height.equalTo(445)
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

    
    func bindViewModel(){
        viewModel.shareData()
        viewModel.movies.bind { _ in
            DispatchQueue.main.async { [self] in
                self.movieTitle.text = viewModel.movies.value.items.first?.title
                self.posterImage.kf.setImage(with: URL(string: viewModel.movies.value.items.first?.image ?? "nil"))
                self.moviesTable.reloadData()

            }
        }
    }
    
    func fillData(){
        DispatchQueue.main.async { [self] in
            let item = viewModel.movies.value.items
            print(item)
            movieTitle.text = item.first?.fullTitle
            posterImage.kf.setImage(with: URL(string: item.first?.image ?? ""))
        }
    }
    
    @objc func didSearchTapped(){
        let vc = SearchViewController()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .cover(direction: .up)
        present(vc, animated: true)
    }
}

//MARK: TABLE VIEW SETTINGS
extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    //MARK: NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: CONNETCT WITH A CUSTOM CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesTableViewCell()
        let items = viewModel.movies.value
        cell.fetchData(data: items, delegate: self)
        return cell
    }
    
    //MARK: HEADER TITLE
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Popular on Netflix"
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        return label
    }
    
    //MARK: CELL'S HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 620
    }
}

extension HomeViewController: UIScrollViewDelegate{
    
}


extension HomeViewController: MovieTableDelegate {
    func didSelected(indx: String) {
        let vc = DetailViewController()
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .slide(direction: .up)
        viewModel.movies.value.items.forEach { i in
            if i.rank == indx{
                vc.fetchId(id: i.id)
            }
        }
        present(vc, animated: true)
    }
}
