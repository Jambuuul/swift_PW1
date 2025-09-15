//
//  ColorStuff.swift
//  doabdulovPW1
//
//  Created by Jam on 15.09.2025.
//

import Foundation
import UIKit


extension UIColor {
    
    private enum ColorConstants {
        // Max hex number to generate color in
        static let maxHex: Int = 0xFFFFFF
        
        static let alpha: CGFloat = 1
        
        // Size of color space (default for sRGB = 256)
        static let colorCount: Int = 256
    }

    //MARK: Generates random color in hex, converts it to sRGB
    static var random: UIColor {
        var color: Int = .random(in:0...(ColorConstants.maxHex));
        
        // по умолчанию 256 параметров у каждого цвета
        // будем "выдирать" части из 16-ричного числа для определения цвета
        // сначала берем по модулю количества цветов - чтобы было число вида #??, те отбрасываем последние 4 цифры
        // потом делим на количество цветов минус 1, чтобы был double от 0 до 1 - искомый параметр, и так по кругу, срезая число по пути
        let red = CGFloat(color % ColorConstants.colorCount) / CGFloat(ColorConstants.colorCount - 1)
        
        color /= ColorConstants.colorCount
        
        let green = CGFloat(color % ColorConstants.colorCount) / CGFloat(ColorConstants.colorCount - 1)
        
        color /= ColorConstants.colorCount
        
        let blue = CGFloat(color % ColorConstants.colorCount) / CGFloat(ColorConstants.colorCount - 1)

        return UIColor(
            displayP3Red: red,
            green: green,
            blue: blue,
            alpha: ColorConstants.alpha
        )
    }
}

