//: [Previous](@previous)

import Foundation
import Combine

//: # Merge Operator
//: The merge operator merges two or more upstream publishers into a single publisher. Keep in mind that the Output and Failure types of the upstream publishers need to match.

var subscriptions = Set<AnyCancellable>()

example(of: "merge(with:)") {
  let publisher1 = PassthroughSubject<Int, Never>()
  let publisher2 = PassthroughSubject<Int, Never>()

  publisher1
    .merge(with: publisher2)
    .sink(receiveCompletion: { _ in print("Completed") },
          receiveValue: { print($0) })
    .store(in: &subscriptions)

  publisher1.send(1)
  publisher1.send(2)

  publisher2.send(3)

  publisher1.send(4)

  publisher2.send(5)

  publisher1.send(completion: .finished)
  publisher2.send(completion: .finished)
}

//——— Example of: merge(with:) ———
//1
//2
//3
//4
//5
//Completed

//: [Next](@next)
