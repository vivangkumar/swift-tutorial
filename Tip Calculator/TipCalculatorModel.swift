/*
 *  TipCalculatorModel.swift
 *
 *
 *  @author Vivan Kumar <vivangkumar>
 *  @copyright Vivan, 2014
 */

import Foundation

class TipCalculatorModel {
    
    // Create class properties
    var total: Double
    var taxPercent: Double
    var subTotal: Double {
        get {
            return total / (taxPercent + 1)
        }
    }
    
    // Initialise values
    init(total: Double, taxPercent: Double){
        self.total = total
        self.taxPercent = taxPercent
    }
    
    /**
    * Calculate tips based on percentage
    *
    * @param Double tipPercent Percentage for tips.
    * @return Double
    **/
    
    func calculateTip(tipPercent: Double) -> Double {
        return subTotal * tipPercent
    }
    
    /**
    * Return tips for a number of percentages.
    *
    * @return Dictionary
    **/
    
    func returnPossibleTips() -> [Int: Double] {
        let possibleTips = [0.15, 0.18, 0.20]
        
        var retVal = [Int: Double]()
        for pTips in possibleTips {
            let intPercent = Int(pTips * 100)
            
            retVal[intPercent] = calculateTip(pTips)
        }
        
        return retVal
    }
}




