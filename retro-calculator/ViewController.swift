//
//  ViewController.swift
//  retro-calculator
//
//  Created by admin on 4/20/16.
//  Copyright © 2016 bentalarico. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }

    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    var clear = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL (fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }  catch let err as NSError {
            
            print(err.debugDescription)
        }
    
    }

    @IBAction func numberPressed(btn: UIButton!){
        btnSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
        
    }
    
    @IBAction func onDividePressed(sender:AnyObject){
        processOperation(Operation.Divide)
        
    }
    
    @IBAction func onMultiplyPressed(sender:AnyObject){
        processOperation(Operation.Multiply)
        
    }
    
    @IBAction func onAddPressed(sender:AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender:AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onEqualPressed(sender:AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender:AnyObject) {
    
        outputLbl.text = "0"
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        currentOperation = Operation.Empty
        result = ""
        
        
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // Run Some Math
            // A user selected an Operator, but then selected another
            // number without first entering a number
            if runningNumber != "" {
            rightValStr = runningNumber
            runningNumber = ""
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            
            }
            
            leftValStr = result
            outputLbl.text = result
        }
        
        currentOperation = op
            
    } else {
        // This is the first time the Operator has been pressed
        leftValStr = runningNumber
        runningNumber = ""
        currentOperation = op
            
        }
    }
    
    func playSound() {
        if btnSound.playing {
           btnSound.stop()
        }
        
        btnSound.play()
    }
}

