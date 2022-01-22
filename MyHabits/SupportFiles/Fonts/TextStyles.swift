//
//  TextStyles.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 22.01.2022.
//

import UIKit

extension UILabel {
    
    func textTitle3(width: CGFloat) {
        self.toAutoLayout()
        self.numberOfLines = 0
        if width <= 428 {
            self.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        }
        else {
            self.font = UIFont(name: "SFProDisplay-Semibold", size: 40)
        }
    }
    
    func textBody(width: CGFloat) {
        self.toAutoLayout()
        self.numberOfLines = 0
        if width <= 428 {
            self.font = UIFont(name: "SFProText-Regular", size: 17)
        }
        else {
            self.font = UIFont(name: "SFProText-Regular", size: 24)
        }
    }
}
