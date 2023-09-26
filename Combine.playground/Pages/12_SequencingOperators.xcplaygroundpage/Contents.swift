//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

/*: ### min */
example(of: "min") {
  let publisher = [1, -50, 246, 0].publisher

  publisher
    .print("publisher")
    .min()
    .sink(receiveValue: { print("Lowest value is \($0)") })
    .store(in: &subscriptions)
}

/*: ### max */
example(of: "max") {
  let publisher = ["A", "F", "Z", "E"].publisher

  publisher
    .print("publisher")
    .max()
    .sink(receiveValue: { print("Highest value is \($0)") })
    .store(in: &subscriptions)
}

/*: ### count */
example(of: "count") {

  let publisher = ["A", "B", "C"].publisher

  publisher
    .print("publisher")
    .count()
    .sink(receiveValue: { print("I have \($0) items") })
    .store(in: &subscriptions)
}

/*  ### output(at:)
 */
example(of: "output(at:)") {
  let publisher = ["A", "B", "C"].publisher

  publisher
    .print("publisher")
    .output(at: 1)
    .sink(receiveValue: { print("Value at index 1 is \($0)") })
    .store(in: &subscriptions)
}
//: [Next](@next)
