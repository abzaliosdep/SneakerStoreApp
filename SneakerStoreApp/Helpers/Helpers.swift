//
//  PaddedTextField.swift
//  SneakerStoreApp
//
//  Created by Абзал Бухарбай on 10.06.2023.
//

import UIKit

class PaddedTextField: UITextField { // better to  creat different files, example: PaddedTextField and everything regarding it will be inside and another file for  ShoesService and so on ...
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 10
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 1).cgColor
    }
}

class ShoesService {
    
    static let shared = ShoesService()
    
    public var cartItems = [Shoes]()
    
    public func getAllShoes() -> [Shoes] {
        return [
            Shoes(image: UIImage(named: "1")!, shoesBrand: "Dolce & Gabbana", shoesDescription: "Кеды с принтом граффити", price: 1251),
            
            Shoes(image: UIImage(named: "2")!, shoesBrand: "Off-White", shoesDescription: "Кроссовки Off-Court 3.0", price: 551),
            
            Shoes(image: UIImage(named: "3")!, shoesBrand: "Jordan", shoesDescription: "Кеды с принтом граффити", price: 1251),
            
            Shoes(image: UIImage(named: "4")!, shoesBrand: "Jordan", shoesDescription: "Кеды с принтом граффити", price: 1251),
            
            Shoes(image: UIImage(named: "5")!, shoesBrand: "New Balance", shoesDescription: "Кроссовки 993 Brown из\nколлаборации с Aimé Leon Dore", price: 325),
        ]
    }
    
    public func addShoesToCart(_ item: Shoes) {
        if let existingItemIndex = cartItems.firstIndex(where: { $0.equals(item) }) {
            cartItems[existingItemIndex].quantity! += 1
        } else {
            item.quantity = 1
            cartItems.append(item)
        }
    }
    
    public func removeShoesFromCart(_ item: Shoes) {
        if let existingItemIndex = cartItems.firstIndex(where: { $0.equals(item) }) {
            if cartItems[existingItemIndex].quantity ?? 0 > 1 {
                cartItems[existingItemIndex].quantity! -= 1
            } else {
                cartItems.remove(at: existingItemIndex)
            }
        }
    }
}

class CustomTapGestureRecognizer: UIButton {
    var sneakerIndex: String?
}

class ShoeSizeScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray

    }
}

enum CustomButtonTypes {
    case addToCart
    case addOrRemoveQuantity
}

class CustomButton: UIButton {
    
    public var title: String? {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    public var customButtonType: CustomButtonTypes?
    
    public init(type: CustomButtonTypes? = nil) {
        self.customButtonType = type
        super.init(frame: .zero)
        
        self.backgroundColor = .black
        self.layer.cornerRadius = 12
        
        self.titleLabel?.textColor = .white
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomImageView: UIImageView {
    
    public init() {
        super.init(frame: .zero)
        self.contentMode = .scaleToFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        
        return image
    }
}
