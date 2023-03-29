//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Шермат Эшеров on 19/03/2023.
//

import UIKit
import Kingfisher
import SnapKit

class DetailViewController: UIViewController {
    
    private var viewModel = DetailViewModel.shared
    
    private lazy var moviePoster: UIImageView = {
        let imageV = UIImageView()
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
        label.text = "2010"
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
        button.addTarget(self, action: #selector(didFavSelected), for: .touchUpInside)
        return button
    }()
    
    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var wheelOfActors: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
        collectionV.register(WheelColleitonCell.self, forCellWithReuseIdentifier: WheelColleitonCell.identifier)
        collectionV.isPagingEnabled = true
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.backgroundColor = .black
        collectionV.layer.cornerRadius = 22
        collectionV.layer.masksToBounds = true
        return collectionV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupconstraints()
    }
    
    private func setupconstraints(){
        
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.leading.equalTo(25)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(35)
        }
        
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
            make.width.equalTo(view.frame.width / 1.2)
            make.height.equalTo(40)
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
        
        view.addSubview(wheelOfActors)
        wheelOfActors.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(200)
            make.top.equalTo(movieInfrom.snp.bottom).offset(30)
        }
        
    }
    
    func fetchId(id: String, url: String?){
        viewModel.id = id
        self.moviePoster.kf.indicatorType = .activity
        self.moviePoster.kf.setImage(with: URL(string: url ?? ""))
    }
    
    func bindViewModel(){
        viewModel.loadData()
        viewModel.dataMovie.bind { chars in
            DispatchQueue.main.async {
                self.movieTitle.text = chars.fullTitle
                self.movieInfrom.text = chars.year
                self.checkIsSaved()
            }
        }
    }
    
    //MARK: Check is Movie saved
    func checkIsSaved(){
        let dataBase = viewModel.defautls.array(forKey: "MovieIds") as? [String]
        self.viewModel.dataId = dataBase ?? []
        for id in dataBase ?? []{
            if id == viewModel.dataMovie.value.imDBID.description{
                saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
                break
            }
        }
    }
    
    //MARK: Close View
    @objc func dismissTapped(){
        dismiss(animated: true)
    }
    
    //MARK: Save Or Delete
    @objc func didFavSelected(){
        saveButton.isSelected = !saveButton.isSelected
        let data = viewModel.defautls.array(forKey: "MovieIds") as? [String]
        
        if saveButton.isSelected {
            saveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            if let id: String = data?.first(where: { item in
                item == viewModel.dataMovie.value.imDBID.description
            }){
                viewModel.delete(id: viewModel.dataMovie.value.imDBID.description)
            } else {
                //MARK: SAVE
                viewModel.saveId(id: viewModel.dataMovie.value.imDBID.description)
            }
        }else {
            //MARK: Delete
            saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            viewModel.delete(id: viewModel.dataMovie.value.imDBID.description)
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataMovie.value.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WheelColleitonCell.identifier, for: indexPath) as? WheelColleitonCell else { return WheelColleitonCell()}
        let data = viewModel.dataMovie.value.items[indexPath.row]
        cell.fetch(title: data.title, url: data.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: wheelOfActors.frame.width, height: wheelOfActors.frame.height)
    }
    
}
