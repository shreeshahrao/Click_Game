//
//  AddNameViewController.swift
//  Demo
//
//  Created by Shreesha Rao on 30/12/21.
//

import UIKit
import CoreData

class AddNameViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   // var playerInfo:[PlayerInfo]?
    
    var playerName: String = "Unknown"
    var finalPoint: Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let name = nameTextField.text {
            playerName = name
            
        }
        finalPoint = gamePoint
        let playerInfo = PlayerInfo(context: self.context)
        playerInfo.name = playerName
        playerInfo.point = finalPoint
        do {
            try self.context.save()
        }
        catch {
            print("Error While Saving Data")
        }
        print("Data Saved")
        dismiss(animated: true, completion: nil)
    }
    
   
}
