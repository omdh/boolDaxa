//
//  BoolSetSlice.swift
//  boolDaxaTest
//
//  Created by Andrew Moriarity on 2017-05-21.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - BoolSet Slice

/*
 / A Slice (SubSequence) for BoolSet types that conform to the Collection protocol.
 / 
 */
public struct BoolSetSlice<Bits> : BoolSet where Bits : FixedWidthInteger {
    
    public typealias Index = Int
    
    public typealias Iterator = BoolSetIterator<Bits>
    
    /*
     / Collection attributes
     */
    public var count : Int { return self.endIndex - self.startIndex } //count is the difference in the start/end indexes
    
    public var isEmpty : Bool { return self.bits == 0 } //if 0, no bits are turned on, and the UInt bitarray is therefore empty
    
    public var first : Bool? { return (self.bits & Bits(self.startIndex) != 0) ? true : false } //returns wether the first bit is on or off, since there will always be a first element
    
    public private(set) var startIndex : Int //lower bound of the range of the bit slice
    
    public private(set) var endIndex : Int //uper bound of the range of the bit slice
    
    /*
     / bitarray that was sliced
     */
    public private(set) var bits : Bits
    
    /*
     / Initializes an empty (all bits 'off') UInt BitSlice from the Bits empty initializer. The endIndex will be the same endIndex as the Bits endIndex, and the startIndex will be 0.
     */
    public init() {
        self.init(bits: 0)
    }
    public init(bits: Bits) {
        self.startIndex = 0
        self.endIndex = Bits.bitWidth - 1
        
        self.bits = bits
    }
    
    /*
     / Internal method for initializing a BitarraySlice from a range on a bitarray.
     */
    internal init(bits: Bits, range: Range<Int>) {
        let upperRangeShift : Bits = Bits(Bits.bitWidth - range.upperBound)
        
        self.bits = bits << upperRangeShift
        self.bits = self.bits >> Bits(range.lowerBound) + upperRangeShift
        self.bits = self.bits << Bits(range.lowerBound)
        
        self.startIndex = range.lowerBound
        self.endIndex = range.upperBound
    }
    
    /*
     / All UIntBitCollection types can set UIntIterator<Self> as Self.Iterator, as UIntIterator works with UIntBitManagement types (a requirment of UIntBitCollection types)
     */
    public func makeIterator() -> BoolSetIterator<Bits> {
        return BoolSetIterator<Bits>(bitsSlice: self.bits, startIndex: Bits(self.startIndex), endIndex: Bits(self.endIndex))
    }
    
    /*
     / An access only subscript, will throw a fatal error if the index provided is outside of the start/end index range.
     */
    public subscript(index: Int) -> Bool {
        get {
            precondition(index <= self.endIndex, "Index above BitSlice index range")
            precondition(index >= self.startIndex, "Index below BitSlice index range")
            
            return ((self.bits & (1 << Bits(index))) != 0) ? true : false
        } set (newValue) {
            precondition(index <= self.endIndex, "Index above BitSlice index range")
            precondition(index >= self.startIndex, "Index below BitSlice index range")
            
            self.bits = newValue ? self.bits | (1 << Bits(index)) : self.bits & ~(1 << Bits(index))
        }
    }
    
    //#MARK: Equatable conformity
    
    public static func ==(lbs: BoolSetSlice<Bits>, rbs: BoolSetSlice<Bits>) -> Bool {
        return lbs.bits == rbs.bits
    }
}
