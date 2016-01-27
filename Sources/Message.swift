public protocol Message {
    func serialize() -> [UInt8]
    init?(bytes: [UInt8])
}

