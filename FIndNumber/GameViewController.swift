//
//  ViewController.swift
//  FIndNumber
//
//  Created by Alexey Manokhin on 16.11.2022.
//

import UIKit



class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    lazy var game = Game (countItems: buttons.count)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        
    }

    @IBAction func pressButton(_ sender: UIButton) {
        
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        
        updateUI()
    }
    
    private func setupScreen() -> Void {
        
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        nextDigit.text = game.nextItem?.title
        
        
    }
    
    private func updateUI() {
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        }
        nextDigit.text = game.nextItem?.title
        
        if game.status == .win {
            statusLabel.text = "Вы выиграли! 🙀"
            statusLabel.textColor = .systemGreen
        }
    }
}

