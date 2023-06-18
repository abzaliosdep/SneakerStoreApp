//
//  CartCellViews.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 18.06.2023.
//

import UIKit

protocol CartCellButtonViewDelegate {
    func didPlusButtonTapped()
    func didMinusButtonTapped()
}

class CartCellButtonView: UIView {
    
    public var delegate: CartCellButtonViewDelegate?
    
    public var cellQuantity: Int? {
        didSet {
            guard let quantity = cellQuantity else { return }
            quantityLabel.text = "\(quantity)"
        }
    }
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    } ()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    } ()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        return button
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 18
        
        [minusButton, quantityLabel, plusButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setConstraints()
        setActions()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            quantityLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            minusButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor, constant: -14)
        ])

        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 14)
        ])
    }
    
    private func setActions() {
        minusButton.addTarget(self, action: #selector(handleMinusButton), for: .touchUpInside)
        minusButton.isUserInteractionEnabled = true
        
        plusButton.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        plusButton.isUserInteractionEnabled = true
    }
}

extension CartCellButtonView {
    
    @objc private func handleMinusButton() {
        print("minus")
        delegate?.didMinusButtonTapped()
    }
    
    @objc private func handlePlusButton() {
        print("plus")
        delegate?.didPlusButtonTapped()
    }
}

class CartTotalPriceView: UIView {
    
    public var totalItems: Int? {
        didSet {
            guard let totalItems = totalItems else { return }
            cartTotalLabel.text = "\(totalItems) items: Total (Including Delivery)"
        }
    }
    
    public var totalPrice: Int? {
        didSet {
            guard let totalPrice = totalPrice else { return }
            cartTotalPrice.text = "$\(totalPrice)"
        }
    }
    
    private let cartTotalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    } ()
    
    private let cartTotalPrice: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
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
        self.backgroundColor = .white.withAlphaComponent(0.98)
        [cartTotalLabel, cartTotalPrice].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            cartTotalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cartTotalLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            cartTotalLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),

            cartTotalPrice.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cartTotalPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cartTotalPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
    }
}

protocol SuccessBottomSheetDelegate: AnyObject {
    func didTapBackToShopping()
}

class SuccessBottomSheetViewController: UIViewController {
    
    weak var delegate: SuccessBottomSheetDelegate?
    
    private var backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = .white
        background.layer.cornerRadius = 12
        return background
    } ()
    
    private let successLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Your order is succesfully\nplaced. Thanks!"
        return label
    } ()
    
    private let backButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        self.view.backgroundColor = .clear
        [backgroundView, successLabel, backButton].forEach {
            self.view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setConstraints()
        
        setButtons()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 312),

            backButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            backButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -58),
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 54),

            successLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            successLabel.bottomAnchor.constraint(equalTo: backButton.topAnchor, constant: -24),
            successLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        ])
    }

    
    private func setButtons() {
        backButton.title = "Get back to shopping"
        backButton.layer.cornerRadius = 24
        backButton.addTarget(self, action: #selector(backToShopping), for: .touchUpInside)
    }
}

extension SuccessBottomSheetViewController {
    
    @objc private func backToShopping() {
        dismiss(animated: true)
        delegate?.didTapBackToShopping()
    }
}
