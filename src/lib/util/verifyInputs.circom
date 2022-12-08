// SPDX-License-Identifier: GPL-3.0
pragma circom 2.0.0;

include "../../../node_modules/circomlib/circuits/mimc.circom";
include "../../../node_modules/circomlib/circuits/eddsamimc.circom";

template VerifierInputs() {
    signal input value; //leaf

	signal input publicKey[2];
    signal input CCCD;
    signal input sex;
	signal input DoBdate; //
    signal input BirthPlace;

    signal input R8x;
    signal input R8y;
    signal input S;
    
    signal input expireTime;
    signal input message;

    component mimc = MultiMiMC7(6, 91);
    mimc.in[0] <== publicKey[0];
    mimc.in[1] <== publicKey[1];
    mimc.in[2] <== CCCD;
    mimc.in[3] <== sex;
    mimc.in[4] <== DoBdate;
    mimc.in[5] <== BirthPlace;
    mimc.k <== 0;
    value === mimc.out;

    component mimcSig = MultiMiMC7(2, 91);
    mimcSig.in[0] <== value;
    mimcSig.in[1] <== expireTime;
    mimcSig.k <== 0;
    message === mimcSig.out;

    component verifierSig = EdDSAMiMCVerifier();
    verifierSig.enabled <== 1;
    verifierSig.Ax <== publicKey[0];
    verifierSig.Ay <== publicKey[1];
    
    verifierSig.S <== S;
    verifierSig.R8x <== R8x;
    verifierSig.R8y <== R8y;
    
    verifierSig.M <== message;
}

