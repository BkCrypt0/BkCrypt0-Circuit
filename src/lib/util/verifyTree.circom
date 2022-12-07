pragma circom 2.0.0;
include "../../../node_modules/circomlib/circuits/eddsamimc.circom";
include "../../../node_modules/circomlib/circuits/mimc.circom";
include "smtverifier.circom";

template VerifyUserServicesSignature() {

    signal input value;
    
    signal input CCCD;
    signal input sex;
    signal input DoBdate;
    signal input BirthPlace;

    signal input publicKey[2];

    signal input enabled;
    signal input R8x;
    signal input R8y;
    signal input S;
    

    component mimc = MultiMiMC7(6, 91);
    mimc.in[0] <== publicKey[0];
    mimc.in[1] <== publicKey[1];
    mimc.in[2] <== CCCD;
    mimc.in[3] <== sex;
    mimc.in[4] <== DoBdate;
    mimc.in[5] <== BirthPlace;
    mimc.k <== 0;
    (value - mimc.out) * enabled === 0;

    component verifierSig = EdDSAMiMCVerifier();
    verifierSig.enabled <== enabled;
    verifierSig.Ax <== publicKey[0];
    verifierSig.Ay <== publicKey[1];
    
    verifierSig.S <== S;
    verifierSig.R8x <== R8x;
    verifierSig.R8y <== R8y;
    
    verifierSig.M <== value;
}

template VerifyNewRootClaim(numbers, nLevels) {
    signal input root;
    signal input siblings[numbers][nLevels];
    signal input enabled[numbers];

    signal input keys[numbers];
    signal input values[numbers];
        
    signal input informations[numbers][6];

    signal input signatures[numbers][3];

    component verifier[numbers];

    for(var i = 0; i < numbers; i++) {
        verifier[i] = VerifyUserServicesSignature();
        verifier[i].value <== values[i];
        verifier[i].publicKey[0] <== informations[i][0];
        verifier[i].publicKey[1] <== informations[i][1];
        verifier[i].CCCD <== informations[i][2];
        verifier[i].sex <== informations[i][3];
        verifier[i].DoBdate <== informations[i][4];
        verifier[i].BirthPlace <== informations[i][5];
        verifier[i].enabled <==enabled[i];
        verifier[i].R8x <== signatures[i][0];
        verifier[i].R8y <== signatures[i][1];
        verifier[i].S <== signatures[i][2];
    }

    component verifierRoot[numbers];
    for(var i = 0; i < numbers; i++) {
        verifierRoot[i] = SMTVerifier(nLevels);
        verifierRoot[i].enabled <== enabled[i];
        verifierRoot[i].root <== root;
        verifierRoot[i].oldKey <== 0;
        verifierRoot[i].oldValue <== 0;
        verifierRoot[i].isOld0 <== 0;

        verifierRoot[i].key <== keys[i];
        verifierRoot[i].value <== values[i];
        verifierRoot[i].fnc <== 0;
        for(var j = 0; j < nLevels; j++) {
            verifierRoot[i].siblings[j] <== siblings[i][j];
        }
    }
}

template VerifyNewRootRevoke(numbers, nLevels) {
    signal input root;
    signal input siblings[numbers][nLevels];
    signal input enabled[numbers];

    signal input keys[numbers];
    signal input values[numbers];
    signal input fnc[numbers];

    component verifierRoot[numbers];
    for(var i = 0; i < numbers; i++) {
        verifierRoot[i] = SMTVerifier(nLevels);
        verifierRoot[i].enabled <== enabled[i];
        verifierRoot[i].root <== root;
        verifierRoot[i].oldKey <== 0;
        verifierRoot[i].oldValue <== 0;
        verifierRoot[i].isOld0 <== 0;

        verifierRoot[i].key <== keys[i];
        verifierRoot[i].value <== values[i];
        verifierRoot[i].fnc <== fnc[i];
        for(var j = 0; j < nLevels; j++) {
            verifierRoot[i].siblings[j] <== siblings[i][j];
        }
    }
}

template VerifyNewRootUnrevoke(nLevels) {
    signal input root;
    signal input siblings[nLevels];
    signal input oldKey;
    signal input oldValue;
    signal input isOld0;
    signal input key;

    component verifierRoot;
    verifierRoot = SMTVerifier(nLevels);
    verifierRoot.enabled <== 1;
    verifierRoot.root <== root;
    verifierRoot.oldKey <== oldKey;
    verifierRoot.oldValue <== isOld0;
    verifierRoot.isOld0 <== isOld0;

    verifierRoot.key <== key;
    verifierRoot.value <== 0;
    verifierRoot.fnc <== 1;
    for(var i = 0; i < nLevels; i++) {
        verifierRoot.siblings[i] <== siblings[i];
    }
    
} 