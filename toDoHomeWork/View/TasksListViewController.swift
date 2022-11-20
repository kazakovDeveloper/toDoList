//
//  TaskListViewController.swift
//  ToDo
//
//  Created by Kazakov Danil on 19.11.2022.
//

import UIKit

protocol TasksViewControllerDelegate {
    func reloadData()
}

class TasksListViewController: UIViewController {
    
    private var tasksList: [Task] = []
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupNavBar()
        fetchData()
    }
    
    func setupNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Задачи"
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(named: "MilkyWay")
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addNewTask))
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
        
    }

    @objc func addNewTask() {
        let newTaskVC = NewTaskViewController()
        newTaskVC.delegate = self
        present(newTaskVC, animated: true)
    }
    
    private func fetchData() {
        var fetchRequest = Task.fetchRequest()
        do {
            tasksList = try DataStorage.shared.persistentContainer.viewContext.fetch(fetchRequest)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier,
                                                       for: indexPath) as? CustomCell else {
                                                       return CustomCell() }
        let task = tasksList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
}
//MARK: - TasksViewControllerDelegate

extension TasksListViewController: TasksViewControllerDelegate {
    func reloadData() {
        fetchData()
        tableView.reloadData()
    }
}

