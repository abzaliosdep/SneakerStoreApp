//
//  EmptyCartView.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 18.06.2023.
//

import UIKit

class EmptyCartView: UIView {
    
    private let emptyCartTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.text = "Cart is empty"
        return label
    } ()
    
    private let emptyCartText: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.text = "Find interesting models in the Catalog."
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
        [emptyCartTitle, emptyCartText].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        setConstraints()
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            emptyCartTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emptyCartTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            emptyCartText.topAnchor.constraint(equalTo: emptyCartTitle.bottomAnchor, constant: 16),
            emptyCartText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            emptyCartText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])
    }
}
