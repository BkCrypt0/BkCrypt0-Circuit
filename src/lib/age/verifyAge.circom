// SPDX-License-Identifier: GPL-3.0

pragma circom 2.0.0;

include "../../../node_modules/circomlib/circuits/smt/smtverifier.circom";
include "../util/verifyInputs.circom";
include "ageCalculation.circom";

template ProveAge() {
    signal input DoBdate;
    signal input minAge;  
    signal input maxAge;
    signal input currentYear;
    signal input currentMonth;
    signal input currentDay;

    // // calculate age
	component age = calculateAgeFromYYYYMMDD();
	age.yyyymmdd <== DoBdate;
	age.currentYear <== currentYear;
	age.currentMonth <== currentMonth;
	age.currentDay <== currentDay;
    // verify age > minAge
    component gteMinAge = GreaterEqThan(32);
    gteMinAge.in[0] <== age.age;
    gteMinAge.in[1] <== minAge;
    gteMinAge.out === 1;

    component mteMaxAge = GreaterEqThan(32);
    mteMaxAge.in[0] <== maxAge;
    mteMaxAge.in[1] <== age.age;
    mteMaxAge.out === 1;

}

template VerifyAge(nLevels) {
    signal input rootRevoke;
    signal input siblingsRevoke[nLevels];
    signal input oldKeyRevoke;
    signal input oldValueRevoke;
    signal input isOld0Revoke;

    signal input rootClaims;
    signal input siblingsClaims[nLevels];
    

    signal input key;
    signal input value; //leaf

	signal input publicKey[2];
    signal input CCCD;
    signal input sex;
	signal input DoBdate; //
    signal input BirthPlace;

    // signal input minAge, maxAge
    signal input minAge; //
    signal input maxAge;

    signal input challenge; // not include in proof

    signal input currentYear;
    signal input currentMonth;
    signal input currentDay;

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

/**/
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

    component proveAge = ProveAge();
    proveAge.DoBdate <== DoBdate;
    proveAge.minAge <== minAge;
    proveAge.maxAge <== maxAge;
    proveAge.currentYear <== currentYear;
    proveAge.currentMonth <== currentMonth;
    proveAge.currentDay <== currentDay;

    signal challenges <== challenge * challenge;
}
