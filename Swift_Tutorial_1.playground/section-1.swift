/**
 * Just checking out Swift.
 * @author Vivan
 *
 **/

class calculator {
    // Create class properties
    var total: Double
    var taxPercent: Double
    var subTotal: Double
    
    // Initialise values
    init(total: Double, taxPercent: Double){
        self.total = total
        self.taxPercent = taxPercent
        subTotal = total / (taxPercent + 1)
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

let tipCalculate = calculator(total: 100.25, taxPercent: 0.05)
tipCalculate.returnPossibleTips()


