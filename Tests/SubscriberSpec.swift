import Quick
import Nimble
import rcl

class PublisherSpec: QuickSpec {
    override func spec() {
        let node = Node(name: "test")

        let topic = "testity test test"

        var client: FakeClient!
        var subject: Subscriber<FakeMessage>!

        beforeEach {
            client = FakeClient()
            subject = Subscriber(node: node, topic: topic, client: client)
        }

        describe("calling listen") {
            var receivedMessages: [FakeMessage]
            var receivedErrors: [SubcriberError]
            beforeEach {
                receivedMessages = []
                receivedErrors = []

                subject.listen({
                    receivedMessages.append($0)
                }) { error in
                    receivedErrors.append($0)
                }
            }

            it("asks the client to inform it of any messages to that topic") {
                expect(client.subscribeCallCount) == 1
                let args = client.subscribeArgsForCall(0)
                expect(args.0) == topic
            }

            context("when the client gets a message for that topic with valid data") {
                beforeEach {
                    let args = client.subscribeArgsForCall(0)
                    args.1([1,2,3])
                }

                it("calls the initial callback with the serialized message") {
                    expect(receivedMessages.first!) == FakeMessage(bytes: [1,2,3])!
                }
            }

            context("when the client gets a message for that topic with invalid data") {
                beforeEach {
                    let args = client.subscribeArgsForCall(0)
                    args.1([])
                }

                it("calls the error callback with the appropriate error") {
                    expect(receivedErrors.first!) == SubscriberError.UnableToDeserialize
                }
            }

            it("informs the client of any intent to stop listening") {
                subject.stopListening()

                expect(client.unsubscribeCallCount) == 1
                expect(client.unsubscribeArgsForCall(0)) == topic
            }
        }
    }
}

