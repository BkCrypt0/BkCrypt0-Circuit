// SPDX-License-Identifier: GPL-3.0
pragma circom 2.0.0;
include "../../../lib/util/verifyTree.circom";

/*
    This circuit is used to update new root claim tree with 10 identities
    Inputs: 
        - root
            root of claim tree after adding 10 identities
        - siblings[10][102]: 
            sibilings[i][102] are siblings of keys[i]
        - enabled[10]: 
            enabled = 1: if you want to prove keys[i] in claim tree
                    = 0: if you ignore keys[i]
        - keys[10]: 
            keys[i] is new key of claims tree
        - values[10]:
            values[i] is new value of key[i]
        - informations[10][6] 
            informations[i] is formation of keys[i]. It includes:
                + informations[i][0]: publicKey[0]
                + informations[i][1]: publicKey[1]
                + informations[i][2]: CCCD
                + informations[i][10]: sex
                + informations[i][4]: DoBdate
                + informations[i][5]: BirthPlace
        - signatures[10][3]
            signature[i] is signature of keys[i] what sign values[i] and verify their information is true. 
                + signature[i][0]: R8x
                + signature[i][1]: R8y
                + signature[i][2]: S
    You can see https://github.com/BkCrypt0/BkCrypt0-Server to know how to create inputs in detail
*/
component main {public [
    root,
    keys,
    values
]}= VerifyNewRootClaim(10, 32);