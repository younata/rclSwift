import Quick
import Nimble
import rcl

class PublisherSpec: QuickSpec {
    override func spec() {
        let node = Node(name: "test")

        let topic = "testity test test"

        var client: FakeClient!
        var subject: Publisher<FakeMessage>!

        beforeEach {
            client = FakeClient()
            subject = Publisher(node: node, topic: topic, client: client)
        }

        it("calls publish with the serialized data on the client") {
            subject.publish(FakeMessage(bytes: [1,2,3])!)

            expect(client.publishCallCount) == 1
            let args = client.publishArgsForCall(0)
            expect(args.0) == topic
            expect(args.1) == [1,2,3]
        }
    }
}
