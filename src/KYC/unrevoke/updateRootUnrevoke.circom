pragma circom 2.0.0;
include "../../lib/util/verifyTree.circom";

/*
    This circuit is used to update new root revoke tree with 1 identity was unrevoked
    Inputs: 
        - root
        - siblings[32]: 
            sibilings are siblings of key
        - key: 
            key is unrevoked key of revokes tree
    You can see https://github.com/BkCrypt0/BkCrypt0-Server to know how to create inputs in detail
*/
component main {public [
    root,
    key
]}= VerifyNewRootUnrevoke(32);