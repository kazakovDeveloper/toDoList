//
//  NewTaskViewController.swift
//  toDoHomeWork
//
//  Created by Kazakov Danil on 20.11.2022.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var delegate: TasksViewControllerDelegate!
    
    //MARK: - UI ELEMENTS
    private lazy var taskTextField: UITextField = {
        let taskTextField = UITextField()
        taskTextField.translatesAutoresizingMaskIntoConstraints = false
        
        taskTextField.placeholder = "New Task"
        taskTextField.borderStyle = .roundedRect
        
        return taskTextField
    }()
    
    private lazy var saveButton: UIButton = {
        createButton(withTitle: "save",
                     andColor: UIColor(named: "MilkyWay") ?? .blue,
                     action: UIAction { [unowned self] _ in
            save()
        })
    }()
    
    private lazy var cancelButton: UIButton = {
        createButton(withTitle: "Cancel",
                     andColor: UIColor(named: "MilkyRed") ?? .red,
                     action: UIAction { [unowned self] _ in
            dismiss(animated: true )
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(taskTextField)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
        view.backgroundColor = .white
        updateViewConstraints()
        DataStorage.shared.saveContext()
        
    }
    //MARK: BUTTONS METHODS
    private func save()  {
        let task = Task(context: DataStorage.shared.persistentContainer.viewContext)
        task.title = taskTextField.text
        
        if DataStorage.shared.persistentContainer.viewContext.hasChanges {
            do {
                try DataStorage.shared.persistentContainer.viewContext.save()
            }
            catch let error {
                print(error.localizedDescription)
            }
        }
        
        delegate.reloadData()
        dismiss(animated: true)
    }
    //MARK: CONSTRAINTS
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leftAnchor.constraint(equalTo: taskTextField.leftAnchor, constant: 20),
            saveButton.rightAnchor.constraint(equalTo: taskTextField.rightAnchor, constant: -20),
            
            
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leftAnchor.constraint(equalTo: saveButton.leftAnchor),
            cancelButton.rightAnchor.constraint(equalTo: saveButton.rightAnchor),
            
            taskTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            taskTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
    }
    //MARK: - CUSTOM ELEMENTS
    private func createButton(withTitle title: String, andColor color: UIColor, action: UIAction) -> UIButton {
        var attributes = AttributeContainer()
        attributes.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = color
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
        
        let button = UIButton(configuration: buttonConfiguration, primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
}
