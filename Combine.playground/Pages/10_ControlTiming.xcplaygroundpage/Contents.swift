//: [Previous](@previous)

import Foundation
import Combine
var subscriptions = Set<AnyCancellable>()

//: # Controlling Timing
//: ## THROTTLE
/*: A publisher that emits either the most-recent or first element received during the specified interval.
 On specified interval you want received data, To solve the too many and fast response.
 Example:- locationUpdate return too many location in one sec. but you want only one location for a second. then we will use throttle.
 */
example(of: "throttle") {
    let cancellable = Timer.publish(every: 1.0, on: .main, in: .default)
        .autoconnect()
        .print("\(Date().description)")
        .throttle(for: 5.0, scheduler: RunLoop.main, latest: true)
        .sink(
            receiveCompletion: { print ("Completion: \($0).") },
            receiveValue: { print(" Received Timestamp \($0).") }
        )
}
/*: # Delay
- Delays delivery of all output to the downstream receiver by a specified amount of time
- Example:- Simple Delay to handle the request. | old method, perfromAfter(seconds: 5.0)
*/
example(of: "delay") {
    let df = DateFormatter()
    df.dateStyle = .none
    df.timeStyle = .long
    Timer.publish(every: 1.0, on: .main, in: .default)
        .autoconnect()
        .handleEvents(receiveOutput: { date in
            print ("Sending Timestamp \'\(df.string(from: date))\' to delay()")
        })
        .delay(for: .seconds(5), scheduler: RunLoop.main, options: .none)
        .sink(
            receiveCompletion: { print ("completion: \($0)", terminator: "\n") },
            receiveValue: { value in
                let now = Date()
                print ("At \(df.string(from: now)) Received  Timestamp \'\(df.string(from: value))\' sent: \(String(format: "%.2f", now.timeIntervalSince(value))) secs ago", terminator: "\n")
            }
        ).store(in: &subscriptions)
}


//: ## Debounce
/*: Publishes elements only after a specified time interval elapses between events.
  Best example SearchBar when we want api hit after stop typing after 0.5 second. It will only response after on stop and after 0.5 seconds.
 */

example(of: "debounce") {
    let bounces:[(Int,TimeInterval)] = [
        (0, 0),
        (1, 0.25),  // 0.25s interval since last index
        (2, 1),     // 0.75s interval since last index
        (3, 1.25),  // 0.25s interval since last index
        (4, 1.5),   // 0.25s interval since last index
        (5, 2)      // 0.5s interval since last index
    ]


    let subject = PassthroughSubject<Int, Never>()
    subject
        .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
        .sink { index in
            print ("Received index \(index)")
        }.store(in: &subscriptions)


    for bounce in bounces {
        DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
            subject.send(bounce.0)
        }
    }
}

//——— Example of: debounce ———
//Received index 1
//Received index 4
//Received index 5



/*: # Timeout
 - Terminates publishing if the upstream publisher exceeds the specified time interval without producing an element.
 - A publisher that terminates if the specified interval elapses with no events received from the upstream publisher.
 - If customError is nil, the publisher completes normally; Otherwise it will completion with error on provide error.
*/


example(of: "Timeout") {

    var WAIT_TIME : Int = 2
    var TIMEOUT_TIME : Int = 5

    struct TestError: Error {}

    let subject = PassthroughSubject<String, Error>()
    let cancellable = subject
        .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main, options: nil, customError: {
            return TestError()
        })
        .sink(
            receiveCompletion: { print ("completion: \($0) at \(Date())") },
            receiveValue: { print ("value: \($0) at \(Date())") }
        )


    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(WAIT_TIME),
                                  execute: { subject.send("Some data - sent after a delay of \(WAIT_TIME) seconds") } )

}

/*: # MeasureInterval
 - Measures and emits the time interval between events received from an upstream publisher.
*/

example(of: "MeasureInterval") {
    Timer.publish(every: 1.5, on: .main, in: .default)
        .autoconnect()
        .measureInterval(using: RunLoop.main)
        .sink { print("\($0)", terminator: "\n") }
        .store(in: &subscriptions)
}


//: [Next](@next)
