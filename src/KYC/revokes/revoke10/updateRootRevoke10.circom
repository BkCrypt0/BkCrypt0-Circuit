pragma circom 2.0.0;
include "../../../lib/util/verifyTree.circom";

/*
    This circuit is used to update new root revoke tree with 10 identities
    Inputs: 
        - root
        - siblings[10][32]: 
            sibilings[i] are siblings of keys[i]
        - enabled[10]: 
            keys[i] = 1: if you want to prove keys[i] in revoke tree
                    = 0: if you ignore keys[i]
        - keys[10]: 
            keys[i] is new key of revokes tree
        - values[10]:
            values[i] is new value of key[i]
        - fnc[10]
            fnc[i] = 1: if you want to prove keys[i] in revoke tree
                   = 0: vice versa
    You can see https://github.com/BkCrypt0/BkCrypt0-Server to know how to create inputs in detail
*/
component main {public [
    root,
    keys,
    values
]}= VerifyNewRootRevoke(10, 32);