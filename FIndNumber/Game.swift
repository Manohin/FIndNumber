//
//  Game.swift
//  FIndNumber
//
//  Created by Alexey Manokhin on 16.11.2022.
//

import Foundation

enum StatusGame {
    case start
    
    case win
    
    case lose
}



class Game {
    
    struct Item {
        var title: String
        var isFound: Bool = false
        
    }
    
    private let data = Array (1...99) // Массив чисел от 1 до 99
    
     var items: [Item] = [] // Массив с количеством кнопок на экране
    
    var status: StatusGame = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    
    private var timeForGame: Int {
        didSet {
            if timeForGame == 0 {
                status = .lose
            }
            
            updateTimer(status, timeForGame)
            
        }
    }
    
    
    private var timer: Timer?
    
    private var updateTimer:((StatusGame,Int)->Void)
    
    
    init(countItems: Int,
         time: Int,
         updateTimer: @escaping (_ status: StatusGame,_ seconds: Int)-> Void) {
        self.countItems = countItems // Количество кнопок в ините
        self.timeForGame = time
        self.updateTimer = updateTimer
        setupGame()
        
    }
    
    private var countItems: Int // Количество кнопок
    
    var nextItem: Item?
    
    
    
    private func setupGame() {
        var digits = data.shuffled()  // Временный массив для каждой игры, в котором перемешанные цифры из массива data
        
        
        // Пока массив items меньше, чем количество кнопок, создаем новые item
        while items.count < countItems {
            
            var item = Item (title: String(digits.removeFirst()))
            items.append(item)
            
        }
        
        nextItem = items.shuffled().first
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {  [weak self] (_) in
            self?.timeForGame -= 1
        })
    }
    
    func check(index:Int) -> Void {
        
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        
        if nextItem == nil {
            status = .win
        }
        
    }
    
    func stopGame() {
        timer?.invalidate()
    }
    
}
