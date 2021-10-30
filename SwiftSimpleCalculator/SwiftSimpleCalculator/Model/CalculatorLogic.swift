//
//  CalculatorLogic.swift
//  SwiftSimpleCalculator
//
//  Created by NoobMaster69 on 30/10/2021.
//

import Foundation

struct CalculatorLogic {
    private var accumelator: Double?
    private var intermediateCalculation: (n: Double, op: String)?

    mutating func calculate(operator op: String) -> Double? {

        if let accumelator = accumelator {
            switch op {
            case "+/-": return accumelator * -1
            case "AC": return 0
            case "%": return accumelator * 0.01
            case "=": return performTwoNumbersCalculation(accumelator, intermediateCalculation?.n, intermediateCalculation?.op)
            default: intermediateCalculation = (n: accumelator, op: op)
            }
        }
        return nil
    }
    mutating func setAccumelator(_ newValue: Double?) {
        accumelator = newValue
    }
    private func performTwoNumbersCalculation(_ first: Double, _ second: Double?, _ operation: String?) -> Double? {
        if let operation = operation, let second = second {
            switch operation {
            case "+": return first + second
            case "-": return first - second
            case "Ⅹ": return first * second
            case "÷": return first / second
            default : return nil
            }
        }
        return nil
    }
}
