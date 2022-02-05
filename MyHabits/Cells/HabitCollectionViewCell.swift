//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 25.01.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    static let id = "HabitTableViewCell"
    
    var habit = Habit(name: "", date: Date(), color: .white)
    
    var habitTrackCircleAction : (()->())?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = ColorStyles.lightGray
        contentView.addSubview(habitCellBackView)
        habitCellBackView.addSubviews(habitTitle, habitTime, habitCount, habitTrackButton, habitCheckMarkImageView)
        setupConstraints()
    }
    
    private lazy var habitCellBackView: UIView = {
        let habitCellBackView = UIView()
        habitCellBackView.toAutoLayout()
        habitCellBackView.layer.cornerRadius = 8;      habitCellBackView.backgroundColor = .white
        return habitCellBackView
    }()
    
    private lazy var habitTitle: UILabel = {
        let habitTitle = UILabel()
        habitTitle.textHeadline(width: contentView.frame.width)
        habitTitle.numberOfLines = 1
        return habitTitle
    }()
    
    private lazy var habitTime: UILabel = {
        let habitTime = UILabel()
        habitTime.textCaption(width: contentView.frame.width)
        habitTime.textColor = .systemGray2
        return habitTime
    }()
    
    private lazy var habitCount: UILabel = {
        let habitCount = UILabel()
        habitCount.textFootnoteCell(width: contentView.frame.width)
        habitCount.textColor = .systemGray
        return habitCount
    }()
    
    lazy var habitTrackButton: UIButton = {
        let habitTrackButton = UIButton()
        habitTrackButton.toAutoLayout()
        habitTrackButton.layer.cornerRadius = 19
        habitTrackButton.clipsToBounds = true
        habitTrackButton.addTarget(self, action: #selector(habitTrackCirclePressed), for: .touchUpInside)
        return habitTrackButton
    }()
    
    private lazy var habitCheckMarkImageView: UIImageView = {
        let habitCheckMarkImageView = UIImageView(image: UIImage.init(systemName: "checkmark"))
        habitCheckMarkImageView.tintColor = .white
        habitCheckMarkImageView.toAutoLayout()
        return habitCheckMarkImageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions
extension HabitCollectionViewCell {
    
    func configureCell(habit: Habit) {
        habitTitle.text = habit.name
        habitTitle.textColor = habit.color
        habitTime.text = habit.dateString
        habitCount.text = "Счётчик: \(habit.trackDates.count)"
        if habit.isAlreadyTakenToday {
            habitTrackButton.backgroundColor = habit.color
            habitTrackButton.layer.borderWidth = 0
        }
        else {
            habitTrackButton.backgroundColor = .white
            habitTrackButton.layer.borderWidth = 2
            habitTrackButton.layer.borderColor = habit.color.cgColor
        }
    }
    
    @objc func habitTrackCirclePressed() {
        habitTrackCircleAction?()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            habitCellBackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            habitCellBackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            habitCellBackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            habitCellBackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            habitTitle.topAnchor.constraint(equalTo: habitCellBackView.topAnchor, constant: 20),
            habitTitle.leadingAnchor.constraint(equalTo: habitCellBackView.leadingAnchor, constant: 20),
            habitTitle.trailingAnchor.constraint(equalTo: habitCellBackView.trailingAnchor, constant: -20),
            
            habitTime.topAnchor.constraint(equalTo: habitTitle.bottomAnchor, constant: 7),
            habitTime.leadingAnchor.constraint(equalTo: habitCellBackView.leadingAnchor, constant: 20),
            
            habitCount.leadingAnchor.constraint(equalTo: habitCellBackView.leadingAnchor, constant: 20),
            habitCount.bottomAnchor.constraint(equalTo: habitCellBackView.bottomAnchor, constant: -20),
            
            habitTrackButton.widthAnchor.constraint(equalToConstant: 38),
            habitTrackButton.heightAnchor.constraint(equalToConstant: 38),
            habitTrackButton.trailingAnchor.constraint(equalTo: habitCellBackView.trailingAnchor, constant: -25),
            habitTrackButton.centerYAnchor.constraint(equalTo: habitCellBackView.centerYAnchor),
            
            habitCheckMarkImageView.centerXAnchor.constraint(equalTo: habitTrackButton.centerXAnchor),
            habitCheckMarkImageView.centerYAnchor.constraint(equalTo: habitTrackButton.centerYAnchor),
        ])
    }
}
