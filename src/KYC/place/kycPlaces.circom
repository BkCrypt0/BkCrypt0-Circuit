// SPDX-License-Identifier: GPL-3.0
pragma circom 2.0.0;
include "../../lib/place/verifyPlaces.circom";

/*
    This circuit is used to prove user's birth place belong to some expected province 
    Inputs: 
        - rootRevoke
            rootRevoke is currently root revoke tree
        - siblingsRevoke[32]: 
            siblingsRevoke are siblings of key in revoke tree
        - oldKeyRevoke
        - oldValueRevoke
        - isOld0Revoke

        - rootClaims
            rootClaims currently root claim tree
        - siblingsClaims[32]: 
            siblingsClaims are siblings of key in claims tree

        - key
        - value

        - publicKey[2]
        - CCCD
        - sex
        - DoBdate
        - BirthPlace

        - placesExpecting: 
            it is a 64-bit string. We ignare the first bit. 
            We define i-th bit = 1 mean you want to prove that yur birth place is i-th province and i-th bit = 0 is vice verse.

        - R8x
        - R8y
        - S
        R8x, R8y, S are signature what sign messge and guarantee no one can impersonate you to create proof

        - expireTime
            expireTime = currentTimestamp + 10 * 60 (s) 
        - message
            it hash Mimc of value and expireTime 

    You can see https://github.com/BkCrypt0/BkCrypt0-Server to know how to create inputs in detail
*/

component main {public [
    rootRevoke,
    rootClaims,
    publicKey,
    placesExpecting,
    expireTime
]}= VerifyPlaces(32);