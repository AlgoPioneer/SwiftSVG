//
//  SVGParser.swift
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



public protocol SVGParsable { }

extension Data: SVGParsable { }
extension URL: SVGParsable { }


open class SVGParser: NSObject, XMLParserDelegate {
    
    enum SVGParserError {
        case invalidSVG
    }
    
    fileprivate var elementStack = Stack<SVGElement>()
    
    private let configuration: SVGParserConfiguration
    open var containerLayer: CALayer?
    open fileprivate(set) var paths = [UIBezierPath]()
    
    init(parser: XMLParser, configuration: SVGParserConfiguration = SVGParserConfiguration.allFeatures, containerLayer: CALayer? = nil) {
        self.configuration = configuration
        super.init()
        
        if let layer = containerLayer {
            self.containerLayer = layer
        }
        
        parser.delegate = self
        parser.parse()
    }
    
    convenience init(data: Data, containerLayer: CALayer? = nil) {
        self.init(parser: XMLParser(data: data), containerLayer: containerLayer)
    }
    
    convenience init(SVGURL: URL, containerLayer: CALayer? = nil) {
        if let xmlParser = XMLParser(contentsOf: SVGURL) {
            self.init(parser: xmlParser, containerLayer: containerLayer)
        } else {
            fatalError("Couldn't initialize parser. Check your resource and make sure the supplied URL is correct")
        }
    }
    
    open func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        guard let elementType = self.configuration.tags[elementName] else {
            return
        }
        let svgElement = elementType()
        for (attributeName, attributeClosure) in svgElement.supportedAttributes {
            if let attributeValue = attributeDict[attributeName] {
                attributeClosure(attributeValue)
            }
        }
        self.elementStack.push(svgElement)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        //print("Did End: \(self.containerLayer?.sublayers)")
    }
    
    open func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        guard let lastItem = self.elementStack.last else {
            return
        }
        
        if let shapeElement = lastItem as? SVGShapeElement {
            self.elementStack.pop()
            guard let containerElement = self.elementStack.last as? SVGContainerElement else {
                return
            }
            shapeElement.didProcessElement(in: containerElement)
            
        } else if let containerElement = lastItem as? SVGContainerElement {
            
            self.containerLayer?.addSublayer(containerElement.containerLayer)
            self.elementStack.pop()
        }
    }
    
    public func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("Validation Error occured")
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parse Error: \(parseError)")
        let code = (parseError as NSError).code
        switch code {
        case 76:
            print("Invalid XML: \(SVGParserError.invalidSVG)")
        default:
            break
        }
    }
    
    
}

