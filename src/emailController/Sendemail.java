package emailController;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.apache.log4j.Logger;
import JZW.User;

import org.apache.commons.net.smtp.SMTPClient;
import org.apache.commons.net.smtp.SMTPReply;
import org.xbill.DNS.Lookup;
import org.xbill.DNS.Record;
import org.xbill.DNS.Type;


public class Sendemail {
	
	private static String from = "lhw981121@foxmail.com";
	private static String password = "mnnimlualsrshibf";
	private static String to = "";
	private static String title = "";
	private static String content = "";
	private static Logger logger = Logger.getLogger(User.class);	//输出日志
    
    @SuppressWarnings("static-access")
	public boolean send(String to,String title,String content) throws Exception{
    	//if(!checkEmail(to))	return false;
    	this.to=to;
    	this.title=title;
    	this.content=content;
    	Properties prop = new Properties();
        /*prop.setProperty("mail.host", "smtp.qq.com");
        prop.setProperty("mail.transport.protocol", "smtp");
        prop.setProperty("mail.smtp.auth", "true");*/
        //使用465端口发送邮件
        prop.setProperty("mail.host", "smtp.qq.com");
        prop.setProperty("mail.transport.protocol", "smtp");
        prop.setProperty("mail.smtp.auth", "true");//开启认证
        //prop.setProperty("mail.debug", "true");//启用调试
        prop.setProperty("mail.smtp.timeout", "10000");//设置链接超时
        prop.setProperty("mail.smtp.port", "465");//设置端口
        prop.setProperty("mail.smtp.socketFactory.port", "465");//设置ssl端口
        prop.setProperty("mail.smtp.socketFactory.fallback", "false");
        prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        //使用JavaMail发送邮件的5个步骤
        //1、创建session
        Session session = Session.getInstance(prop);
        //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
        //session.setDebug(true);
        //2、通过session得到transport对象
        Transport ts = session.getTransport();
        //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
        ts.connect("smtp.qq.com", from , password);
        //4、创建邮件
        Message message = createSimpleMail(session);
        if(message==null) return false;
        //5、发送邮件
        ts.sendMessage(message, message.getAllRecipients());
        ts.close();
        logger.info("神葳总局成功给 "+to+" 发送邮件！");
        return true;
    }
    
	public static MimeMessage createSimpleMail(Session session) throws Exception{
        //创建邮件对象
        MimeMessage message = new MimeMessage(session);
        /*//指明邮件的发件人
        message.setFrom(new InternetAddress(from));*/
    	//设置自定义发件人昵称  
        String nick="";  
        try {  
            nick=javax.mail.internet.MimeUtility.encodeText("神葳总局");  
        } catch (UnsupportedEncodingException e) {  
            e.printStackTrace();  
        }
		message.setFrom(new InternetAddress(nick+" <"+from+">"));
		//指明邮件的收件人
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        //设置发送日期  
        message.setSentDate(new Date()); 
        //邮件的标题
        message.setSubject(title);
        //邮件的文本内容
        message.setContent(content, "text/html;charset=UTF-8");
        //返回创建好的邮件对象
        return message;
        //指明邮件的收件人
        /*InternetAddress[] tos= new InternetAddress[address.length];
        for (int i = 0; i < address.length; i++) {
            if(!address[i].trim().matches("^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)+$")){
        System.exit(-1);
            }
            tos[i] = new InternetAddress(address[i].trim());
        }
        mimeMsg.setRecipients(MimeMessage.RecipientType.TO,tos);//设置收件人，抄送*/        
    }
	
	
	public boolean checkEmail(String email) {
        if (!email.matches("[\\w\\.\\-]+@([\\w\\-]+\\.)+[\\w\\-]+")) {
            return false;
        }

        String host = "";
        String hostName = email.split("@")[1];
        Record[] result = null;
        SMTPClient client = new SMTPClient();

        try {
            // 查找MX记录
            Lookup lookup = new Lookup(hostName, Type.MX);
            lookup.run();
            if (lookup.getResult() != Lookup.SUCCESSFUL) {
                return false;
            } else {
                result = lookup.getAnswers();
            }

            // 连接到邮箱服务器
            for (int i = 0; i < result.length; i++) {
                host = result[i].getAdditionalName().toString();
                client.connect(host);
                if (!SMTPReply.isPositiveCompletion(client.getReplyCode())) {
                    client.disconnect();
                    continue;
                } else {
                    break;
                }
            }

            //以下2项自己填写快速的，有效的邮箱
            client.login("163.com");
            client.setSender("sxgkwei@163.com");
            client.addRecipient(email);
            if (250 == client.getReplyCode()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                client.disconnect();
            } catch (IOException e) {
            }
        }
        return false;
    }
	
	
	
	/*public boolean checkEmail(String email) {
        if (!email.matches("[\\w\\.\\-]+@([\\w\\-]+\\.)+[\\w\\-]+")) {
            logger.error("邮箱（"+email+"）校验未通过，格式不对!");
            return false;
        }
        String host = "";
        String hostName = email.split("@")[1];
        //Record: A generic DNS resource record. The specific record types 
        //extend this class. A record contains a name, type, class, ttl, and rdata.
        Record[] result = null;
        SMTPClient client = new SMTPClient();
        try {
            // 查找DNS缓存服务器上为MX类型的缓存域名信息
            Lookup lookup = new Lookup(hostName, Type.MX);
            lookup.run();
            if (lookup.getResult() != Lookup.SUCCESSFUL) {//查找失败
                logger.error("邮箱（"+email+"）校验未通过，未找到对应的MX记录!");
                return false;
            } else {//查找成功
                result = lookup.getAnswers();
            }
            //尝试和SMTP邮箱服务器建立Socket连接
            for (int i = 0; i < result.length; i++) {
                host = result[i].getAdditionalName().toString();
                logger.info("SMTPClient try connect to host:"+host);
                
                //此connect()方法来自SMTPClient的父类:org.apache.commons.net.SocketClient
                //继承关系结构：org.apache.commons.net.smtp.SMTPClient-->org.apache.commons.net.smtp.SMTP-->org.apache.commons.net.SocketClient
                //Opens a Socket connected to a remote host at the current default port and 
                //originating from the current host at a system assigned port. Before returning,
                //_connectAction_() is called to perform connection initialization actions. 
                //尝试Socket连接到SMTP服务器
                client.connect(host);
                //Determine if a reply code is a positive completion response（查看响应码是否正常）. 
                //All codes beginning with a 2 are positive completion responses（所有以2开头的响应码都是正常的响应）. 
                //The SMTP server will send a positive completion response on the final successful completion of a command. 
                if (!SMTPReply.isPositiveCompletion(client.getReplyCode())) {
                    //断开socket连接
                    client.disconnect();
                    continue;
                } else {
                    logger.info("找到MX记录:"+hostName);
                    logger.info("建立链接成功："+hostName);
                    break;
                }
            }
            logger.info("SMTPClient ReplyString:"+client.getReplyString());
            String emailSuffix="163.com";
            String emailPrefix="ranguisheng";
            String fromEmail = emailPrefix+"@"+emailSuffix; 
            //Login to the SMTP server by sending the HELO command with the given hostname as an argument. 
            //Before performing any mail commands, you must first login. 
            //尝试和SMTP服务器建立连接,发送一条消息给SMTP服务器
            client.login(emailPrefix);
            logger.info("SMTPClient login:"+emailPrefix+"...");
            logger.info("SMTPClient ReplyString:"+client.getReplyString());
            
            //Set the sender of a message using the SMTP MAIL command, 
            //specifying a reverse relay path. 
            //The sender must be set first before any recipients may be specified, 
            //otherwise the mail server will reject your commands. 
            //设置发送者，在设置接受者之前必须要先设置发送者
            client.setSender(fromEmail);
            logger.info("设置发送者 :"+fromEmail);
            logger.info("SMTPClient ReplyString:"+client.getReplyString());
 
            //Add a recipient for a message using the SMTP RCPT command, 
            //specifying a forward relay path. The sender must be set first before any recipients may be specified, 
            //otherwise the mail server will reject your commands. 
            //设置接收者,在设置接受者必须先设置发送者，否则SMTP服务器会拒绝你的命令
            client.addRecipient(email);
            logger.info("设置接收者:"+email);
            logger.info("SMTPClient ReplyString:"+client.getReplyString());
            logger.info("SMTPClient ReplyCode："+client.getReplyCode()+"(250表示正常)");
            if (250 == client.getReplyCode()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                client.disconnect();
            } catch (IOException e) {
            }
        }
        return false;
    }*/

	
}