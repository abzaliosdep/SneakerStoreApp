//
//  CartVC.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 08.06.2023.
//

import UIKit

class CartVC: UIViewController {
    
    private var cartItems = [Shoes]() {
        didSet {
            cartTotalView.totalItems = cartItems.count
            cartTotalView.totalPrice = getTotalPrice()
        }
    }
    
    private let emptyCartView = EmptyCartView()
    
    private let cartTotalView = CartTotalPriceView()
    
    private let cartConfirmButton = CustomButton()
    
    private let cartTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(named: "CustomGrayBackground")
        table.register(CartCell.self, forCellReuseIdentifier: CartCell.cellIdentifier)
        table.separatorStyle = .none
        return table
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        setUI()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    private func setUI() {
        setConstraints()
        setButtons()
    }
    
    private func setConstraints() {
        [emptyCartView, cartTableView, cartTotalView, cartConfirmButton].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            emptyCartView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300),
            emptyCartView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            emptyCartView.leftAnchor.constraint(equalTo: self.view.leftAnchor),

            cartTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            cartTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            cartTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -200),
            cartTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),

            cartTotalView.topAnchor.constraint(equalTo: cartTableView.bottomAnchor),
            cartTotalView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            cartTotalView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            cartTotalView.heightAnchor.constraint(equalToConstant: 50),

            cartConfirmButton.topAnchor.constraint(equalTo: cartTotalView.bottomAnchor, constant: 6),
            cartConfirmButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            cartConfirmButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            cartConfirmButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    private func setButtons() {
        cartConfirmButton.title = "Confirm Order"
        cartConfirmButton.layer.cornerRadius = 24
        cartConfirmButton.addTarget(self, action: #selector(didConfirmButtonTapped), for: .touchUpInside)
    }
}

extension CartVC: SuccessBottomSheetDelegate {
    
    func didTapBackToShopping() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateUI() {
        cartItems = ShoesService.shared.cartItems
        updateEmptyCartViewVisibility()
        cartTableView.reloadData()
    }
    
    private func updateEmptyCartViewVisibility() {
        if cartItems.isEmpty {
            emptyCartView.isHidden = false
            cartTableView.isHidden = true
            cartTotalView.isHidden = true
            cartConfirmButton.isHidden = true
        } else {
            emptyCartView.isHidden = true
            cartTableView.isHidden = false
            cartTotalView.isHidden = false
            cartConfirmButton.isHidden = false
        }
    }
    
    private func getTotalPrice() -> Int {
        var sum: Int = 0
        cartItems.forEach { sum += $0.price }
        return sum
    }
    
    @objc private func didConfirmButtonTapped() {
        let alert = UIAlertController(title: "Proceed with payment", message: "Are you sure you want to confirm?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            self.openCustomBottomSheet()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func openCustomBottomSheet() {
        let successViewController = SuccessBottomSheetViewController()
        successViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: successViewController)
        present(navigationController, animated: true, completion: nil)
    }
}

extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartCell.cellIdentifier, for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        
        cell.cartItem = cartItems[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CartVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
