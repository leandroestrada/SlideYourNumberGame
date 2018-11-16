//
//  ViewController.swift
//  acerteONumero3
//
//  Created by MacMac on 05/11/18.
//  Copyright © 2018 MacMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue = 0
    var score = 0
    var round = 0
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundNumber: UILabel!
    
    
    @IBAction func startNewGame(){
        score = 0
        round = 0
        startNewRound()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)
        
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
       // print(currentValue)
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 0...100)
        currentValue = Int(slider.value)
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundNumber.text = String(round)
    }

    
    @IBAction func showAlert() {
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        score += points
        round += 1
        
        let title: String
        if difference == 0{
            title = "Perfect"
            points += 100
        }
        else if difference < 5{
            title = "You almost had it!"
            points += 50
        }
        else if difference < 10{
            title = "Pretty good!"
        }
        else{
            title = "Not even close..."
        }
        
        
        let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nThe difference is: \(difference) \nYou scored \(points) points"
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Allright!", style: .default, handler: { _ in self.startNewRound() })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        //startNewRound()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighLighted = UIImage(named: "SliderThumb-Highlighted")!
        
        slider.setThumbImage(thumbImageHighLighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        //startNewRound()  
        
        
        //  updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

