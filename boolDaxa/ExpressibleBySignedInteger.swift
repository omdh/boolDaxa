//
//  ExpressibleBySignedInteger.swift
//  bitDaxaTemp
//
//  Created by Andrew Moriarity on 2017-05-18.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - Expressible by SignedInteger types protocol 

/*
 / Protocol conformity for all current Integer types (that already adopt all the methods). 
 */
public protocol ExpressibleBySignedInteger {
    
    //#MARK: Signed integer values
    
    init(_ value: Int)
    
    init(_ value: Int8)
    
    init(_ value: Int16)
    
    init(_ value: Int32)
    
    init(_ value: Int64)
    
    //#MARK: Exactly initializers 
    
    init?(exactly value: Int)
    
    init?(exactly value: Int8)
    
    init?(exactly value: Int16)
    
    init?(exactly value: Int32)
    
    init?(exactly value: Int64)
    
}

//#MARK: - ExpressibleBySignedInteger conformity for UnsignedInteger types

extension UInt8 : ExpressibleBySignedInteger {}
extension UInt16 : ExpressibleBySignedInteger {}
extension UInt32 : ExpressibleBySignedInteger {}
extension UInt64 : ExpressibleBySignedInteger {}

//#MARK: - ExpressibleBySignedInteger conformity for SignedInteger types

extension Int8 : ExpressibleBySignedInteger {}
extension Int16 : ExpressibleBySignedInteger {}
extension Int32 : ExpressibleBySignedInteger {}
extension Int64 : ExpressibleBySignedInteger {}


