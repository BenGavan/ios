//
//  Canvas.swift
//  BasicDrawingCanvas
//
//  Created by Ben Gavan on 11/07/2019.
//  Copyright © 2019 Ben Gavan. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    private var lines = [Line]()
    private var strokeWidth: CGFloat = 1
    private var strokeColor: UIColor = .red
    
    // MARK: overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineCap(.round)
        
        lines.forEach { (line) in
            context.setStrokeColor(line.color.cgColor)
            context.setLineWidth(line.strokeWidth)
            
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(color: strokeColor, strokeWidth: strokeWidth, points: []))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay()
    }
    
    
    // MARK: public functions
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func setStroke(color: UIColor) {
        self.strokeColor = color
    }
    
    func setStroke(width: CGFloat) {
        self.strokeWidth = width
    }
    
    func setStroke(width: Float) {
        self.setStroke(width: CGFloat(width))
    }
    
    // MARK: private functions
}
