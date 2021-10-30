//
//  ViewController.swift
//  SwiftSimpleCalculator
//
//  Created by NoobMaster69 on 28/10/2021.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Views
    @IBOutlet weak var displayLabel: UILabel!


    //MARK: Dependencies
    private var calculatorLogic = CalculatorLogic()

    
    //MARK: Vriables
    private var hasFinishedTypingNumber = true
    private var displayValue: Double? {
        get { Double(displayLabel?.text ?? "") }
        set { displayLabel.text = String(newValue ?? 0.0) }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        hasFinishedTypingNumber = true
        calculatorLogic.setAccumelator(displayValue)
        if let op = sender.currentTitle {
            displayValue = calculatorLogic.calculate(operator: op)
        }

    }

    @IBAction func numButtonPressed(_ sender: UIButton) {
        if let newDigit = sender.currentTitle {
            if hasFinishedTypingNumber {
                displayLabel?.text! = newDigit
                hasFinishedTypingNumber = false
            }
            else {
                if newDigit == "." {
                    if let displayValue = displayValue {
                        let isInt = floor(displayValue) == displayValue
                        if !isInt { return }
                    }
                    else { return }
                }

                displayLabel?.text! += newDigit
            }

        }
    }
}

