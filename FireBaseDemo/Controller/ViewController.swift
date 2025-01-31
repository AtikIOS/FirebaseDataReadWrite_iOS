//
//  ViewController.swift
//  FireBaseDemo
//
//  Created by Atik Hasan on 1/30/25.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var textKeyView: UITextField!
    @IBOutlet weak var textValueView: UITextView!
    
    
    // MARK: - Properties
    var DataArray : [String] = []
    private let database = Database.database().reference()
    
    // MARK: - Controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllKeys()
    }

    // MARK: - Button Action
    @IBAction func btnAddDataAction(_ : UIButton) {
        guard let key = textKeyView.text else { return }
        guard let text = textValueView.text else { return }
        
        let dataArray: [String: Any] = [ "Name: " : text as NSObject ]
        
        if foundKeys(key: key){
            database.child(key).setValue(dataArray)
            self.textValueView.text = nil
            self.textKeyView.text = nil
            let vc = storyboard?.instantiateViewController(identifier: "PreviewController") as! PreviewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            print("Keys all ready exist")
        }
    }
    
    // MARK: - Private methods
    private func fetchAllKeys() {
        database.observeSingleEvent(of: .value) { snapshot in
            DispatchQueue.main.async {
                if snapshot.exists(), let data = snapshot.value as? [String: Any] {
                    let keys = Array(data.keys)
                    self.DataArray = keys
                } else {
                    self.showAlert(title: "Info", message: "Keys already exist!")
                    print("No data found")
                }
            }
        }
    }

    
    private func foundKeys(key : String) ->Bool{
        for keyData in DataArray {
            if keyData == key {
                print("key : \(keyData)")
                return false
            }
        }
        return true
    }
    
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}



