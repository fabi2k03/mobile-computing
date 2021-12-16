//
//  TableViewController2.swift
//  NumberGuess
//
//  Created by Fabian Kopf on 16.12.21.
//

import UIKit

class TableViewController2: UITableViewController {
    let queue = DispatchQueue(label: "download")
    let path = "https://jsonplaceholder.typicode.com/todos"
    var model = ToDoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: path) {
            //queue.async (execute: () -> self.download(url: url))
            queue.async {
                let todos = self.download(url: url)
                DispatchQueue.main.async {
                    self.model.todos = todos
                    self.tableView.reloadData()
                }
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath)
        let todo = model.todos[indexPath.row]
        cell.textLabel?.text=todo.title
        cell.detailTextLabel?.text="\(todo.id)"
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func download (url : URL) -> [ToDo]{
        print ("downloading \(url)")
        var todos = [ToDo]()
        if let data = try? Data(contentsOf: url){
            let obj = try? JSONSerialization.jsonObject(with: data, options: [])
            if let array = obj as? [[String: Any]]{
                for el in array {
                    let todo = ToDo()
                    if let id = el["id"] as? Int, let title = el["title"] as? String{
                        todo.id = id
                        todo.title = title
                        todos.append(todo)
                        print("id: \(id), title =\(title)")
                    }
                }
            }
        } else {
            print("ka download")
        }
        return todos
    }
}
