//
//  ViewController.swift
//  doabdulovPW1
//
//  Created by Jam on 10.09.2025.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {

        if (hex.count != 6) {
            self.init(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 1.0
            )
            return;
        }
        
        let hexNumber = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
        let scanner = Scanner(string: hexNumber)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1.0
        )
    }
}

final class ViewController: UIViewController {



    @IBOutlet weak var button: UIButton!
    // коллекция аутлетов вьюшек на экране
    @IBOutlet var views: [UIView]!
    
    // множество используемых цветов
    var usedColors: Set<UIColor> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for view in views {
            view.backgroundColor = getRandomUniqueColor(for: view)
            view.layer.cornerRadius = .random(in: 0...30)
        }
        
        
    }
    
    @IBAction func buttonWasPressed(_ sender: Any) {
        
        self.button.isEnabled = false
        self.button.setTitle("why you press me", for: .normal)
        
        UIView.animate(
                withDuration: 1,
                animations: {
                    for view in self.views {
                        view.backgroundColor = self.getRandomUniqueColor(for: view)
                        view.layer.cornerRadius = .random(in: 0...30)
                    }
                },
                completion: { [weak self] _ in
                    self?.button.isEnabled = true
                    self?.button.setTitle("im hurt", for: .normal)
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
            newColor = generateRandomUIColor()
        } while usedColors.contains(newColor)
        
        usedColors.insert(newColor)
        
        return newColor
    }
    
    /**
     Generates random color
     
     - Returns: random UIColor object
     */
    private func generateRandomUIColor() -> UIColor {
        /* old variant (default random */
        return UIColor(
            displayP3Red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
         
        
        // hex variant
//        let randomNumber = Int.random(in: 0...0xFFFFFF)
//        let hexString = String(format: "%06X", randomNumber)
//        return UIColor(hex: hexString)
    }
    
    
}

