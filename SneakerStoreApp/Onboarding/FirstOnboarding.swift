//
//  FirstOnboarding.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 05.06.2023.
//

import UIKit

class FirstOnboarding: UIViewController {
    
    var nextView = SecondOnboarding()
    var firstSneaker: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image 1")
        return imageView
    }()
    
    var secondSneaker: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image 2")
        return imageView
    }()
    
    var vector1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Vector 1")
        return imageView
    }()
    
    var whiteCicle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 2")
        return imageView
    }()
  
    var grayCicle1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 3")
        return imageView
    }()
    
    var grayCicle2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Ellipse 3")
        return imageView
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
        blurEffectView.layer.cornerRadius = 12
        vibrancyView.layer.cornerRadius = 12
        blurEffectView.contentView.addSubview(vibrancyView)
        
        return blurEffectView
    }()
    
    var mainText: UILabel = {
        let text = UILabel()
        text.text = "Fast shipping"
        text.textColor = .white
        text.font = .systemFont(ofSize: 28, weight: .bold)
        text.textAlignment = .center
        
        return text
    }()
    
    var smallText: UILabel = {
        let text = UILabel()
        text.text = "Get all of your desired sneakers in one place."
        text.textColor = .white
        text.font = .systemFont(ofSize: 17, weight: .regular)
        text.textAlignment = .center
        
        return text
    }()
    
    var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 1
        button.layer.cornerRadius = 20
        return button
    }()
    
    // Use one folder styling for your files, it's easier to read and add new changes, ex:
    // Variables
    // Outlets
    // LifeCycle: ViewDidLoad, LaodView and e.t.c
    // Public functions
    // Actions
    // Private methods
    @objc private func buttonDidPress() {
        print("Button was pressed!")
        navigationController?.isNavigationBarHidden = true
        navigationController?.pushViewController(nextView, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let views: [UIView] = [firstSneaker, secondSneaker, vector1, blurEffectView, mainText, smallText, button, whiteCicle, grayCicle1, grayCicle2]

            views.forEach { view in
                view.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(view)
            }

        NSLayoutConstraint.activate([
            firstSneaker.topAnchor.constraint(equalTo: view.topAnchor),
            secondSneaker.topAnchor.constraint(equalTo: view.topAnchor, constant: 59),
            secondSneaker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vector1.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.heightAnchor.constraint(equalToConstant: 288),
            blurEffectView.widthAnchor.constraint(equalToConstant: 390),
            
            mainText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -174),
            mainText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainText.heightAnchor.constraint(equalToConstant: 34),
            mainText.widthAnchor.constraint(equalToConstant: 358),
            
            smallText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -136),
            smallText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallText.heightAnchor.constraint(equalToConstant: 22),
            smallText.widthAnchor.constraint(equalToConstant: 358),
            
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            button.heightAnchor.constraint(equalToConstant: 54),
            button.widthAnchor.constraint(equalToConstant: 358),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            whiteCicle.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -248),
            whiteCicle.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -24),
            
            grayCicle1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -248),
            grayCicle1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            grayCicle2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -248),
            grayCicle2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 24)
        ])
        
        
        // For future, try to divide logic inside of your viewDidLoad, for instance use different functions for constraints layout and adding actions and then call them from your lifecycle method
        button.addTarget(self, action: #selector(buttonDidPress), for: .touchUpInside)
    }
}

