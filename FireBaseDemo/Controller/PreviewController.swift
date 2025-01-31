//
//  PreviewController.swift
//  FireBaseDemo
//
//  Created by Atik Hasan on 1/30/25.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

protocol Datapass : AnyObject {
    func passKeys(Found : Bool)
}

class PreviewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let database = Database.database().reference()
    var dataArray: [(key: String, value: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchKeyAndValue()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        self.tableView.register(TvCell.nib(), forCellReuseIdentifier: TvCell.identifire)
    }
    
    
    func fetchKeyAndValue(){
        database.observeSingleEvent(of: .value) { snapshot in
            DispatchQueue.main.async {
                if snapshot.exists(), let data = snapshot.value as? [String: Any] {
                    self.dataArray.removeAll()
                    
                    for (key, value) in data {
                        if let dict = value as? [String: Any], let name = dict["Name: "] as? String {
                            self.dataArray.append((key, name))
                        }
                    }
                    
                    self.tableView.reloadData()
                } else {
                    self.showAlert(title: "Info", message: "No data found!")
                }
            }
        }
    }
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


extension PreviewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TvCell", for: indexPath) as! TvCell
        cell.selectionStyle = .none
        cell.lblKey.text = "Key" + dataArray[indexPath.row].key
        cell.lblValue.text = "Value" + dataArray[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
