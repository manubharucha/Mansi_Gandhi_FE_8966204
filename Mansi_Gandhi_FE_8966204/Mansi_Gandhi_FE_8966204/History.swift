//
//  History.swift
//  Mansi_Gandhi_FE_8966204
//
//  Created by user240208 on 4/10/24.
//

import UIKit
import CoreData

class History: UITableViewController {
    
    var dataSource: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecordsAndProcess(entityType: SaveData.weather.rawValue)
        fetchRecordsAndProcess(entityType: SaveData.news.rawValue)
        fetchRecordsAndProcess(entityType: SaveData.directions.rawValue)
    }
    
    // Here I create methods to specify the number of sections and rows in the table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataObject = dataSource[indexPath.row]
        
        if let drictondata = dataObject as? DirectionsData {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DirectionsTableViewCell", for: indexPath) as? DirectionsTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.setup(data: drictondata)
            return cell
            
        } else if let newsdata = dataObject as? NewsData {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsDataTableViewCell", for: indexPath) as? NewsDataTableViewCell else { return UITableViewCell() }
            cell.setupCell(data: newsdata)
            cell.selectionStyle = .none
            return cell
            
        } else if let weatherdata = dataObject as? WeatherCoreData {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDetailTableViewCell", for: indexPath) as? WeatherDetailTableViewCell else { return UITableViewCell() }
            cell.setup(data: weatherdata)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    //Here, I create a method to fetch records from Core Data
    func fetchRecordsAndProcess(entityType: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityType)
        do {
            let results = try context.fetch(fetchRequest)
            results.forEach { result in
                dataSource.append(result)
            }
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // Here I created a method to handle deleting rows in the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let objectToDelete = dataSource.remove(at: indexPath.row)
            
            let contexts = appDelegate.persistentContainer.viewContext
            contexts.delete(objectToDelete as! NSManagedObject)
            
            do {
                try contexts.save()
            } catch let error as NSError {
                print("Could not save after delete. \(error), \(error.userInfo)")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
