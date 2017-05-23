//
//  UIntBitManagement.swift
//  bitDaxa
//
//  Created by Andrew Moriarity on 2017-05-13.
//
//

//Bit Management abstraction for UInt types 
public protocol FixedWidthInteger : BitwiseOperations, BitshiftOperations, ExpressibleBySignedInteger {
    
    static var bitWidth : Int {get}
    
    static var max : Self { get }

    static var min : Self { get }
    
    init() //initializes to 0 
        
}

//#MARK: - FixedWidthInteger conformity for UInteger types

extension UInt8 : FixedWidthInteger {
    public static var bitWidth : Int { return 8 }
}
extension UInt16 : FixedWidthInteger {
    public static var bitWidth : Int { return 16 }
}
extension UInt32 : FixedWidthInteger {
    public static var bitWidth : Int { return 32 }
}
extension UInt64 : FixedWidthInteger {
    public static var bitWidth : Int { return 64 }
}

//#MARK: - FixedWidthInteger conformity for SignedInteger types

extension Int8 : FixedWidthInteger {
    public static var bitWidth : Int { return 8 }
}
extension Int16 : FixedWidthInteger {
    public static var bitWidth : Int { return 16 }
}
extension Int32 : FixedWidthInteger {
    public static var bitWidth : Int { return 32 }
}
extension Int64 : FixedWidthInteger {
    public static var bitWidth : Int { return 64 }
}
