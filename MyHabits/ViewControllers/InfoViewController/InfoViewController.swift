//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 22.01.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
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
        infoTitle.text = InfoViewControllerConstants.title
        infoTitle.textTitle3(width: view.frame.width)
        return infoTitle
    }()
    
    private lazy var infoText: UILabel = {
        let text = UILabel()
        text.text = InfoViewControllerConstants.text
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
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: InfoViewControllerConstants.leadingMargin),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: InfoViewControllerConstants.trailingMargin),
            
            infoTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: InfoViewControllerConstants.topMargin),
            infoTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            infoText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            infoText.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            infoText.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: InfoViewControllerConstants.bottomMargin),
            infoText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    
}
