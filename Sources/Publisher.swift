public final class Publisher<T: Message> {
    public let node: Node
    public let topic: String
    public let client: Client

    public init(node: Node, topic: String, client: Client) {
        self.node = node
        self.topic = topic
        self.client = client
    }

    public func publish(message: T) throws {
        try self.client.publish(topic, data: message.serialize())
    }
}
