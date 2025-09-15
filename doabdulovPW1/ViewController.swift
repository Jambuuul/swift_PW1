//
//  ViewController.swift
//  doabdulovPW1
//
//  Created by Jam on 10.09.2025.
//

import UIKit

final class ViewController: UIViewController {
    
    // чтобы не было магических чисел)
    private enum Constants {
        static let cornerRadiusMax: CGFloat = 50
        static let animationDuration: TimeInterval = 0.5
        
    }
    
    // как ни странно, аутлет кнопки
    @IBOutlet weak var button: UIButton!
    
    // коллекция аутлетов вьюшек на экране
    @IBOutlet var views: [UIView]!
    
    // множество используемых цветов
    var usedColors: Set<UIColor> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // изначальное заполнение
        for view in views {
            view.backgroundColor = getRandomUniqueColor(for: view)
            view.layer.cornerRadius = .random(in: 0...(Constants.cornerRadiusMax))
        }
        
        
    }
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        
        self.button.isEnabled = false
        self.button.setTitle("stars loading....", for: .normal)
        
        UIView.animate(
            withDuration: Constants.animationDuration,
                animations: {
                    for view in self.views {
                        view.backgroundColor = self.getRandomUniqueColor(for: view)
                        view.layer.cornerRadius = .random(in: 0...(Constants.cornerRadiusMax))
                    }
                },
                completion: { [weak self] _ in
                    self?.button.isEnabled = true
                    self?.button.setTitle("are you happy now?", for: .normal)
                })
    }
    

    /**
     Creates unique and random UIColor object

     - Parameter view:  UIView object to create color for
     - Returns: Random UIColor object
     */
    private func getRandomUniqueColor(for view: UIView) -> UIColor {
        
        if let oldColor = view.backgroundColor {
            usedColors.remove(oldColor)
        }
        
        var newColor: UIColor!
        repeat {
            newColor = UIColor.random
        } while usedColors.contains(newColor)
        
        usedColors.insert(newColor)
        
        return newColor
    }
}

