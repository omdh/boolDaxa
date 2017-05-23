//
//  BoolSetIndex.swift
//  bitDaxa
//
//  Created by Andrew Moriarity on 2017-05-20.
//
//

/*
 / Represents the state (boolean value) of a BoolSet at a specific index.
 / The BoolSetIndex takes the Bits type from a BoolSet to ensure only BoolSets with same Bits can be initialized from eachother (the required SetAlgebra initializer: init<S>(_ sequence: S) where S : Sequence, S.Iterator.Element == Self.Element). Otherwise fatalerrors could be thrown if the index ranges are not equal.
 */
public struct BoolSetIndex<Bits> : ExpressibleByIntegerLiteral, Equatable where Bits : FixedWidthInteger {
    
    public typealias IntegerLiteralType = Int
    
    internal let index : Bits
    
    internal let bool : Bool
    
    /*
     / When initialized from an integer literal, the default bool state is true
     */
    public init(integerLiteral value: Int) {
        self.init(value, true)
    }
    
    /*
     / Checks at initialization of index wether the index is within set range 
     */
    public init(_ index: Int, _ value: Bool){
        precondition(index < Bits.bitWidth, "Index above BoolSet Bits index range")
        precondition(index >= 0, "Index below BoolSet Bits index range")
        
        self.init(index: Bits(index), value)
    }
    private init(index: Bits, _ value: Bool){
        
        
        self.index = index
        self.bool = value
    }
    
    /*
     / Used to make comparisons between BitIndexes and Bits easier
     */
    public static func ==(index: BoolSetIndex<Bits>, bool: Bool) -> Bool {
        return index.bool == bool
    }
    public static func ==(bool: Bool, index: BoolSetIndex<Bits>) -> Bool {
        return bool == index.bool
    }
    
    /*
     / Equatable conformity
     */
    public static func ==(lbi: BoolSetIndex<Bits>, rbi: BoolSetIndex<Bits>) -> Bool {
        return lbi.index == rbi.index && lbi.bool == rbi.bool
    }
}
