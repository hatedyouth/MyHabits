//
//  Extensions.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 22.01.2022.
//

import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func colorCircle(width: CGFloat) {
        if width <= 428 {
            self.widthAnchor.constraint(equalToConstant: 30).isActive = true
            self.heightAnchor.constraint(equalToConstant: 30).isActive = true
            self.layer.cornerRadius = 15
        }
        else {
            self.widthAnchor.constraint(equalToConstant: 60).isActive = true
            self.heightAnchor.constraint(equalToConstant: 60).isActive = true
            self.layer.cornerRadius = 30
        }
    }
}

func stripTime(from originalDate: Date) -> Date {
    let components = Calendar.current.dateComponents([.hour, .minute], from: originalDate)
    let date = Calendar.current.date(from: components)
    return date!
}

extension UIFont {
    var bold: UIFont { return withWeight(.heavy) }
    var semibold: UIFont { return withWeight(.semibold) }
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

