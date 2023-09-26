import UIKit
import Combine

var subscriptions = Set<AnyCancellable>()


//: NotificationCenter
example(of: "NotificationCenter") {
    let notificationName = Notification.Name("NOTIFICATION_NAME")

    let publisher = NotificationCenter.default.publisher(for: notificationName, object: nil)

    let subscription = publisher.sink { value in
        print("Notification received from a pulisher!");
    }

    NotificationCenter.default.post(name: notificationName, object: nil)
    subscription.cancel()
}


//: JUST publisher
example(of: "Just") {
  // 1
  let just = Just("Hello world!")

  // 2
  _ = just
    .sink(
      receiveCompletion: {
        print("Received completion", $0)
      },
      receiveValue: {
        print("Received value", $0)
    })
}



//:- ### compactMap Operator
example(of: "compactMap") {
    let numbers = ["hardeep", nil, "Singh"]
    let cancellable = numbers.publisher
        .compactMap { $0 } // remove nil value
        .collect() // make an array..
        .sink { print("compactMap:- \($0)") }
}

//:  TIMER
example(of: "Timer") {
    let subscription =  Timer.publish(every: 0.1, on: .main, in: .common)
        .autoconnect()
        //.print("SStream")
        .throttle(for: 1, scheduler: RunLoop.main, latest: true)
        .scan(0, { oldValue, _ in
            return oldValue + 1
        })
        .filter({ $0 > 1 && $0 < 15})
        .sink { output in
            print("Finished stream with \(output)")
        } receiveValue: { value in
            print("Receive value \(value)")
        }

    RunLoop.main.schedule(after: .init(Date(timeIntervalSinceNow: 5))) {
        print("--cancel subscription")
        subscription.cancel()
    }
}


//: [Next](@next)
