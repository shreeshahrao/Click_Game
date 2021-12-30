//
//  LeaderBordViewController.swift
//  Demo
//
//  Created by Shreesha Rao on 30/12/21.
//

import UIKit
import CoreData

class LeaderBordViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var playerInfo:[PlayerInfo]?
  
    @IBOutlet weak var leaderBordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaderBordTableView.delegate = self
        leaderBordTableView.dataSource = self
        fetchPlayerInfo()
       
    }
    
    func fetchPlayerInfo() {
        do {
            self.playerInfo = try context.fetch(PlayerInfo.fetchRequest())
            playerInfo = self.playerInfo?.sorted(by: { $0.point > $1.point })
            DispatchQueue.main.async {
                self.leaderBordTableView.reloadData()
            }
        }
        catch {
            print("Error While Retreving Data")
        }
    }

    @IBAction func goBackTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension LeaderBordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playerInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaderBordTableViewCell
       
        let player = playerInfo![indexPath.row]
        cell.leaderName.text = player.name
        cell.leaderPoint.text = "\(player.point)"
        print(player)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action , view , completionHandler) in
            
            let  playerToRemove = self.playerInfo![indexPath.row]
            
            self.context.delete(playerToRemove)
            
            do {
                try self.context.save()
            }
            catch {
                print("Error While Deleting Data")
            }
            
            self.fetchPlayerInfo()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
    
}


