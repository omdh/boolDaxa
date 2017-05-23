//
//  UIntBitshiftOperations.swift
//  bitDaxa
//
//  Created by Andrew Moriarity on 2017-05-15.
//
//

/*
 / Used to provide abstractions around the UInt types (required for subscripting)
 / All UInt types should already have methods, so conformity is just a matter of adopting protocol
 */
public protocol BitshiftOperations : Integer {

    static func <<(lhs: Self, rhs: Self) -> Self

    static func >>(lhs: Self, rhs: Self) -> Self

    init(_ val: UInt8)
}

//#MARK: - BitshiftOperations conformity for UnsignedInteger types

extension UInt8 : BitshiftOperations {}
extension UInt16 : BitshiftOperations {}
extension UInt32 : BitshiftOperations {}
extension UInt64 : BitshiftOperations {}

//#MARK: - BitShiftOperations conformity for SignedInteger types

extension Int8 : BitshiftOperations {}
extension Int16 : BitshiftOperations {}
extension Int32 : BitshiftOperations {}
extension Int64 : BitshiftOperations {}
