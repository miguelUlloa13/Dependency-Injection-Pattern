//
//  SelectorViewController.swift
//  Dependency Injection Pattern
//
//  Created by Miguel Angel Bric Ulloa on 03/05/23.
//

import UIKit

class SelectorViewController: UIViewController {
    
    
    @IBOutlet weak var selectorLbl: UILabel!
    @IBOutlet weak var MockProviderBtn: UIButton!
    @IBOutlet weak var EndpointProviderBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectorLbl.text = "Initializer Injection with:"
        
        MockProviderBtn.tag = 0
        MockProviderBtn.setTitle("UsersProviderMock", for: .normal)
        
        EndpointProviderBtn.tag = 1
        EndpointProviderBtn.setTitle("UsersProvider", for: .normal)
    }

    
    @IBAction func openListViewController(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            performSegue(withIdentifier: "MockSegue", sender: self)
            print("Mock")
            
        case 1:
            performSegue(withIdentifier: "EndpointSegue", sender: self)
            print("Endpoint")
            
        default:
            print("No option")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MockSegue" {   // Identificar el segue
            if let destination = segue.destination as? UsersListViewController {
                destination.viewModel = UsersViewModel(provider: UsersProviderMock())
        
            }
            
        } else if segue.identifier == "EndpointSegue" {
            if let destination = segue.destination as? UsersListViewController {
                destination.viewModel = UsersViewModel()
            }
        }
    }
    
}
