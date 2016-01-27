import rcl

private var number: Int = 1

class FakeClient: Client, Equatable, CustomDebugStringConvertible {
    private let hash: Int

    var debugDescription: String {
        return "FakeClient - \(hash)"
    }

    init() {
        self.hash = number
        number += 1
    }

    private(set) var publishCallCount: Int = 0
    private var publishArgs: Array<(String, [UInt8])> = []
    func publishArgsForCall(callIndex: Int) -> (String, [UInt8]) {
        return self.publishArgs[callIndex]
    }
    func publish(topic: String, data: [UInt8]) throws {
        self.publishCallCount += 1
        self.publishArgs.append((topic, data))
    }

    private(set) var subscribeCallCount: Int = 0
    private var subscribeArgs: Array<(String, [UInt8] -> Void)> = []
    func subscribeArgsForCall(callIndex: Int) -> (String, [UInt8] -> Void) {
        return self.subscribeArgs[callIndex]
    }
    func subscribe(topic: String, callback: [UInt8] -> Void) {
        self.subscribeArgsCallCount += 1
        self.subscribeArgs.append((topic, callbakc))
    }

    private(set) var unsubscribeCallCount: Int = 0
    private var unsubscribeArgs: Array<(String)> = []
    func unsubscribeArgsForCall(callIndex: Int) -> (String) {
        return self.unsubscribeArgs[callIndex]
    }
    func unsubscribe(topic: String) {
        self.unsubscribeCallCount += 1
        self.unsubscribeArgs.append(topic)
    }
}

func ==(a: FakeClient, b: FakeClient) -> Bool {
    return a.hash == b.hash
}
