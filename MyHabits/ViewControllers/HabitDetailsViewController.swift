//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Тимур Турлыкин on 25.01.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var habitIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(habitActivityTable)
        view.backgroundColor = .white
        setupConstraints()
        habitActivityTable.delegate = self
        habitActivityTable.dataSource = self
        habitActivityTable.register(HabitDetailsViewCell.self, forCellReuseIdentifier: HabitDetailsViewCell.id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var sortHabitArray = HabitsStore.shared.habits
        sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
        title = sortHabitArray[habitIndex].name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        createRightNavigationBarItem()
        self.habitActivityTable.reloadData()
    }
    
    private lazy var habitActivityTable: UITableView = {
        let habitActivityTable = UITableView()
        habitActivityTable.toAutoLayout()
        habitActivityTable.backgroundColor = ColorStyles.lightGray
        habitActivityTable.separatorStyle = .singleLine
        return habitActivityTable
    }()
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            habitActivityTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitActivityTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitActivityTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitActivityTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.doesRelativeDateFormatting = true
        
        let cell = habitActivityTable.dequeueReusableCell(
            withIdentifier: HabitDetailsViewCell.id,
            for: indexPath
        ) as! HabitDetailsViewCell

        
        let dateArray : [Date] = Array(HabitsStore.shared.dates.reversed())
        cell.textLabel?.text = dateFormatter.string(from: dateArray[indexPath.row])
        var sortHabitArray = HabitsStore.shared.habits
        sortHabitArray.sort(by: {stripTime(from: $0.date) < stripTime(from: $1.date)})
        if HabitsStore.shared.habit(sortHabitArray[habitIndex], isTrackedIn: dateArray[indexPath.item]) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        habitActivityTable.deselectRow(at: indexPath, animated: true)
    }
    
    func createRightNavigationBarItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(rightButtonAction))
        let saveButtonAttributes = [
            NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 17)!,
            NSAttributedString.Key.foregroundColor: ColorStyles.purple,
        ]
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(saveButtonAttributes, for: .normal)
        self.navigationItem.rightBarButtonItem!.setTitleTextAttributes(saveButtonAttributes, for: .highlighted)
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        let habitVC = HabitViewController()
        habitVC.habitIndex = self.habitIndex
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(habitVC, animated: false)
    }
}
