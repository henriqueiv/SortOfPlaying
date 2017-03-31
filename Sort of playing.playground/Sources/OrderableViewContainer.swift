
import Foundation
import UIKit

public struct OrderableViewContainer<T: Comparable> {
    let view: UIView
    let value: T
    
    public init(view: UIView, value: T) {
        self.view = view
        self.value = value
    }
    
    public func getView() -> UIView {
        return self.view
    }
    
    public func getValue() -> T {
        return value
    }
}

extension OrderableViewContainer: Comparable { }
public func ==<T>(view1: OrderableViewContainer<T>, view2: OrderableViewContainer<T>) -> Bool {
    return view1.value == view2.value
}

public func <=<T>(view1: OrderableViewContainer<T>, view2: OrderableViewContainer<T>) -> Bool {
    return view1.value > view2.value
}

public func <<T>(view1: OrderableViewContainer<T>, view2: OrderableViewContainer<T>) -> Bool {
    return view1.value < view2.value
}

public func ><T>(view1: OrderableViewContainer<T>, view2: OrderableViewContainer<T>) -> Bool {
    return view1.value > view2.value
}

