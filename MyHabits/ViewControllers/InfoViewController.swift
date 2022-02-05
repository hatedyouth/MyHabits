//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 22.01.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    static let infoText: String =
    """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

Источник: psychbook.ru
"""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let infoContentView = UIView()
        infoContentView.toAutoLayout()
        return infoContentView
    }()
    
    private lazy var infoTitle: UILabel = {
        let infoTitle = UILabel()
        infoTitle.text = "Привычка за 21 день"
        infoTitle.textTitle3(width: view.frame.width)
        return infoTitle
    }()
    
    private lazy var infoText: UILabel = {
        let text = UILabel()
        text.text = InfoViewController.infoText
        text.textBody(width: view.frame.width)
        return text
    }()
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(infoTitle, infoText)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            
            infoTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            infoTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            infoText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoText.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            infoText.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 16),
            infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
