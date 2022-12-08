// SPDX-License-Identifier: GPL-3.0
pragma circom 2.0.0;
include "../../../lib/util/verifyTree.circom";

/*
    This circuit is used to update new root claim tree with 3 identities
    Inputs: 
        - root
            root of claim tree after adding 3 identities
        - siblings[3][32]: 
            sibilings[i][32] are siblings of keys[i]
        - enabled[3]: 
            enabled = 1: if you want to prove keys[i] in claim tree
                    = 0: if you ignore keys[i]
        - keys[3]: 
            keys[i] is new key of claims tree
        - values[3]:
            values[i] is new value of key[i]
        - informations[3][6] 
            informations[i] is formation of keys[i]. It includes:
                + informations[i][0]: publicKey[0]
                + informations[i][1]: publicKey[1]
                + informations[i][2]: CCCD
                + informations[i][3]: sex
                + informations[i][4]: DoBdate
                + informations[i][5]: BirthPlace
        - signatures[3][3]
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
]}= VerifyNewRootClaim(3, 32);