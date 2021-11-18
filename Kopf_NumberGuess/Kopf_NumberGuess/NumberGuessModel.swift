//
//  NumberGuessModel.swift
//  Kopf_NumberGuess
//
//  Created by Fabian Kopf on 18.11.21.
//

import Foundation

class NumberGuessModel{
    var target = 0
    var guessCount = 0
    
    func compare(to: Int) -> Int {
        return target - to
    }
    
    func isValid(string: String?) -> Bool {
        var isValid = false
        if let str = string, let guess = Int(str) {
            if guess >= 1 && guess <= 99 {
                isValid = true
            }
        }
        return isValid
    }
    
    func getImage() -> String {
        var picture: String = ""
        
        if (guessCount < 6) {
            picture = "happy.png"
        } else if (guessCount < 10) {
            picture = "neutral.png"
        } else {
            picture = "sad.png"
        }
        return picture
    }
}
