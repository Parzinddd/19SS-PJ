package DB;



import it.sauronsoftware.base64.Base64;

import java.io.UnsupportedEncodingException;


public class Base64Util {

    // 字符串编码
    private static final String UTF_8 = "UTF-8";

     //加密字符串
    public static String decodeData(String inputData) {
        try {
            if (null == inputData) {
                return null;
            }
            return new String(Base64.encode(inputData.getBytes(UTF_8)), UTF_8);
        } catch (UnsupportedEncodingException e) {
        }
        return null;
    }


     // 解密加密后的字符串

    public static String encodeData(String inputData) {
        try {
            if (null == inputData) {
                return null;
            }
            return new String(Base64.decode(inputData.getBytes(UTF_8)), UTF_8);
        } catch (UnsupportedEncodingException e) {
        }
        return null;
    }
}