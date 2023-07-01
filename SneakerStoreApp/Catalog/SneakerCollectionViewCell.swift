//
//  SneakerCollectionViewCell.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 10.06.2023.
//

import UIKit

class SneakerCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "ShoesCell"
    
    public var shoes: Shoes? {
        didSet {
            guard let shoes = shoes else { return }
            shoesImageView.image = shoes.image
            brandLabel.text = shoes.shoesBrand
            descriptionLabel.text = shoes.shoesDescription
            priceLabel.text = "$\(shoes.price)"
        }
    }
    
    public var isAddedToCart: Bool? = false {
        didSet {
            guard let isAddedToCart = isAddedToCart else { return }
            guard let shoes = shoes else { return }
            
            if isAddedToCart && shoes.quantity ?? 0 > 0 {
                cellButton.title = "Remove"
                cellButton.backgroundColor = .black.withAlphaComponent(0.8)
                priceLabel.text = "1 • $\(shoes.price)"
            } else {
                cellButton.title = "Add to cart"
                cellButton.backgroundColor = .black
                priceLabel.text = "$\(shoes.price)"
            }
        }
    }
    
    private let shoesImageView = CustomImageView() // try to use one folder styling, for instance: firslty variables and the outlets, for now they are all mixed
    
    private let cellButton = CustomButton(type: .addToCart)
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "CustomLightGray")
        return label
    } ()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [shoesImageView, cellButton, brandLabel, descriptionLabel, priceLabel].forEach { self.addSubview($0) }
        
        setConstraints()
        setButtons()
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.05
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }
    
    private func setConstraints() {
        shoesImageView.translatesAutoresizingMaskIntoConstraints = false
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shoesImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            shoesImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2),
            shoesImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2),
            shoesImageView.heightAnchor.constraint(equalToConstant: 156),
            
            cellButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            cellButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            cellButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6),
            cellButton.heightAnchor.constraint(equalToConstant: 40),
            
            brandLabel.topAnchor.constraint(equalTo: shoesImageView.bottomAnchor, constant: 2),
            brandLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            brandLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6),
            
            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 2),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6),
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6),
            priceLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6),
        ])
    }

    
    private func setButtons() {
        cellButton.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        cellButton.title = "Add to cart"
    }
}

class Shoes { // better to use struct for models, also naming it just Show will be better option, cause inside of it you are describing one shoe not shoes
    
    private var id: String
    public var image: UIImage
    public var shoesBrand: String
    public var shoesDescription: String
    public var price: Int
    public var quantity: Int?
    
    public init(image: UIImage, shoesBrand: String, shoesDescription: String, price: Int) {
        self.id = UUID().uuidString
        self.image = image
        self.shoesBrand = shoesBrand
        self.shoesDescription = shoesDescription
        self.price = price
    }
    
    public func equals(_ shoes: Shoes) -> Bool {
        return self.id == shoes.id
    }
}

extension SneakerCollectionViewCell {
    
    @objc public func handleButtonAction() { // is there any need for extracting function to extension ?
        if let isAddedToCart = self.isAddedToCart {
            guard let shoes = self.shoes else { return }
            switch isAddedToCart {
            case true:
                ShoesService.shared.removeShoesFromCart(shoes)
            case false:
                ShoesService.shared.addShoesToCart(shoes)
            }
        }
        
        self.isAddedToCart = !self.isAddedToCart!
    }
}
