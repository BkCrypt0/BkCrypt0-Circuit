// SPDX-License-Identifier: GPL-3.0
pragma circom 2.0.0;

include "../../../node_modules/circomlib/circuits/smt/smtverifier.circom";
include "../util/verifyInputs.circom";

template ProvePlaces() {
    signal input BirthPlace;
    signal input placesExpecting;

    component optionBits = Num2Bits(64);
    optionBits.in <== placesExpecting;

    var checkSum = 0;
    component eq[64];
    for (var i=1; i<64; i++) {
        eq[i] = IsEqual();
        eq[i].in[0] <== i * optionBits.out[i];
        eq[i].in[1] <== BirthPlace;
        
        checkSum = checkSum + eq[i].out;
    }
    signal a <== checkSum;
    a === 1;
}

template VerifyPlaces(nLevels) {
    signal input rootRevoke;
    signal input siblingsRevoke[nLevels];
    signal input oldKeyRevoke;
    signal input oldValueRevoke;
    signal input isOld0Revoke;

    signal input rootClaims;
    signal input siblingsClaims[nLevels];

    signal input key;
    signal input value;

    signal input publicKey[2];
    signal input CCCD;
    signal input sex;
	signal input DoBdate; //
    signal input BirthPlace;

    signal input placesExpecting;   
    
    signal input challenge; //

    signal input R8x;
    signal input R8y;
    signal input S;
    
    signal input expireTime;
    signal input message;        

    component verifierInputs = VerifierInputs();
    verifierInputs.value <== value;
    
    verifierInputs.publicKey[0] <== publicKey[0];
    verifierInputs.publicKey[1] <== publicKey[1];
    verifierInputs.CCCD <== CCCD;
    verifierInputs.sex <== sex;
    verifierInputs.DoBdate <== DoBdate;
    verifierInputs.BirthPlace <== BirthPlace;
    
    verifierInputs.R8x <== R8x;
    verifierInputs.R8y <== R8y;
    verifierInputs.S <== S;

    verifierInputs.expireTime <== expireTime;
    verifierInputs.message <== message;

 /*

*/
    component verifierRevoke = SMTVerifier(nLevels);
    verifierRevoke.enabled <== 1;
    verifierRevoke.root <== rootRevoke;
    verifierRevoke.oldKey <== oldKeyRevoke;
    verifierRevoke.oldValue <== oldValueRevoke;
    verifierRevoke.isOld0 <== isOld0Revoke;

    verifierRevoke.key <== key;
    verifierRevoke.value <== value;
    verifierRevoke.fnc <== 1;

    for(var i = 0; i < nLevels; i++) {
        verifierRevoke.siblings[i] <== siblingsRevoke[i];
    }

/*

*/
    component verifierClaims = SMTVerifier(nLevels);
    verifierClaims.enabled <== 1;
    verifierClaims.root <== rootClaims;
    verifierClaims.oldKey <== 0;
    verifierClaims.oldValue <== 0;
    verifierClaims.isOld0 <== 0;

    verifierClaims.key <== key;
    verifierClaims.value <== value;
    verifierClaims.fnc <== 0;

    for(var i = 0; i < nLevels; i++) {
        verifierClaims.siblings[i] <== siblingsClaims[i];
    }
    
    component provePlaces = ProvePlaces();
    
    provePlaces.BirthPlace <== BirthPlace;
    
    provePlaces.placesExpecting <== placesExpecting;
    

    signal challenges <== challenge * challenge;
}


