//
//  UIntBoolSet.swift
//  bitDaxaTemp
//
//  Created by Andrew Moriarity on 2017-05-18.
//  Copyright © 2017 AndrewMoriarity. All rights reserved.
//

//#MARK: - Equality conformity

/*
 / To determine equality with UInt BitCollections, only a single equality is required.
 */
public extension BoolSet {
    public static func ==(lbs: Self, rbs: Self) -> Bool {
        return lbs.bits == rbs.bits
    }
}

//#MARK: - SetAlgebra conformity

public extension BoolSet {
    /*
     / Removes elements of this set that arent in other
     / Uses an 'AND'ing operation on the bits (integers) of self and other. Runs in O(1).
     */
    public mutating func formIntersection(_ other: Self) {
        self = Self(bits: self.bits & other.bits)
    }
    public func intersection(_ other: Self) -> Self {
        return Self(bits: self.bits & other.bits)
    }
    
    /*
     /
     / Since max on a BitManagement type will be all 1's in the bits, it represents the entire set space. Finding the symmetric difference is therefore just removing all the elements that are common among this bitarray and the given bitarray ('AND' then an inverse).
     / 'allZeros' must inverted to get all 'on' bits. 'max' cannot be used, signed integers will still have a 0 at the most significant bit.
     */
    public mutating func formSymmetricDifference(_ other: Self) {
        self = Self(bits: ~Bits.allZeros & ~(self.bits & other.bits))
    }
    public func symmetricDifference(_ other: Self) -> Self {
        return Self(bits: ~Bits.allZeros & ~(self.bits & other.bits))
    }
    
    /*
     / Add the elements of the given set to the current set, using an 'OR'ing operation.
     / Runs in O(1), if on a 32 bit machine UInt64 bitarray runs in O(2).
     */
    public mutating func formUnion(_ other: Self) {
        self = Self(bits: self.bits | other.bits)
    }
    public func union(_ other: Self) -> Self {
        return Self(bits: self.bits | other.bits)
    }
    
    /*
     / Determines if either bitarray has the same indexes turned 'on'.
     / Performs an intersection ('AND'ing operation), and determines if there are no matches (resulting number will be less then 0).
     */
    public func isDisjoint(with other: Self) -> Bool {
        return self.bits & other.bits <= 0
    }
    
    /*
     / Checks if one BoolSet is a superset/subset of the other.
     / Since the set sizes are going to be identical (restricted by the bit width of unsigned integers), checking for subset only entails ensuring that all bits in current bitarray are in the given bitarray).
     / After 'AND'ing both bitarrays, checks that its equal to this bitarray. This bitarray will be a subset if its equal to the 'AND'ing.
     */
    public func isSubset(of other: Self) -> Bool {
        return self.bits & other.bits == self.bits
    }
    
    /*
     / Similar to subset, set sizes are going to be identical, so checking for a superset only entails ensuring that all bits in given bitarray are in this bitarray.
     / After 'AND'ing both bitarrays, checks that its equal to the given bitarray. The given bitarray will be a subset if its equal to the 'AND'ing.
     */
    public func isSuperset(of other: Self) -> Bool {
        return self.bits & other.bits == other.bits
    }
    
    /*
     / Used to remove all indexes in given BoolSet from this BoolSet
     / Removes all bits in self from the given bitarray, by turning off all bits at indexes ('AND'ing and inversing given bitarray). 
     / Runs in O(2) operations.
     */
    public mutating func subtract(_ other: Self) {
        self = Self(bits: self.bits & ~other.bits)
    }
    public func subtracting(_ other: Self) -> Self {
        return Self(bits: self.bits & ~other.bits)
    }
}

//#MARK: - SetAlgebra Element methods conformity

/*
 / All BoolSet SetAlgebra functions use the underlying bitarray SetAlgebra functions to perform comparisons in magnitude of efficiency better then O(n).
 */
public extension BoolSet {
    //#TODO: Revisit to determine if a false value should be provided for BoolSetIndex. Will require a rewrite of SetAlgebra element methods.
    
    /*
     / Converts the BoolSet index (BoolSetIndex) to BitIndex and calls the contain SetAlgebra method on the BoolSet's bitarray. 
     / Checks if the bit at the member position is set
     */
    public func contains(_ member: BoolSetIndex<Bits>) -> Bool {
        //#TODO: take into account the boolean value of member (can be false)

        
        return (self.bits & (1 << member.index)) > 0
    }
    
    /*
     / Set new member, if previously 'false' return true, else false.
     / Since all values for a specific member (index and bool value) are going to be indistinguishable, dont bother returning a new member, just the one provided.
     */
    @discardableResult public mutating func insert(_ newMember: BoolSetIndex<Bits>) -> (inserted: Bool, memberAfterInsert: BoolSetIndex<Bits>) {
        if self.contains(newMember) { //will check member is within index range
            return (false, newMember)
        } else { //set the index to the bit state coresponding to the boolean value in the provided newMember
            self = Self(bits: newMember.bool ? (self.bits | (1 << newMember.index)) : (self.bits & ~(1 << newMember.index)))
            return (true, newMember)
        }
    }
    
    /*
     / ALWAYS sets to false at the designated index (member). Returns the element if present or nil if not present.
     / Since all values for a specific member (index and bool value) are going to be indistinguishable, dont bother returning a new member, just the one provided.
     */
    @discardableResult public mutating func remove(_ member: BoolSetIndex<Bits>) -> BoolSetIndex<Bits>? {
        let isContained : Bool = self.contains(member) //will check member is within index range
        
        self = Self(bits: self.bits & ~(1 << member.index)) //set the index to 'off', by inverting and shifting the index in member
        
        if isContained {
            return member
        } else {
            return nil
        }
    }
    
    /*
     / Since all elements at an index are going to be identical, this method just turns on a bit at given bit index.
     / If the index (newMember) was previously turned 'on', will return the index, otherwise nil
     */
    @discardableResult public mutating func update(with newMember: BoolSetIndex<Bits>) -> BoolSetIndex<Bits>? {
        let isContained : Bool = self.contains(newMember) //will check member is within index range
        
        self = Self(bits: newMember.bool ? self.bits | (1 << newMember.index) : self.bits & ~(1 << newMember.index)) //set the index to the bit state coresponding to the boolean value in the provided newMember
        
        if isContained {
            return newMember
        } else {
            return nil
        }
    }
}

//#MARK: - Initialize from Sequence conformity

/*
 / All initializers that initialize from a sequence must have a length greater than or equal to the sequence length. This is only a requirement for all numbered bitarrays (Bitarray8, Bitarray16, Bitarray32, Bitarray64). For Bitarray, another initializer is called that ignores the length of the provided sequence.
 */
public extension BoolSet {
    /*
     / Since the sequence can be longer then the current Bitarray type (all numbered types), then an error will be thrown and the operation will fail if the sequence is indeed longer.
     / Runs in O(n), 'n' is the sequence count. 
     */
    public init<B>(_ sequence: B) where B : Sequence, B.Iterator.Element == Bool {
        var bits : Bits = 0 //initialize the entire bitarray to 'off' values
        
        for (index, on) in sequence.enumerated() {
            if on { //is true
                bits = bits | 1 << Bits(index) //only bother setting the 'on' values
            }
        }
        
        self.init(bits: bits)
    }
    
    /*
     / Initializes a BoolSet from a sequence of elements of Int. Each integer representing the index of a
     / The elements of the sequence provided need to be 'Int'.
     / Since the sequence can be longer then the current Bitarray type (all numbered types), then an error will be thrown and the operation will fail if the sequence is indeed longer.
     / Runs in O(n), 'n' is the sequence count
     */
    public init<S>(_ sequence: S) where S : Sequence, S.Iterator.Element == BoolSetIndex<Bits> {
        var bits : Bits = 0//initialize the entire bitarray to 'off' values
        
        for boolIndex in sequence { //every index represents an 'on' value
            bits = boolIndex.bool ? bits | 1 << boolIndex.index : bits & ~(1 << boolIndex.index)
        }
        
        self.init(bits: bits)
    }
    
    /*
     / Takes any BoolSet that has the same Bits type as self, and initializes from its bits integer.
     */
    public init<B>(_ boolSet: B) where B : BoolSet, B.Bits == Self.Bits {
        self.init(bits: boolSet.bits)
    }
}
