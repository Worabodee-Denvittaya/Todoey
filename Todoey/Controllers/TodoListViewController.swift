//
//  ViewController.swift
//  Todoey
//
//  Created by Worabodee Denvittaya on 6/18/19.
//  Copyright © 2019 Worabodee Denvittaya. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    //UserDefaults are saved in a plist file so it has to be a value, key

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.title = "First item"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Second item"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Third item"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "todoListArray") as? [Item] {
            itemArray = items
        } // retrieve the saved items from the plist file if they exist
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new todo list item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "todoListArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    


}

