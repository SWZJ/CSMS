package phoneController;

import java.net.URLEncoder;

import org.apache.log4j.Logger;

import JZW.User;


public class PhoneCode {
	
    private static Logger logger = Logger.getLogger(User.class);	//输出日志
	
	// 根据相应的手机号发送验证码
	public boolean sendPhoneCode(String phone,String code) throws Exception {
		StringBuilder sb = new StringBuilder();
		sb.append("accountSid").append("=").append(Config.ACCOUNT_SID);
		sb.append("&to").append("=").append(phone);
		//sb.append("&param").append("=").append(URLEncoder.encode("","UTF-8"));
		//sb.append("&templateid").append("=").append("1251");
		sb.append("&smsContent").append("=").append( URLEncoder.encode("【神葳总局】尊敬的用户，您好，您的验证码为："+code+"，如非本人操作，请忽略此短信。","UTF-8"));
		String body = sb.toString() + HttpUtil.createCommonParam(Config.ACCOUNT_SID, Config.AUTH_TOKEN);
		String result = HttpUtil.post(Config.BASE_URL, body);
		if(result.indexOf("成功")!=-1) {
			logger.info(result+"\n发送验证码 "+code+" 给 "+phone+"成功！");
			return true;
		}else {
			logger.error(result+"\n发送验证码 "+code+" 给 "+phone+"失败！");
			return false;
		}
		
	}
 
	// 创建验证码
	public static String smsCode() {
		String random = (int) ((Math.random() * 9 + 1) * 100000) + "";
		return random;
	}
}
 


