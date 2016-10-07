//
//  CalculatorBrain.swift
//  calculator1
//
//  Created by Mohnish Basha Shaikh on 10/6/16.
//  Copyright © 2016 Mohnish Basha Shaikh. All rights reserved.
//  // (ops:[Op]) ythis is argument of func it is stack of ops as an argument
// arrays and dictionaries are not classes in Swift they are structs
// class can have inheriance  struct can not struct pass by value and class pass by referernce struct in swift look alike like classes they have func,properties, storage they are identical to class.
// mutable and immutable ???
// _ underbar in swift is universal means i dont care about


import Foundation
class CalculatorBrain
{
    //var opStack = Array<op>()
    private enum Op
    {
        case operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double,Double) -> Double)
    }
    private var opStack = [Op]()//()-> this is initilizer.
    
   //var knownOps = Dictionary < String, Op>() way to define dictionary
    private var knownOp = [ String:Op]()
    
    init(){
    //knownOp["✕"] = Op.BinaryOperation("✕", <#T##(Double, Double) -> Double#>)// we dont need to write it again
    //KnownOp["✕"] = Op.BinaryOperation("✕"){ $0 * $1 } we can write it into another way as all the operator are trated  in swift as func same way we can do it  for + and sqrt we cant do it with - and / coz their order is backword i.e. $1/$0
        knownOp["✕"] = Op.BinaryOperation("✕", *)
        knownOp["⌹"] = Op.BinaryOperation("⌹"){ $1 / $0 }
        knownOp["+"] = Op.BinaryOperation("+",+)
        //knownOp["+"] = Op.BinaryOperation("+"){ $0 + $1 }
        knownOp["−"] = Op.BinaryOperation("−"){ $1 - $0 }
        //knownOp["√"] = Op.UnaryOperation("√"){ sqrt($0) }
        knownOp["√"] = Op.UnaryOperation("√", sqrt)
    }
    private func evalaute(ops: [Op]) -> (result: Double?, remainingOps: [Op])
    {
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .operand(let operand):
                return(operand, remainingOps)
                
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evalaute(remainingOps)
                if let operand = operandEvaluation.result {
                return(operation(operand),operandEvaluation.remainingOps)
                }
                
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evalaute(remainingOps)
                 if let operand1 = op1Evaluation.result {
                   let op2Evaluation = evalaute(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                        
                        return(operation(operand1,operand2),op2Evaluation.remainingOps)
                
                    }
                }
                
            default: break
                
             }
        }
        return(nil,ops)
    
    }
    func evaluate() -> Double?//? -> optional
    {
    let (result, ramainder) = evalaute(opStack)
        return result
    }
    
    func pushOperand(operand:Double) -> Double?
    {
        opStack.append(Op.operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String) -> Double?
    {
        if let operation = knownOp[symbol]{
        opStack.append(operation)
    }
    return evaluate()
    }

}