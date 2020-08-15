//
//  Extensions.swift
//  Live Better Final Project
//
//  Created by Harshana Ekanayake on 8/7/20.
//  Copyright © 2020 Jordyn Adegun. All rights reserved.
//

import Foundation

extension CLPlacemark {
    
    var address: String {
        get {
            let outputString = [self.locality,
                                self.subLocality,
                                self.thoroughfare,
                                self.postalCode,
                                self.subThoroughfare,
                                self.country].compactMap{$0}.joined(separator: ", ")
            return outputString
        }
    }
}

extension UIButton {
    
    func underline(color: UIColor? = nil) {
        guard let title = self.titleLabel else { return }
        guard let tittleText = title.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (tittleText.count)))
        
        if (color != nil) {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: NSRange(location: 0, length: (tittleText.count)))
        }
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

