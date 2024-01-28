//
//  ConnexionViewController.swift
//  EFD
//
//  Created by Gabriel on 1/28/24.
//

import UIKit

class ConnexionViewController: UIViewController {

    @IBOutlet weak var buttonConnexion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        buttonConnexion.layer.cornerRadius = 8.00 // Pour obtenir les coins arrondis
        
        // Configurer le texte du bouton
        buttonConnexion.setTitle("Connexion", for: .normal)
        
        

                
    }


    @IBAction func goToConnexion(_ sender: Any) {
    }
    
    @IBAction func goToInscription(_ sender: Any) {
        let inscriptionViewController = InscriptionViewController()
        self.navigationController?.pushViewController(inscriptionViewController, animated: true)
    }
    
}
