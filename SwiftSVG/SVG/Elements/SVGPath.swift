//
//  SVGPath.swift
//  SwiftSVG
//
//  Created by Michael Choe on 3/5/17.
//  Copyright © 2017 Strauss LLC. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif



struct SVGPath: SVGShapeElement, ParsesAsynchronously {
    
    static var elementName: String {
        return "path"
    }
    
    var asyncParseManager: CanManageAsychronousCallbacks? = nil
    
    var supportedAttributes = [String : ((String) -> ())?]()
    var svgLayer = CAShapeLayer()
    
    internal func parseD(_ pathString: String) {
        let workingString = pathString.trimWhitespace()
        assert(workingString.hasPrefix("M") || workingString.hasPrefix("m"), "Path d attribute must begin with MoveTo Command (\"M\")")
        autoreleasepool { () -> () in
            
            let concurrent = DispatchQueue(label: "concurrent", attributes: .concurrent)
            let dispatchGroup = DispatchGroup()
            
            let returnPath = UIBezierPath()
            returnPath.move(to: CGPoint.zero)
            
            concurrent.async(group: dispatchGroup) {
                
                var previousCommand: PreviousCommand? = nil
                for thisPathCommand in PathDLexer(pathString: workingString) {
                    thisPathCommand.execute(on: returnPath, previousCommand: previousCommand)
                    previousCommand = thisPathCommand
                }
                
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                self.svgLayer.path = returnPath.cgPath
                self.asyncParseManager?.finishedProcessing(self.svgLayer.path?.boundingBox)
            }
        }
    }
    
    func clipRule(_ clipRule: String) {
        if clipRule == "evenodd" {
            guard let thisPath = self.svgLayer.path else {
                print("Need to implement path evenodd")
                return
            }
            let bezierPath = UIBezierPath(cgPath: thisPath)
            bezierPath.usesEvenOddFillRule = true
            self.svgLayer.path = bezierPath.cgPath
        }
    }
    
    func didProcessElement(in container: SVGContainerElement?) {
        guard let container = container else {
            return
        }
        container.containerLayer.addSublayer(self.svgLayer)
    }
}
