import rcl

class FakeMessage: Message, Equatable, CustomDebugStringConvertible {
    let bytes: [UInt8]

    var debugDescription: String {
        return "FakeMessage - \(bytes)"
    }

    init?(bytes: [UInt8]) {
        guard !bytes.isEmpty else {
            return nil
        }
        self.bytes = bytes
    }

    func serialize() -> [UInt8] {
        return self.bytes
    }
}

func ==(a: FakeMessage, b: FakeMessage) -> Bool {
    return a.bytes == b.bytes
}

