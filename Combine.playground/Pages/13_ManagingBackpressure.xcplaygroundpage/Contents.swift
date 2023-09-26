//: [Previous](@previous)

import Combine
import Foundation


example(of: "Managing-backpressure") {
    
    final class IntSubscriber: Subscriber {
        
        typealias Input = Int
        
        typealias Failure = Never
        
        func receive(subscription: Subscription) {
            print("Received subscription")
            subscription.request(.max(2))
        }
        
        func receive(_ input: Int) -> Subscribers.Demand {
            print("Received value", input)
            switch input {
            case 1:
              return .max(2)
            case 3:
              return .max(1)
            default:
              return .none
            }
        }
        
        func receive(completion: Subscribers.Completion<Never>) {
            print("Received completion", completion)
        }
        
    }
    
    
    let subscriber = IntSubscriber()
    
    let subject = PassthroughSubject<Int, Never>()
    
    subject
       // .print()
        .subscribe(subscriber)
    
    subject.send(1)
    subject.send(2)
    subject.send(3)
    subject.send(4)
    subject.send(5)
    subject.send(6)


    
}
