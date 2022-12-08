// SPDX-License-Identifier: GPL-3.0
pragma circom 2.0.0;
include "../../lib/age/verifyAge.circom";

/*
    This circuit is used to prove user age from minAge to maxAge
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
    You can see https://github.com/BkCrypt0/BkCrypt0-Server to know how to create inputs in detail
*/
component main {public [
    rootRevoke,
    rootClaims,
    publicKey,
    minAge,
    maxAge,
    currentYear,
    currentMonth,
    currentDay,
    expireTime
]}= VerifyAge(32);