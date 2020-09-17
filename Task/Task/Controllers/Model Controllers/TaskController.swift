//
//  TaskController.swift
//  Task
//
//  Created by Trevor Bursach on 9/16/20.
//  Copyright © 2020 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
//    var tasks: [Task] = []
//
//    var mockTasks: [Task] {
//        let task1 = Task(name: "Test", notes: "Note", due: Date())
//        let task2 = Task(name: "Practice", notes: "Notes", due: Date())
//        let task3 = Task(name: "Testing", notes: "Notes", due: Date())
//        return [task1, task2, task3]
//    }
//    init() {
//        tasks = fetchTasks()
//    }
    
    var fetchedResultsController: NSFetchedResultsController<Task>
    
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let resultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        fetchedResultsController = resultsController
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    // CRUD Functions
    func add(taskWithName: String, notes: String, due: Date) {
        _ = Task(name: taskWithName, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String, due: Date) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        if let moc = task.managedObjectContext {
            moc.delete(task)
            saveToPersistentStore()
        }
    }
    
    // Helper Functions
//    func fetchTasks() -> [Task] {
//        return mockTasks
//    }
    
    func togglesCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch let error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
} // END OF CLASS
