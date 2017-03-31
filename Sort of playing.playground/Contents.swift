//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 300))
containerView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

func createRandomViews() -> [OrderableViewContainer<Int>] {
    
    let xOffset = 50
    let viewWidth = 20
    let distanceBetweenViews = 10
    
    var list = [OrderableViewContainer<Int>]()
    while (list.count < 10) {
        let randomValue = Int.random(range: 10...100)
        
        let xViewFrame = xOffset + (viewWidth * list.count) + (distanceBetweenViews * list.count)
        let yViewFrame = Int(containerView.frame.height) - randomValue
        let viewFrame = CGRect(x: xViewFrame, y: yViewFrame, width: viewWidth, height: randomValue)
        
        let view = UIView(frame: viewFrame)
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 3
        
        let xLabelFrame = xViewFrame
        let yLabelFrame = Int(containerView.frame.height) - randomValue - 40
        let widthLabelFrame = viewWidth
        let label = UILabel()
        label.text = "\(randomValue)"
        label.textColor = .yellow
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        
        let heightLabelFrame = label.heightThatFits()
        let labelFrame = CGRect(x: xLabelFrame, y: yLabelFrame, width: widthLabelFrame, height: Int(heightLabelFrame))
        label.frame = labelFrame
        
        containerView.addSubview(label)
        
        let container = OrderableViewContainer<Int>(view: view, value: Int.random(range: -10...10))
        list.append(container)
        containerView.addSubview(container.getView())
    }
    
    return list
}
struct AnimationStep {
    var duration: TimeInterval
    var animationClosure: () -> ()
}

func startAnimating(fromIndex currentIndex: Int, animations: [AnimationStep]) {
    guard animations.indices.contains(currentIndex) else {
        return
    }
    
    let currentAnimation = animations[currentIndex]
    UIView.animate(withDuration: currentAnimation.duration, animations: {
        currentAnimation.animationClosure()
    }, completion: { _ in
        let nextIndex = currentIndex + 1
        if animations.indices.contains(nextIndex) {
            startAnimating(fromIndex: nextIndex, animations: animations)
        }
    })
}


var list = createRandomViews()

let onSwap = { (o1: OrderableViewContainer<Int>, o2:OrderableViewContainer<Int>) in
    print("Swaping \(o1.getValue()) < \(o2.getValue())")
    swap(&o1.getView().center.x, &o2.getView().center.x)
    o1.getView().backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    o2.getView().backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
}

let onCompare = { (o1: OrderableViewContainer<Int>, o2: OrderableViewContainer<Int>) in
    print("Comparing \(o1.getValue()) < \(o2.getValue())")
    o1.getView().backgroundColor = .red
    o2.getView().backgroundColor = .red
}

var animationSteps: [AnimationStep] = []
list.bubble(>, swaping: { (o1, o2) in
    let animation = AnimationStep(duration: 0.5, animationClosure: { onSwap(o1, o2) })
    animationSteps.append(animation)
},
            comparing: { (o1, o2) in
                let animation = AnimationStep(duration: 0.5, animationClosure: { onCompare(o1, o2) })
                animationSteps.append(animation)
})

print("Starting...")

let a = [1,2,3,5]
print(a.reduce("", { $0 == "" ? $1 : $0 + "," + $1 }))

//print(list.reduce("", { ($0 as! String).append(String($1.getValue())) } ))
startAnimating(fromIndex: 0, animations: animationSteps)


PlaygroundPage.current.liveView = containerView
PlaygroundPage.current.needsIndefiniteExecution = true // talvez?
