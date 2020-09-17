//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Trevor Bursach on 9/16/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    var task: Task?
    var dueDateValue: Date?

    //Outlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = datePicker
        updateViews()
    }
    
    //Actions
    
    @IBAction func userTappedView(_ sender: Any) {
    }
    
    @IBAction func datePickerTapped(_ sender: UIDatePicker) {
        dueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let date = datePicker.date
        guard let name = nameTextField.text,
            let notes = notesTextField.text else { return }
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: date)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: date)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let task = task, isViewLoaded else { return }
        nameTextField.text = task.name
        notesTextField.text = task.notes
        dueTextField.text = task.due?.stringValue()
    }

  } // END OF CLASS
