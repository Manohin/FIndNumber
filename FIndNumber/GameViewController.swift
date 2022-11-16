//
//  ViewController.swift
//  FIndNumber
//
//  Created by Alexey Manokhin on 16.11.2022.
//

import UIKit



class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
   lazy var game = Game (countItems: buttons.count)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }

    @IBAction func pressButton(_ sender: UIButton) {
        
        
       
        
        
    }
    
    private func setupScreen() -> Void {
        
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        
    }
    
    
    
}

