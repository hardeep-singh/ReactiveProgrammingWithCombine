//: [Previous](@previous)

import Foundation
import Combine



// This will return the value when both send value..

var subscriptions = Set<AnyCancellable>()

example(of: "zip") {
  let publisher1 = PassthroughSubject<Int, Never>()
  let publisher2 = PassthroughSubject<String, Never>()

  publisher1
    .zip(publisher2)
    .sink(receiveCompletion: { _ in print("Completed") },
          receiveValue: { print("P1: \($0), P2: \($1)") })
    .store(in: &subscriptions)

  publisher1.send(1)
  publisher1.send(2)

  publisher2.send("a")
  publisher2.send("b")

  publisher1.send(3)

  publisher2.send("c")
  publisher2.send("d")

  publisher1.send(completion: .finished)
  publisher2.send(completion: .finished)
}

//——— Example of: zip ———
//P1: 1, P2: a
//P1: 2, P2: b
//P1: 3, P2: c
//Completed
//: [Next](@next)
