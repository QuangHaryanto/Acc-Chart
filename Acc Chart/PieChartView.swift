//
//  PieChartView.swift
//  Acc Chart
//
//  Created by Haryanto Salim on 14/07/21.
//

import UIKit

struct Segment {

    // the color of a given segment
    var color: UIColor

    // the value of a given segment – will be used to automatically calculate a ratio
    var value: CGFloat
    
    var name: String
}
//
//class SegmentView: UIView{
//    var radius: CGFloat?
//    var viewCenter: CGPoint?
//    var valueCount: CGFloat?
//    var startAngle: CGFloat?
//    var color: CGColor?
//    var value: CGFloat?
//    var ctx: CGContext?
//    
//    init(frame: CGRect, radius: CGFloat, viewCenter: CGPoint, valueCount: CGFloat, startAngle: CGFloat, color: CGColor, value: CGFloat, ctx: CGContext){
//        super.init(frame: frame)
//        isOpaque = false
//        self.radius = radius
//        self.viewCenter = viewCenter
//        self.valueCount = valueCount
//        self.startAngle = startAngle
//        self.color = color
//        self.value = value
//        self.ctx = ctx
//    }
//    
////    override init(frame: CGRect) {
////        super.init(frame: frame)
////        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
////
////
////    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    override func draw(_ rect: CGRect) {
//        // get current context
////        let ctx = self.ctx
//        let ctx = UIGraphicsGetCurrentContext()
//        
//        guard let radius = self.radius else{return}
//        guard let color = self.color else{return}
//        guard let startAngle = self.startAngle else{return}
//        guard let valueCount = self.valueCount else{return}
//        guard let viewCenter = self.viewCenter else{return}
//        guard let value = self.value else{return}
////        guard let ctx = self.ctx else{return}
//        
//        // set fill color to the segment color
//        ctx?.setFillColor(color)
//        
//        // update the end angle of the segment
//        let endAngle = startAngle + 2 * .pi * (value / valueCount)
//        
//        // move to the center of the pie chart
//        ctx?.move(to: viewCenter)
//        
//        // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
//        ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//        
//        // fill segment
//        ctx?.fillPath()
//        
//        ctx?.move(to: viewCenter)
//        ctx?.setFillColor(UIColor.systemBackground.cgColor)
//        ctx?.addArc(center: viewCenter, radius: radius * (0.5), startAngle: startAngle, endAngle: endAngle, clockwise: false)
//        
//        // fill segment
//        ctx?.fillPath()
//    }
//}



class PieChartView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var currIndex: Int?
    
    /// An array of structs representing the segments of the pie chart
    var segments = [Segment]() {
        didSet {
//            segmentViews.removeAll()
            currIndex = segments.count - 1
            setNeedsDisplay() // re-draw view when the values get set
        }
    }
    
//    var segmentViews:[SegmentView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {

        // get current context
        let ctx = UIGraphicsGetCurrentContext()

        // radius is the half the frame's width or height (whichever is smallest)
        let radius = min(frame.size.width, frame.size.height) * 0.5

        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)

        // enumerate the total value of the segments by using reduce to sum them
        let valueCount = segments.reduce(0, {$0 + $1.value})

        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5

//        var elements = [UIAccessibilityElement]()
        
        for segment in segments { // loop through the values array
            // set fill color to the segment color
            ctx?.setFillColor(segment.color.cgColor)

            // update the end angle of the segment
            let endAngle = startAngle + 2 * .pi * (segment.value / valueCount)

            // move to the center of the pie chart
            ctx?.move(to: viewCenter)

            // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
            ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)

            // fill segment
            ctx?.fillPath()

            ctx?.move(to: viewCenter)
            ctx?.setFillColor(UIColor.systemBackground.cgColor)
            ctx?.addArc(center: viewCenter, radius: radius * (0.5), startAngle: startAngle, endAngle: endAngle, clockwise: false)

            // fill segment
            ctx?.fillPath()
            
//            guard let ctx = ctx else{return}
            
//            let segmentView = SegmentView(frame: self.frame, radius: radius, viewCenter: viewCenter, valueCount: valueCount, startAngle: startAngle, color: segment.color.cgColor, value: segment.value, ctx: ctx)
            
//            let nameElement = UIAccessibilityElement(accessibilityContainer: self)
//            nameElement.accessibilityLabel = "\(segment.name) has \(segment.value) percent, "
//            nameElement.accessibilityFrame = segmentView.frame
//            elements.append(nameElement)
            
//            segmentViews.append(segmentView)
            //
//            self.addSubview(segmentView)
//
////            let margins = view.layoutMarginsGuide
//            segmentView.translatesAutoresizingMaskIntoConstraints = false
//            let guide = self.layoutMarginsGuide
//
//            NSLayoutConstraint.activate([
//                segmentView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
//                segmentView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
//                segmentView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1.0),
//                segmentView.heightAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 1.0)
//            ])
            
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
        }
//        accessibilityElements = elements
    }
    
    private var _accessibilityLabel: String?
        
    override var accessibilityLabel: String?{
        get{
            if let _accessibilityLabel = _accessibilityLabel {
                return _accessibilityLabel
            }
            return "Pie Chart"
        }
        set{
            _accessibilityLabel = newValue
            super.accessibilityLabel = newValue
        }
    }
    private var _accessibilityValue: String?
    
    override var accessibilityValue: String?{
        get{
            if let _accessibilityValue = _accessibilityValue {
                return _accessibilityValue
            }
            return "It has \(accessibilityElements?.count ?? 0) category"
        }
        set{
            _accessibilityValue = newValue
            super.accessibilityValue = newValue
        }
    }
    
    override var accessibilityTraits: UIAccessibilityTraits{
        get{
            return .adjustable
        }
        set{
            self.accessibilityTraits = newValue
        }
    }
    
    override func accessibilityIncrement() {
        print("Increment")
        
        if currIndex == segments.count - 1 {
            currIndex = 0
        } else {
            if self.currIndex != nil {
                self.currIndex! += 1
            }
        }
        if self.currIndex != nil {
            accessibilityLabel = "Pie Chart has \(accessibilityElements?.count ?? 0) category"
            accessibilityValue = "\(segments[currIndex!].name) category is \(segments[currIndex!].value) percent"
        }
        
    }
    
    override func accessibilityDecrement() {
        print("Decrement")
        if currIndex == 0 {
            currIndex = segments.count - 1
        } else {
            if self.currIndex != nil {
                self.currIndex! -= 1
            }
        }
        if self.currIndex != nil {
            accessibilityLabel = "Pie Chart has \(accessibilityElements?.count ?? 0) category"
            accessibilityValue = "\(segments[currIndex!].name) category is \(segments[currIndex!].value) percent"
        }
    }
    
    private var _accessibilityElements: [Any]?

    override var accessibilityElements: [Any]? {
        set {
            _accessibilityElements = newValue
        }

        get {
            // Return the accessibility elements if we've already created them.
            if let _accessibilityElements = _accessibilityElements {
                return _accessibilityElements
            }

            /*
                We want to create a custom accessibility element that represents a grouping of each
                title and content label pair so that the VoiceOver user can interact with them as a unified element.
                This is important because it reduces the amount of times the user has to swipe through the display
                to find the information they're looking for, and because without grouping the labels,
                the content labels lose the context of what they represent.
            */
            var elements = [UIAccessibilityElement]()
            for segment in segments {
                let nameElement = UIAccessibilityElement(accessibilityContainer: self)
                nameElement.accessibilityLabel = "\(segment.name) has \(segment.value) percent, "
                elements.append(nameElement)
            }


            _accessibilityElements = elements

            return _accessibilityElements
        }
    }
}
