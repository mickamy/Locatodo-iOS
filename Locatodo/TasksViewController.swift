//
//  TasksViewController.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/22/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import UIKit
import RxSwift

final class TasksViewController: UIViewController {
    
    private let viewModel: TasksViewModel = TasksViewModel(TaskRepository.instance)
    
    private let bag: DisposeBag = DisposeBag()
    
    private let cellID = R.reuseIdentifier.taskCell.identifier
    
    @IBOutlet weak var taskTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        viewModel
            .tasks
            .bindTo(taskTable.rx.items(cellIdentifier: cellID)) { (row, task, cell) in
                cell.textLabel?.text = task.id
            }.addDisposableTo(bag)
    }
    
    @IBAction func add(_ sender: AnyObject) {
        createDummy()
    }
    
    private func createDummy() {
        let dummy = TaskCreator.dummy(size: 10)
        TaskRepository
            .instance
            .create(dummy)
            .subscribe {
                switch($0) {
                case .next(_):
                    log.debug("next")
                case .error(let e):
                    log.error("error: \(e)")
                case .completed:
                    log.debug("completed")
                }
            }
            .addDisposableTo(bag)
    }
}
