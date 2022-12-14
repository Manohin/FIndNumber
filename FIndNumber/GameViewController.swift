//
//  ViewController.swift
//  FIndNumber
//
//  Created by Alexey Manokhin on 16.11.2022.
//

import UIKit
import AudioToolbox

class GameViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    lazy var game = Game (countItems: buttons.count, time: 30) { [weak self] (status, time) in
        
        guard let self = self else { return }
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        newGameButton.layer.cornerRadius = 12
        newGameButton.isHidden = true
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
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
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) {[weak self] in
                    self?.buttons[index].backgroundColor = .red
                    AudioServicesPlaySystemSound(1521)
                } completion: { [weak self] (_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "???????? ????????????????!"
            statusLabel.textColor = .black
            timerLabel.isHidden = false
        case .win:
            timerLabel.isHidden = true
            statusLabel.text = "???? ????????????????!\n????????: \(String(describing: timerLabel.text!))"
            statusLabel.textColor = .systemGreen
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "???? ??????????????????!"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
            timerLabel.isHidden = true
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
}

