//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 22.01.2022.
//

import UIKit

class HabitViewController: UIViewController, UITextFieldDelegate {
    
    let currentDateTime = Date()
    var habitColor: UIColor = ColorStyles.orange
    var habitIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = HabitViewControllerConstants.title
        HabitTitleTextField.delegate = self
        hideKeyboard()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        createCancelButton()
        createSaveButton()
        view.addSubviews(HabitTitleLabel,
                         HabitTitleTextField,
                         HabitColorLabel,
                         HabitColor,
                         HabitTimeTitleLable,
                         HabitTimeLabel,
                         HabitDatePicker,
                         habitDeleteButton)
        setupConstraints()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private lazy var HabitTitleLabel: UILabel = {
        let HabitTitleLabel = UILabel()
        HabitTitleLabel.text = HabitViewControllerConstants.habitTitleLabel
        HabitTitleLabel.textFootnote(width: view.frame.width)
        return HabitTitleLabel
    }()
    
    private lazy var HabitTitleTextField: UITextField = {
        let textfield = UITextField()
        textfield.textHeadline(width: view.frame.width)
        textfield.placeholder = HabitViewControllerConstants.titleTextFieldPlaceholder
        textfield.autocorrectionType = .no
        if habitIndex != nil {
            var sortHabitArray = HabitsStore.shared.habits
            sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
            textfield.text = sortHabitArray[habitIndex!].name
            habitColor = sortHabitArray[habitIndex!].color
        }
        textfield.textColor = habitColor
        return textfield
    }()
    
    private lazy var HabitColorLabel: UILabel = {
        let HabitColorLabel = UILabel()
        HabitColorLabel.text = HabitViewControllerConstants.habitColorLabel
        HabitColorLabel.textFootnote(width: view.frame.width)
        return HabitColorLabel
    }()
    
    private lazy var HabitColor: UIView = {
        let HabitColor = UIView()
        HabitColor.toAutoLayout()
        HabitColor.backgroundColor = habitColor
        HabitColor.colorCircle(width: view.frame.width)
        if habitIndex != nil {
            var sortHabitArray = HabitsStore.shared.habits
            sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
            habitColor = sortHabitArray[habitIndex!].color
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(habitColorViewPresent))
        HabitColor.addGestureRecognizer(gesture)
        return HabitColor
    }()
    
    private lazy var HabitTimeTitleLable: UILabel = {
        let HabitTimeTitleLable = UILabel()
        HabitTimeTitleLable.text = HabitViewControllerConstants.habitTimeTitleLable
        HabitTimeTitleLable.textFootnote(width: view.frame.width)
        return HabitTimeTitleLable
    }()
    
    private lazy var HabitTimeLabel: UILabel = {
        let HabitTimeLabel = UILabel()
        HabitTimeLabel.textBody(width: view.frame.width)
        return HabitTimeLabel
    }()
    
    private lazy var HabitDatePicker: UIDatePicker = {
        let HabitDatePicker = UIDatePicker()
        HabitDatePicker.toAutoLayout()
        HabitDatePicker.datePickerMode = .time
        HabitDatePicker.preferredDatePickerStyle = .wheels
        if habitIndex != nil {
            var sortHabitArray = HabitsStore.shared.habits
            sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
            HabitDatePicker.date = sortHabitArray[habitIndex!].date
        } else {
            HabitDatePicker.date = currentDateTime
        }
        
        HabitDatePicker.addTarget(self, action: #selector(HabitDatePickerSet), for: .valueChanged)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let date = HabitDatePicker.date
        let currentTime = dateFormatter.string(from: date)
        
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : ColorStyles.purple]
        let attributedString1 = NSAttributedString(string: HabitViewControllerConstants.attributedString1, attributes: nil)
        let attributedString2 = NSAttributedString(string: currentTime, attributes: attributedStringColor)
        
        var concate = NSMutableAttributedString(attributedString: attributedString1)
        concate.append(attributedString2)
        
        HabitTimeLabel.attributedText = concate
        
        if view.frame.width <= 428 {
            HabitDatePicker.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        else {
            HabitDatePicker.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        return HabitDatePicker
    }()
    
    private lazy var habitDeleteButton: UIButton = {
        let habitDeleteButton = UIButton()
        habitDeleteButton.toAutoLayout()
        habitDeleteButton.setTitle(HabitViewControllerConstants.habitDeleteButtonTitle, for: .normal)
        habitDeleteButton.setTitleColor(.red, for: .normal)
        habitDeleteButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)
        if habitIndex != nil {
            habitDeleteButton.isHidden = false
        } else {
            habitDeleteButton.isHidden = true
        }
        habitDeleteButton.addTarget(self, action: #selector(habitDelete), for: .touchUpInside)
        return habitDeleteButton
    }()
}
    
extension HabitViewController: UIColorPickerViewControllerDelegate {
    private func createCancelButton() {
        let cancelButton = UIBarButtonItem(title: HabitViewControllerConstants.cancelButtonTitle,
                                           style: UIBarButtonItem.Style.plain,
                                           target: self,
                                           action: #selector(cancelButton))
        
        let cancelButtonAttributes = [
            NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 17)!,
            NSAttributedString.Key.foregroundColor: ColorStyles.purple,
        ]
        
        cancelButton.setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        cancelButton.setTitleTextAttributes(cancelButtonAttributes, for: .highlighted)
        
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func createSaveButton() {
        let saveButton = UIBarButtonItem(title: HabitViewControllerConstants.saveButtonTitle,
                                         style: UIBarButtonItem.Style.plain,
                                         target: self,
                                         action: #selector(saveButton))
        
        let saveButtonAttributes = [
            NSAttributedString.Key.font: UIFont(name: "SFProText-Semibold", size: 17)!,
            NSAttributedString.Key.foregroundColor: ColorStyles.purple,
        ]
        
        saveButton.setTitleTextAttributes(saveButtonAttributes, for: .normal)
        saveButton.setTitleTextAttributes(saveButtonAttributes, for: .highlighted)
        
        navigationItem.rightBarButtonItem = saveButton
    }
    
    private func closeViewController() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    
    @objc func cancelButton() {
        closeViewController()
    }
    
    @objc func saveButton() {
        closeViewController()
        if habitIndex != nil {
            var sortHabitArray = HabitsStore.shared.habits
            sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
            sortHabitArray[habitIndex!].name = HabitTitleTextField.text ?? ""
            sortHabitArray[habitIndex!].color = habitColor
            sortHabitArray[habitIndex!].date = HabitDatePicker.date
        } else {
            let Habit = Habit(name: HabitTitleTextField.text ?? "", date: HabitDatePicker.date, color: habitColor)
            HabitsStore.shared.habits.append(Habit)
        }
    }
    
    @objc func habitColorViewPresent() {
        let colorViewController = UIColorPickerViewController()
        colorViewController.delegate = self
        self.present(colorViewController, animated: true) {
        }
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habitColor = viewController.selectedColor
        HabitColor.backgroundColor = habitColor
        HabitTitleTextField.textColor = habitColor
    }
    
    @objc func habitDelete() {
        var sortHabitArray = HabitsStore.shared.habits
        sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
        let deleteAlert = UIAlertController(title: HabitViewControllerConstants.deleteAlertTitle, message: "Вы хотите удалить привычку \(sortHabitArray[habitIndex!].name)?", preferredStyle: .alert)
        deleteAlert.addAction(UIAlertAction(title: NSLocalizedString(HabitViewControllerConstants.cancelActionTitle, comment: ""), style: .cancel, handler: nil))
        deleteAlert.addAction(UIAlertAction(title: HabitViewControllerConstants.deleteActionTitle, style: .destructive, handler: { [self] _ in
            let habitIndexForDelete = HabitsStore.shared.habits.firstIndex(of: sortHabitArray[self.habitIndex!])
            if let index = habitIndexForDelete {
                HabitsStore.shared.habits.remove(at: index)
                sortHabitArray.remove(at: self.habitIndex!)
                navigationController?.popToRootViewController(animated: true)
            }
        }))
        self.present(deleteAlert, animated: true, completion: nil)
    }
    
    @objc func HabitDatePickerSet() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        let date = HabitDatePicker.date
        let currentTime = dateFormatter.string(from: date)
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : ColorStyles.purple]
        let attributedString1 = NSAttributedString(string: HabitViewControllerConstants.attributedString1, attributes: nil)
        let attributedString2 = NSAttributedString(string: currentTime, attributes: attributedStringColor)
        let concate = NSMutableAttributedString(attributedString: attributedString1)
        concate.append(attributedString2)
        HabitTimeLabel.attributedText = concate
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            HabitTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: HabitViewControllerConstants.topMargin * 3),
            HabitTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: HabitViewControllerConstants.leadingMargin),
            
            HabitTitleTextField.topAnchor.constraint(equalTo: HabitTitleLabel.bottomAnchor, constant: HabitViewControllerConstants.topMargin),
            HabitTitleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: HabitViewControllerConstants.leadingMargin),
            HabitTitleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: HabitViewControllerConstants.trailingMargin),
            
            HabitColorLabel.topAnchor.constraint(equalTo: HabitTitleTextField.bottomAnchor, constant: (HabitViewControllerConstants.topMargin * 2) - 1),
            HabitColorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: HabitViewControllerConstants.leadingMargin),
            
            HabitColor.topAnchor.constraint(equalTo: HabitColorLabel.bottomAnchor, constant: HabitViewControllerConstants.topMargin),
            HabitColor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: HabitViewControllerConstants.leadingMargin),
            
            HabitTimeTitleLable.topAnchor.constraint(equalTo: HabitColor.bottomAnchor, constant: HabitViewControllerConstants.topMargin),
            HabitTimeTitleLable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: HabitViewControllerConstants.leadingMargin),
            
            HabitTimeLabel.topAnchor.constraint(equalTo: HabitTimeTitleLable.bottomAnchor, constant: HabitViewControllerConstants.topMargin),
            HabitTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: HabitViewControllerConstants.leadingMargin),
            
            HabitDatePicker.topAnchor.constraint(equalTo: HabitTimeLabel.bottomAnchor, constant: (HabitViewControllerConstants.topMargin * 2) - 1),
            HabitDatePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            HabitDatePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            habitDeleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: HabitViewControllerConstants.bottomMargin),
            habitDeleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

