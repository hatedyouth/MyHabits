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
}

func stripTime(from originalDate: Date) -> Date {
    let components = Calendar.current.dateComponents([.hour, .minute], from: originalDate)
    let date = Calendar.current.date(from: components)
    return date!
}

