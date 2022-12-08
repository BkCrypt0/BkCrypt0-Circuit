// SPDX-License-Identifier: GPL-3.0
include "smtverifier.circom";

template SparseMerkleTreeVerifier(nLevels) {
    signal input enabled;
    signal input root;
    signal input siblings[nLevels];
    signal input oldKey;
    signal input oldValue;
    signal input isOld0;
    signal input key;
    signal input value;
    signal input fnc;

    component verifier = SMTVerifier(nLevels);
    verifier.enabled <== enabled;
    verifier.root <== root;
    verifier.oldKey <== oldKey;
    verifier.oldValue <== oldValue;
    verifier.isOld0 <== isOld0;
    verifier.key <== key;
    verifier.value <== value;
    verifier.fnc <== fnc;

    for(var i = 0; i < nLevels; i++) {
        verifier.siblings[i] <== siblings[i];
    }
}
