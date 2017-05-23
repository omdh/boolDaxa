//
//  BoolSet.swift
//  bitDaxa
//
//  Created by Andrew Moriarity on 2017-05-16.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSet protocol 

/*
 /
 / Use BoolSet to create a set of boolean values to represent some abstraction. This abstract data type provides specificity by being adopted by a concrete type.
 /
 / BoolSets use a bitarray as an underlying data structure. An 'on' bit represents a truth value, and a 'off' bit represents a false value. Bitarrays are used to better performance by requiring less processor calls for SetAlgebra methods. 
 / 
 / RawRepresentable was not used as the initializer (like OptionSet), because you are guaranteed an initialization upon providing a rawValue, unlike the optional initializer for RawRepresentable.
 /
 */
public protocol BoolSet : SetAlgebra, MutableCollection, Hashable {
    /*
     / Since all elements in a bool set are bools, the elements of the set are represented by the indexes of the true values. So a BoolSet is the set of all indexes that have true values.
     */
    associatedtype Element = BoolSetIndex<Bits>
    
    /*
     / Possible options: Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64. The number on the end represents the length, integers need to be chosen that are longer then the expected set size.
     / Choosing an option should depend on the size of the BoolSet. Any set larger then 64 is not currently possible. Using the smallest possible Bitarray type for the current set will have a direct impact on the performance of the code. However if a Bitarray is chosen that is smaller then the current set size, fatal errors will be thrown and the program will crash.
     */
    associatedtype Bits : FixedWidthInteger
    
    var bits : Bits { get }
    
    init(bits: Bits)
    
    /*
     / Initializes using a sequence of boolean values. For all false values the bits are turned 'off' and for all the true values the bits are turned 'on'. 
     / The order of the sequence is kept, and starts at the origin position (0). If the sequence is longer then the current Bitarray type (all numbered types), then an error will throw and the operation will fail.
     */
    init<B>(_ sequence: B) where B : Sequence, B.Iterator.Element == Bool
    
}

//#MARK: SetAlgebra Initializer conformity

public extension BoolSet {
    /*
     / Initializes using an empty bitarray.
     */
    public init() {
        self.init(bits: 0)
    }
}

//#MARK: ExpressibleByArrayLiteral conformity

public extension BoolSet {
    
    public typealias Element = BoolSetIndex<Bits> //silences type generics on protocol default methods (no constraints needed)
    
    /*
     / Initializes a bitarray (Self.BitSet), setting all indexes to .on if the element is a true and .off if the element is a false. 
     / Then initializes self using that bitarray 
     */
    public init(arrayLiteral elements: BoolSetIndex<Bits>...) {
        var bits : Bits = 0
        
        for boolIndex in elements {
            bits = boolIndex.bool ? bits | 1 << boolIndex.index : bits & ~(1 << boolIndex.index)
        }
        
        self.init(bits: bits)
    }
}

//#MARK: Hashable conformity 

public extension BoolSet {
    /*
     / Uses the built in hashvalue for the bits attribute
     */
    public var hashValue: Int { return self.bits.hashValue }
}



