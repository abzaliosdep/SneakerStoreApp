//
//  WelcomePage.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 05.06.2023.
//

import UIKit

class WelcomePage: UIViewController {
    
    var sevensSneaker: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 7")
        return imageView
    }()
    
    var eightsSneaker: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 6")
        return imageView
    }()
    
    var vector1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector 4")
        return imageView
    }()
    
    var smallText: UILabel = {
        let text = UILabel()
        text.text = "I already have an account"
        text.font = .systemFont(ofSize: 17, weight: .regular)
        text.textAlignment = .center
        return text
    }()
    
    var mainText: UILabel = {
        let text = UILabel()
        text.text = "Welcome to the biggest sneakers store app"
        text.font = .systemFont(ofSize: 28, weight: .bold)
        text.textAlignment = .center
        text.numberOfLines = 0
        return text
    }()
    
    var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    @objc private func buttonDidPress() {
        print("Button was pressed!")
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(Registration(), animated: true)
    }
    
    @objc func authTap(sender: UITapGestureRecognizer) {
        print("Button was pressed!")
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(Authorization(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let tapForAuthetication = UITapGestureRecognizer(target: self, action: #selector(WelcomePage.authTap))
        smallText.isUserInteractionEnabled = true
        smallText.addGestureRecognizer(tapForAuthetication)

        let views: [UIView] = [vector1, sevensSneaker, eightsSneaker, button, smallText, mainText]

        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(view)
        }

        NSLayoutConstraint.activate([
            vector1.topAnchor.constraint(equalTo: view.topAnchor),
            sevensSneaker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sevensSneaker.topAnchor.constraint(equalTo: view.topAnchor, constant: 352),
            sevensSneaker.heightAnchor.constraint(equalToConstant: 228),
            sevensSneaker.widthAnchor.constraint(equalToConstant: 228),
            eightsSneaker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eightsSneaker.topAnchor.constraint(equalTo: view.topAnchor, constant: 247),
            eightsSneaker.heightAnchor.constraint(equalToConstant: 246),
            eightsSneaker.widthAnchor.constraint(equalToConstant: 246),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            button.heightAnchor.constraint(equalToConstant: 54),
            button.widthAnchor.constraint(equalToConstant: 358),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74),
            smallText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallText.widthAnchor.constraint(equalToConstant: 318),
            smallText.heightAnchor.constraint(equalToConstant: 22),
            mainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -198),
            mainText.widthAnchor.constraint(equalToConstant: 358),
            mainText.heightAnchor.constraint(equalToConstant: 68)
        ])

        button.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)
    }

}
