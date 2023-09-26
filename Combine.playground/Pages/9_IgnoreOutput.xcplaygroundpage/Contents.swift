//: [Previous](@previous)

import Foundation
import Combine

//: # Reducing Elements
//: ## ignoreOutput
//: It will Ignores all upstream elements, But passes along the upstream publisher’s completion state (finished or failed).

struct NoZeroValuesAllowedError: Error {}

let numbers = [1, 2, 3, 4, 5, 0, 6, 7, 8, 9]

let cancellable = numbers.publisher
    .tryFilter({ anInt in
        //guard anInt != 0 else { throw NoZeroValuesAllowedError() }
        return anInt < 20
    })
    .ignoreOutput()
    .sink(receiveCompletion: { print("completion: \($0)") },
          receiveValue: {print("value \($0)")})

//:Output:- completion: finished

//: [Next](@next)
