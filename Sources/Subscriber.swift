public enum SubscriberError {
    case UnableToDeserialize
    case Unknown
}

public final class Subscriber<T: Message> {
    public let node: Node
    public let topic: String
    public let client: Client

    public init(node: Node, topic: String, client: Client) {
        self.node = node
        self.topic = topic
        self.client = client
    }

    public func listen(callback: T -> Void, error: SubscriberError -> Void) {
        self.client.subscribe(self.topic) { data in
            if let message = T(bytes: data) {
                callback(message)
            } else {
                error(.UnableToDeserialize)
            }
        }
    }

    public func stopListening() {
        self.client.unsubscribe(self.topic)
    }
}
