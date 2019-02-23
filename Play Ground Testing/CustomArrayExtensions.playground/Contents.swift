import UIKit

// Softball interview question
// function that can sum up a list of numbers

func sum(numbers: [Int]) -> Int {
    // or just ues reduce function
//    return numbers.reduce(0, {$0 + $1})
    
    var total = 0
    numbers.forEach { (num) in
        total += num
    }
    return total
}


sum(numbers: [1,2,3])



extension Array where Element: Numeric {
    func sum() -> Element {
        return self.reduce(0, {$0 + $1})
    }
}

[2,3,4].sum()

extension Array where Element == String {
    func concatenate() -> String {
        return self.reduce("", {$0 + $1 + " "})
    }
}

["hi", "How", "ARE", "You"].concatenate()
