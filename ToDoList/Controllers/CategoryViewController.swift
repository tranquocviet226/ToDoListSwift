//
//  CategoryViewController.swift
//  ToDoList
//
//  Created by MacOS on 8/3/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadCategories()
    }
    
    //MARK - TableView Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categories?[indexPath.row]
        cell.textLabel?.text = item?.name ?? "No category added"

        return cell
    }
    //MARK - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.saveCategories(category: newCategory)
        }
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategories(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        categories = realm.objects(Category.self)
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print(error)
//        }
//
//        tableView.reloadData()
    }
}
