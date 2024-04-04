package com.ohwrite.security;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class SaltingAndHashing {

	public byte[] generateSalt() {
		byte[] salt = new byte[16];

		SecureRandom random = new SecureRandom();
		random.nextBytes(salt);

		return salt;
	}

	public String texttoHash(String text, byte[] salt) throws NoSuchAlgorithmException {
		byte[] hashedString;

		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(salt);
		hashedString = md.digest(text.getBytes());

		return Base64.getEncoder().encodeToString(hashedString);

	}
}
