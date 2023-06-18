//
//  ProfileVC.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 08.06.2023.
//

import UIKit

class CatalogViewController: UIViewController {
    
    var shoes: [Shoes] = ShoesService.shared.getAllShoes()
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let newCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return newCollectionView
    } ()
    
    private let helloLabel: UILabel = {
            let label = UILabel()
            label.text = "Hello, Sneakerhead!"
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(SneakerCollectionViewCell.self, forCellWithReuseIdentifier: SneakerCollectionViewCell.cellIdentifier)
            
            setUI()
        }
        
        private func setUI() {
            self.view.addSubview(helloLabel)
            self.view.addSubview(collectionView)
            
            self.view.backgroundColor = UIColor(named: "CustomGrayBackground")
            collectionView.backgroundColor = UIColor(named: "CustomGrayBackground")

            setConstraints()
        }
        
        private func setConstraints() {
            helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -70).isActive = true
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 16),
                collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
                collectionView.leftAnchor.constraint(equalTo: view.leftAnchor)
            ])
        }
}

extension CatalogViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shoes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SneakerCollectionViewCell.cellIdentifier, for: indexPath) as? SneakerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.shoes = shoes[indexPath.item]
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension CatalogViewController: UICollectionViewDelegate { }

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + 10.0
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / 2
        let height: CGFloat = 282
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.top
    }
}
