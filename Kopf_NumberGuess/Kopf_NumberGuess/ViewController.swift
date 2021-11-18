//
//  ViewController.swift
//  Kopf_NumberGuess
//
//  Created by Fabian Kopf on 18.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var EdtGuess: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var onClick: UIButton!
    var model = NumberGuessModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.target = Int.random(in: 0...100)
        print(model.target)
        label.text = ""
        label.textAlignment = NSTextAlignment.center
        onClick.setTitle("Guess", for: .normal)
    }

    
    
    @IBAction func EdtOnChangeText(_ sender: UITextView) {
        print("text changed: \(sender.text)")
        onClick.isEnabled = model.isValid(string: sender.text)
    }
    
    @IBAction func onClickFunction(_ sender: Any) {
        print(model.target)
        model.guessCount += 1
        if model.isValid(string: EdtGuess.text) {
            let compare = model.compare(to: Int(EdtGuess.text!)!)
            
            if (compare > 0) {
                label.text = "Zu niedrig!"
            } else if (compare < 0) {
                label.text = "Zu hoch"
            } else {
                label.text = ("\(model.guessCount) Versuche")
                let imgName: String = model.getImage()
                image.image = UIImage(named: imgName)
                image.isHidden = false
            }
        }
    }
}

