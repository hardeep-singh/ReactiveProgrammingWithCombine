//: [Previous](@previous)

import Foundation

/*: ### subscribe(on:) and  receive(on:)
 
 This code will not work because they have dependancy on another code.*/

//let currentThread = Thread.current.number
//print("Start computation publisher on thread \(currentThread)")
//let computationPublisher = Publishers.ExpensiveComputation(duration: 3)
//let queue = DispatchQueue(label: "serial queue")
//
//let subscription = computationPublisher
//  .subscribe(on: queue)
//  .receive(on: DispatchQueue.main)
//  .sink { value in
//    let thread = Thread.current.number
//    print("Received computation result on thread \(thread): '\(value)'")
//  }
//: [Next](@next)
