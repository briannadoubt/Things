
//  SettingsViewController.swift
//  Things
//
//  Created by Brie Heutmaker on 1/13/17.
//  Copyright © 2017 Brie Heutmaker. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var coordinator: Coordinator!
    
    @IBOutlet var loggedInAsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loggedInAsLabel.text = "Logged in as \(AppState.shared.username ?? "SOMEONE 😰 (We don't know)")"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.reuseIdentifier == "LogoutCell" {
            signOut()
        }
    }
    
    func signOut() {
        coordinator.logout() { success in
            
            if success {
                guard let splash = storyboard?.instantiateViewController(withIdentifier: "SplashViewController") else {
                    self.showAlert(withTitle: "Could not find the Splash Screen", message: "It's lost in the sci-fi thought realm somewhere....")
                    return
                }
                
                self.present(splash, animated: true, completion: {
                    let window = UIApplication.shared.windows.first
                    window?.rootViewController?.removeFromParentViewController()
                })
                
            } else {
                showAlert(withTitle: "Can't Logout", message: "Could not logout for whatever reason... Sorry, you're stuck with us! 😹")
            }
        }
    }
    
}