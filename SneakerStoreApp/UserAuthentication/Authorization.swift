//
//  Authorization.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 07.06.2023.
//

import UIKit

class Authorization: UIViewController, UITextFieldDelegate {
    
    let username: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Username"
        textField.tintColor = UIColor.black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return textField
    }()
    
    let password: PaddedTextField = {
        let textField = PaddedTextField()
        textField.placeholder = "Password"
        textField.tintColor = UIColor.black
        textField.layer.cornerRadius = 4
        textField.backgroundColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1)
        return textField
    }()
    
    let allert: UILabel = {
        let text = UILabel()
        text.text = ""
        text.font = .systemFont(ofSize: 17, weight: .regular)
        text.textAlignment = .center
        return text
    }()
    
    let chevron: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevron.left")
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Welcom back!"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    @objc private func buttonDidPress() {
            transition()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [username, password, allert, button, chevron, label].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            username.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            username.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            username.widthAnchor.constraint(equalToConstant: 358),
            username.heightAnchor.constraint(equalToConstant: 48),

            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: view.topAnchor, constant: 204),
            password.widthAnchor.constraint(equalToConstant: 358),
            password.heightAnchor.constraint(equalToConstant: 48),

            allert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            allert.topAnchor.constraint(equalTo: view.topAnchor, constant: 380),
            allert.widthAnchor.constraint(equalToConstant: 358),
            allert.heightAnchor.constraint(equalToConstant: 48),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            button.widthAnchor.constraint(equalToConstant: 358),
            button.heightAnchor.constraint(equalToConstant: 54),

            chevron.topAnchor.constraint(equalTo: view.topAnchor, constant: 55),
            chevron.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        button.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)
        chevron.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chevronTapped)))
        chevron.isUserInteractionEnabled = true
        
        username.delegate = self
        password.delegate = self
    }

    
    @objc func chevronTapped() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.popViewController(animated: true)
    }
    
    private func transition() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(MainTabBarVC.shared, animated: true)
        appDelegate?.appState = .signedIn
    }
    
    
    // Try to reuse this logic, cause it's repeating in several places, for example: Registration Page
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
    }
}

