import Foundation

public extension Int {
    static func random(range: CountableClosedRange<Int> ) -> Int {
        var offset = 0
        
        if range.lowerBound < 0 {
            offset = abs(range.lowerBound)
        }
        
        let min = UInt32(range.lowerBound + offset)
        let max = UInt32(range.upperBound + offset)
        
        return Int(min + arc4random_uniform(max - min)) - offset
    }
}
