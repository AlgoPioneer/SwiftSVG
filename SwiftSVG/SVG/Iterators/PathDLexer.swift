//
//  PathDLexer.swift
//  SwiftSVG
//
//  Created by Michael Choe on 6/14/17.
//  Copyright © 2017 Strauss LLC. All rights reserved.
//

#if os(iOS)
    import UIKit
#elseif os(OSX)
    import AppKit
#endif



enum DCharacter: CChar {
    case C = 67
    case c = 99
    case H = 72
    case h = 104
    case L = 76
    case l = 108
    case M = 77
    case m = 109
    case Q = 81
    case q = 113
    case S = 83
    case s = 115
    case T = 84
    case t = 116
    case V = 86
    case v = 118
    case Z = 90
    case z = 122
    case comma = 44
    case sign = 45
    case space = 32
}

let characterDictionary: [CChar : PathCommand] = [
    DCharacter.M.rawValue: MoveTo(pathType: .absolute),
    DCharacter.m.rawValue: MoveTo(pathType: .relative),
    DCharacter.C.rawValue: CurveTo(pathType: .absolute),
    DCharacter.c.rawValue: CurveTo(pathType: .relative),
    DCharacter.Z.rawValue: ClosePath(pathType: .absolute),
    DCharacter.z.rawValue: ClosePath(pathType: .absolute),
    DCharacter.S.rawValue: SmoothCurveTo(pathType: .absolute),
    DCharacter.s.rawValue: SmoothCurveTo(pathType: .relative),
    DCharacter.L.rawValue: LineTo(pathType: .absolute),
    DCharacter.l.rawValue: LineTo(pathType: .relative),
    DCharacter.H.rawValue: HorizontalLineTo(pathType: .absolute),
    DCharacter.h.rawValue: HorizontalLineTo(pathType: .relative),
    DCharacter.V.rawValue: VerticalLineTo(pathType: .absolute),
    DCharacter.v.rawValue: VerticalLineTo(pathType: .relative),
    DCharacter.Q.rawValue: QuadraticCurveTo(pathType: .absolute),
    DCharacter.q.rawValue: QuadraticCurveTo(pathType: .relative),
    DCharacter.T.rawValue: SmoothQuadraticCurveTo(pathType: .absolute),
    DCharacter.t.rawValue: SmoothQuadraticCurveTo(pathType: .relative),
]


struct PathDLexer: IteratorProtocol, Sequence {
    
    typealias Element = PathCommand
    
    var currentCharacter: CChar {
        return self.workingString[self.iteratorIndex]
    }
    
    var currentCommand: PathCommand = MoveTo(pathType: PathType.absolute)
    
    var iteratorIndex: Int = 0
    let pathString: String
    let workingString: ContiguousArray<CChar>
    
    var xArray = [CChar]()
    var yArray = [CChar]()
    
    init(pathString: String) {
        self.pathString = pathString
        self.workingString = self.pathString.utf8CString
    }
    
    func makeIterator() -> PathDLexer {
        return PathDLexer(pathString: self.pathString)
    }
    
    mutating func next() -> Element? {
        
        self.xArray.removeAll()
        self.yArray.removeAll()
        
        var finishedParsingX = false
        self.currentCommand.clearBuffer()
        
        while self.iteratorIndex < self.workingString.count - 1 {
            
            if let command = characterDictionary[self.currentCharacter] {
                
                if let validCoordinate = Double(byteArray: (!finishedParsingX ? self.xArray : self.yArray)) {
                    self.currentCommand.coordinateBuffer.append(validCoordinate)
                }
                
                self.iteratorIndex += 1
                
                if self.currentCommand.canPushCommand {
                    let returnCommand = self.currentCommand
                    self.currentCommand = command
                    return returnCommand
                } else {
                    self.currentCommand = command
                }
                
            }
            
            switch self.currentCharacter {
            case DCharacter.comma.rawValue, DCharacter.sign.rawValue, DCharacter.space.rawValue:
                finishedParsingX = !finishedParsingX
                if let validCoordinate = Double(byteArray: (finishedParsingX ? self.xArray : self.yArray)) {
                    self.currentCommand.coordinateBuffer.append(validCoordinate)
                }
                
                if self.currentCommand.canPushCommand {
                    return self.currentCommand
                }
                self.iteratorIndex += 1
            default:
                break
            }
            
            if !finishedParsingX {
                self.xArray.append(self.currentCharacter)
            } else {
                self.yArray.append(self.currentCharacter)
            }
            self.iteratorIndex += 1
            
        }
        
        return nil
    }
}
