//: [Previous](@previous)

import Foundation
import Combine

//: SCAN VS REDUCE
//:- ### Scan Operator
example(of: "Scan Operator") {
    let publisher = (1...10).publisher
    // scan's 1st argument is the initial result
    // closure's 1st argument is the nextResult
    // closure's 2nd argument is the values
    // closure's return type is the result
    publisher.scan(0) { previousValue, value -> Int in
        print("previusValue: \(previousValue) + NextValue\(value)")
        return previousValue + value  // appending item to the array
    }
        .sink { value in
        print(value) // Result:-  1,3,6,10,15,21,28,36,45,55
    }
}

//:- ### Reduce Operator
example(of: "Reduce") {
    let numbers = (1...10)
    let cancellable = numbers.publisher
        .reduce(0, { accum, next in accum + next })
        .sink { print("Reduce:- \($0)") } // Reduce:- 55
}


//: [Next](@next)
