//
//  CartCell.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 14.06.2023.
//

import UIKit

class CartCell: UITableViewCell {
    
    public static let cellIdentifier = "CartCell"
    
    public var cartItem: Shoes? {
        didSet {
            guard let cartItem = cartItem else { return }
            cartImageView.image = cartItem.image
            brandLabel.text = cartItem.shoesBrand
            descriptionLabel.text = cartItem.shoesDescription
            priceLabel.text = "$\(cartItem.price)"
            cartCellButtonView.cellQuantity = cartItem.quantity
        }
    }
    
    private let cartImageView = CustomImageView()
    
    public let cartCellButtonView = CartCellButtonView()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    } ()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(named: "CustomLightGray")
        label.numberOfLines = 2
        return label
    } ()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    } ()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "CustomGrayBackground")
        return separatorView
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        cartCellButtonView.delegate = self
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white.withAlphaComponent(0.98)

        [cartImageView, separatorView, brandLabel, descriptionLabel, priceLabel, cartCellButtonView].forEach { view in
                self.contentView.addSubview(view)
                view.translatesAutoresizingMaskIntoConstraints = false
            }

            setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            cartImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            cartImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            cartImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cartImageView.widthAnchor.constraint(equalToConstant: 140),
            cartImageView.heightAnchor.constraint(equalToConstant: 140),

            separatorView.rightAnchor.constraint(equalTo: self.rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.leftAnchor.constraint(equalTo: self.leftAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 16),

            brandLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 21),
            brandLabel.leftAnchor.constraint(equalTo: cartImageView.rightAnchor, constant: 16),

            descriptionLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 2),
            descriptionLabel.leftAnchor.constraint(equalTo: cartImageView.rightAnchor, constant: 16),

            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            priceLabel.leftAnchor.constraint(equalTo: cartImageView.rightAnchor, constant: 16),

            cartCellButtonView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            cartCellButtonView.leftAnchor.constraint(equalTo: cartImageView.rightAnchor, constant: 16),
            cartCellButtonView.widthAnchor.constraint(equalToConstant: 166),
            cartCellButtonView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}

extension CartCell: CartCellButtonViewDelegate {
    
    func didPlusButtonTapped() {
        guard let cartItem = cartItem else { return }
        cartItem.quantity! += 1 // you already checked that it's not an optional above so no need for using forceunwrapping here
        self.cartItem = cartItem
    }
    
    func didMinusButtonTapped() {
        guard let cartItem = cartItem else { return }
        cartItem.quantity! -= 1
        self.cartItem = cartItem
    }
}
