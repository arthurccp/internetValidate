//
//  ViewController.swift
//  InternetValidate
//
//  Created by Arthur Silva on 16/05/22.
//

import UIKit

class ViewController: UIViewController {
        
    let reachability = try! Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi{
                    print("Reachable via WiFi")
                 }else{
                    print("Reachable via Cellular")
                }
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
            self.reachability.whenUnreachable = {_ in
               print ("Not reachable")
                
                if let networkvc = self.storyboard?.instantiateViewController(withIdentifier: "NetErrorViewController") as? NetErrorViewController{
                    self.present(networkvc, animated: true)
                
                }
            }
            do{
                try self.reachability.startNotifier()
            }catch{
               print ("Unable to start notifier")
            }
        }
    }
    
    deinit{
        reachability.stopNotifier()
    }
}

