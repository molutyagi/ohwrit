/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ohwrite.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

	private static File file = null;

	public static boolean deleteFile(String filePath) {
		boolean f = false;

		try {
			file = new File(filePath);
			f = file.delete();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}

	public static boolean saveFile(InputStream is, String filePath) {
		boolean f = false;

		try {
			byte b[] = new byte[is.available()];
			is.read(b);

			FileOutputStream fos = new FileOutputStream(filePath);
			fos.write(b);
			fos.flush();

			fos.close();
			f = true;

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}
}
