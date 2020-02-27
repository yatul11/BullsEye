//
//  ViewController.swift
//  BullsEye
//
//  Created by Ivan Lutaenko on 9/27/18.
//  Copyright © 2018 Ivan Lutaenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var scoreValue: Int = 0
    var roundCounter: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = Int(slider.value.rounded())
        startNewRound()
        updateLabels()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeable, for: .normal)
    }
    
    @IBAction func showAlert(){
        let previousResult: Int = scoreValue
        countScore()
        
        let alert = UIAlertController(title: "Round Results", message: "The value of the slider is \(String(describing: currentValue))" + " \nYou get \(scoreValue-previousResult) points", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Next Round", style: .default, handler: {action in self.startNewRound()})
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver(){
        let alert = UIAlertController(title: "Congratulations", message: "You have got \(scoreValue) points for \(roundCounter) rounds!", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Restart", style: .default, handler: {action in self.resetGame()})
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = Int(slider.value.rounded());
    }
    
    func startNewRound(){
        roundCounter+=1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue);
        updateLabels()
    }
    
    func updateLabels(){
        randomNumberLabel.text = "\(targetValue)"
        scoreLabel.text = "\(scoreValue)"
        roundLabel.text = "\(roundCounter)"
    }
    
    func countScore(){
        let preResult: Double = Double(abs(targetValue-currentValue))/Double(targetValue)*100
        scoreValue += 100-Int(preResult)
    }
    
    func resetGame(){
        currentValue = 0
        targetValue = Int.random(in: 1...100)
        scoreValue = 0
        roundCounter = 1
        updateLabels()
    }

}

