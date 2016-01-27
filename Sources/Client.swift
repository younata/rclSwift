// Temporary abstraction of the Ros MiddleWare, referred to as the client.

public protocol Client {
    func publish(topic: String, data: [UInt8]) throws
    func subscribe(topic: String, callback: [UInt8] -> Void)
    func unsubscribe(topic: String)
}
