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
}



class Game {
    
    struct Item {
        var title: String
        var isFound: Bool = false
        
    }
    
    private let data = Array (1...99) // Массив чисел от 1 до 99
    
     var items: [Item] = [] // Массив с количеством кнопок на экране
    
    var status: StatusGame = .start
    
    private var countItems: Int // Количество кнопок
    
    var nextItem: Item?
    
    init(countItems: Int) {
        self.countItems = countItems // Количество кнопок в ините
        setupGame()
        
    }
    
    private func setupGame() {
        var digits = data.shuffled()  // Временный массив для каждой игры, в котором перемешанные цифры из массива data
        
        
        // Пока массив items меньше, чем количество кнопок, создаем новые item
        while items.count < countItems {
            
            var item = Item (title: String(digits.removeFirst()))
            items.append(item)
            
        }
        
        nextItem = items.shuffled().first
        
        
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
    
}
