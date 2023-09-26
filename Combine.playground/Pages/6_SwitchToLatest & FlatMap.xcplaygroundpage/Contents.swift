//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "FlatMap") {
    
        let publishers2 = PassthroughSubject<PassthroughSubject<PassthroughSubject<Double, Never>, Never>, Never>()
       //publishers2.sink(receiveValue: <#T##((PassthroughSubject<PassthroughSubject<Double, Never>, Never>) -> Void)##((PassthroughSubject<PassthroughSubject<Double, Never>, Never>) -> Void)##(PassthroughSubject<PassthroughSubject<Double, Never>, Never>) -> Void#>)
       
        publishers2
        .flatMap { $0 }
        .flatMap {$0}
        .sink { value in
            
        }
    
    // After flatMap implement, It is showing nested publisher completion block
            //.sink(receiveValue: <#T##((Double) -> Void)##((Double) -> Void)##(Double) -> Void#>)
    
    
}

example(of: "switchToLatest & FlatMap") {
    let publisher1 = PassthroughSubject<Int, Never>()
    let publisher2 = PassthroughSubject<Int, Never>()
    let publisher3 = PassthroughSubject<Int, Never>()

    let publishers = PassthroughSubject<PassthroughSubject<Int, Never>, Never>()
    
    // With flat map

    
    // With Switch to Latest
//    publishers2
//        .switchToLatest()
//        .switchToLatest()
//        .sink { (value: Double) in
//
//    }
    
    publishers
        .switchToLatest()
        .sink(receiveCompletion: { _ in print("Completed!") },
              receiveValue: { print($0) })
        .store(in: &subscriptions)

    publishers.send(publisher1)
    publisher1.send(1)
    publisher1.send(2)

    publishers.send(publisher2)
    publisher1.send(3)
    publisher2.send(4)
    publisher2.send(5)

    publishers.send(publisher3)
    publisher2.send(6)
    publisher3.send(7)
    publisher3.send(8)
    publisher3.send(9)

    publisher3.send(completion: .finished)
    publishers.send(completion: .finished)
}


//: [Next](@next)
