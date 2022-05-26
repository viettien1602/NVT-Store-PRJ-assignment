/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author admin
 */
public class Validators {
    public static boolean validatePhone(String phone) {
        boolean check = true;
        for (int i = 0; i < phone.length(); i++) {
            if (phone.charAt(i) < '0' || phone.charAt(i) > '9') {
                check = false;
                break;
            }
        }
        return check;
    }
    
    public static boolean checkDate(String importDate, String expiredDate) throws ParseException {
        boolean check = true;
        Date importD, expiredD;
        Date today = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        try {
            importD = sdf.parse(importDate);
            expiredD = sdf.parse(expiredDate);
            if (importD.compareTo(today) > 0) check = false;
            if (expiredD.compareTo(today) < 0) check = false;
        }
        catch(Exception e) {
            
        }
        return check;
    }
}
