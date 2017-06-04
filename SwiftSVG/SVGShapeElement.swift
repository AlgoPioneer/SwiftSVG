//
//  SVGShapeElement.swift
//  SwiftSVG
//
//  Created by Michael Choe on 6/4/17.
//  Copyright © 2017 Strauss LLC. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif

protocol SVGShapeElement: SVGElement {
    var svgLayer: CAShapeLayer { get set }
}

enum LineJoinType {
    case miter, round, bevel
}

extension SVGShapeElement {
    
    var fillAndStrokeAttributes: [String : (String) -> ()] {
        return [
            "fill": self.fillHex,
            "stroke": self.strokeColor,
            "stroke-linejoin": self.strokeLineJoin,
            "stroke-width": self.strokeWidth
        ]
    }
    
    internal func fillHex(hexString: String) {
        self.svgLayer.fillColor = UIColor(hexString: hexString).cgColor
    }
    
    internal func strokeColor(strokeColor: String) {
        self.svgLayer.strokeColor = UIColor(hexString: strokeColor).cgColor
    }
    
    internal func strokeLineJoin(lineJoin: String) {
        assert(false, "Need Implementation")
    }
    
    internal func strokeWidth(strokeWidth: String) {
        guard let strokeWidth = Double(lengthString: strokeWidth) else {
            return
        }
        self.svgLayer.lineWidth = CGFloat(strokeWidth)
    }
    
}
