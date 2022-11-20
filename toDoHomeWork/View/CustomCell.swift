//
//  CustomCell.swift
//  toDoHomeWork
//
//  Created by Kazakov Danil on 20.11.2022.
//

import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier = "CustomCell"
    
    private lazy var taskTitle: UILabel = {
        let taskTitle = UILabel()
        taskTitle.translatesAutoresizingMaskIntoConstraints = false
        taskTitle.font = .systemFont(ofSize: 16, weight: .semibold)
        taskTitle.text = "Need to go to bakery"
        
        
        return taskTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(taskTitle)
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func updateConstraints() {
        super.updateConstraints()
        NSLayoutConstraint.activate([
            taskTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            taskTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            taskTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
        
        
    }

}
