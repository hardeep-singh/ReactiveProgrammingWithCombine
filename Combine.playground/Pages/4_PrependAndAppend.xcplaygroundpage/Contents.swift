//: [Previous](@previous)
//: # Combining Operators
import Foundation
import Combine


//: # Prepend Operator
//: #### Allows you to add elements before the sequence.
//: #### The first publisher must send a completion event, so the operator knows when to start prepending values. See Example:- example(of: "prepend(publisher) #2")
var subscriptions = Set<AnyCancellable>()

example(of: "prepend(Output)") {
    let publisher = [8,9].publisher

    publisher
        .prepend([6,7])
        .prepend(Set(4...5))
        .prepend(stride(from: 2, to: 4, by: 1))
        .prepend(0, 1)
        .prepend(-1)
        .sink { value in
            print("Value: \(value)")
        }.store(in: &subscriptions)
}

example(of: "prepend(publisher)") {

    let publisher1 = [3,4].publisher
    let publisher2 = [1,2].publisher

    publisher1
        .prepend(publisher2)
        .sink { value in
        print("publisher1.prepend(publisher2) \(value)")
    }.store(in: &subscriptions)

}

example(of: "prepend(publisher) #2") {
    let publisher1 = [3,4].publisher
    let publisher2 = PassthroughSubject<Int, Never>()

    publisher1
        .prepend(publisher2)
        .sink { value in
            print(value)
        }
        .store(in: &subscriptions)


    publisher2.send(1)
    publisher2.send(2)
    publisher2.send(completion: .finished) // need to send indication publisher2 has done.

}


//: # Append Operator
//: #### The appending family of operators work in an opposite manner to the prepend operators
//: ### Note:- The first publisher must send a completion event, so the operator knows when to start appending values, Ex:- example(of: "append(Output...) #2")

example(of: "Append") {
    let publisher = [1,2].publisher

    publisher
        .append([3,4])
        .append(Set(5...6))
        .append(stride(from: 7, to: 9, by: 1))
        .append(9, 10)
        .append(11)
        .sink { value in
            print("Value: \(value)")
        }.store(in: &subscriptions)
}

example(of: "append(Publisher)") {
  let publisher1 = [1, 2].publisher
  let publisher2 = [3, 4].publisher

  publisher1
    .append(publisher2)
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)
}

example(of: "append(Output...) #2") {
  let publisher = PassthroughSubject<Int, Never>()

  publisher
    .append(3, 4)
    .append(5)
    .sink(receiveValue: { print($0) })
    .store(in: &subscriptions)

  publisher.send(1)
  publisher.send(2)
  publisher.send(completion: .finished)
}
//: [Next](@next)
