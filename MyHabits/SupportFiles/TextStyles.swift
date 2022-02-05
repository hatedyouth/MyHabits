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
    
    func textFootnote(width: CGFloat) {
        self.toAutoLayout()
        self.numberOfLines = 0
        if width <= 428 {
            self.font = UIFont(name: "SFProText-Semibold", size: 13)
        }
        else {
            self.font = UIFont(name: "SFProText-Semibold", size: 30)
        }
    }
    
    func textHeadline(width: CGFloat) {
        self.toAutoLayout()
        self.numberOfLines = 0
        if width <= 428 {
            self.font = UIFont(name: "SFProText-Semibold", size: 17)
        }
        else {
            self.font = UIFont(name: "SFProText-Semibold", size: 34)
        }
    }
    
    func textCaption(width: CGFloat) {
        self.font = UIFont(name: "SFProText-Regular", size: 12)
        self.toAutoLayout()
        self.numberOfLines = 1
        if width <= 428 {
            self.font = UIFont(name: "SFProText-Semibold", size: 12)
        }
        else {
            self.font = UIFont(name: "SFProText-Semibold", size: 24)
        }
    }
    
    func textFootnoteCell(width: CGFloat) {
        self.toAutoLayout()
        if width <= 428 {
            self.font = UIFont(name: "SFProText-Regular", size: 13)
        }
        else {
            self.font = UIFont(name: "SFProText-Regular", size: 26)
        }
    }
}

extension UITextField {
    func textHeadline(width: CGFloat) {
        self.font = UIFont(name: "SFProText-Semibold", size: 17)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        self.toAutoLayout()
        if width <= 428 {
            self.font = UIFont(name: "SFProText-Semibold", size: 17)
        }
        else {
            self.font = UIFont(name: "SFProText-Semibold", size: 34)
        }
    }
}
