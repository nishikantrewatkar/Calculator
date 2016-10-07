//
//  ViewController.swift
//  calculator1
//
//  Created by Mohnish Basha Shaikh on 10/5/16.
//  Copyright © 2016 Mohnish Basha Shaikh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    var b = false
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton)
    {
        let digit = sender.currentTitle!
        if b {
        display.text = display.text! + digit
        }
        else{
        
            display.text = digit
            b = true
        }
        
    }
    
    @IBAction func operate(sender: UIButton) {
    
    if let operation = sender.currentTitle
    {
        if let result = brain.performOperation(operation)
        {
        displayValue = result
        }
        else{
        displayValue = 0
        
        }
        
        }
   //     switch operation {
//        case "✕": performOperation {$0 * $1}
//            
//        case "⌹": performOperation {$1 / $0}
//        case "+": performOperation {$0 + $1}
//        case "−": performOperation {$1 - $0}
//        case "√": perforOperation {sqrt ($0)}
//        default: break
            
    //    }
        
     }
    
    
//    func performOperation(operation:(Double,Double) -> Double)
//    {
//        if oprandStack.count >= 2{
//            displayValue = operation(oprandStack.removeLast(), oprandStack.removeLast())
//            enter()
//        }
//    }
//
//    
//    func perforOperation(operation: Double -> Double)
//    {
//        if oprandStack.count >= 1{
//            displayValue = operation(oprandStack.removeLast())
//            enter()
//        }
//    }
//    
    
    
   // var oprandStack  = Array<Double>()
    @IBAction func enter() {
        b = false
        if let result = brain.pushOperand(displayValue){
//        oprandStack.append(displayValue)
//        print ("oprandStack = \(oprandStack)")
            displayValue = result
        }
    
    else{
    
    displayValue = 0
    }
    }
    var displayValue :Double{
    
        get{
        return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
        display.text = "\(newValue)"
            b = false
        }
    }
}

