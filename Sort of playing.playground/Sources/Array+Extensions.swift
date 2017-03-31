import Foundation

public extension Array where Element: Comparable {
    
    mutating func bubble(_ order: (Element, Element) -> Bool, swaping onSwap: (Element, Element) -> (), comparing onCompare: (Element, Element) -> ()) -> [Element] {
        var counter = -1
        var iterations: Int = 0
        repeat {
            counter = 0
            let times = self.count - (iterations + 1)
            for x in 0..<times {
                onCompare(self[x + 1], self[x])
                if order(self[x + 1], self[x]) {
                    onSwap(self[x + 1], self[x])
                    counter += 1
                    swap(&self[x], &self[x + 1])
                }
            }
            iterations += 1
        } while counter != 0
        
        return self
    }
    
    
}

//func bubbleRecursive<T: Comparable>(_ order: (T, T) -> Bool, list: inout [T], n: Int, onSwap: @escaping (T, T) -> ()) {
//    if n == 1 {
//        return
//    }
//    
//    for i in 0..<n-1 {
//        if order(list[i], list[i+1]) {
//            let next = {
//                onSwap(list[i], list[i+1])
//            }
//            swap(&list[i], &list[i+1])
//        }
//    }
//    
//    bubbleRecursive(order, list: list, n: n-1, onSwap, next)
//}
