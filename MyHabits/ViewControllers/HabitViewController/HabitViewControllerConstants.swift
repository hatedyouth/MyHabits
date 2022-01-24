//
//  HabitViewControllerConstants.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 22.01.2022.
//

import UIKit


struct HabitViewControllerConstants {
    static let title: String = "Создать"
    static let titleTextFieldPlaceholder: String = "Бегать по утрам, спать 8 часов и т.п."
    static let habitColorLabel: String = "ЦВЕТ"
    static let habitTimeTitleLable: String = "ВРЕМЯ"
    static let attributedString1: String = "Каждый день в "
    static let habitDeleteButtonTitle: String = "Удалить привычку"
    static let cancelButtonTitle: String = "Отменить"


}


extension UIView {
    
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

