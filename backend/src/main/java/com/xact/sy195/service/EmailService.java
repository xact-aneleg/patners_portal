package com.xact.sy195.service;

import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired(required = false)
    private JavaMailSender mailSender;

    @Value("${portal.notification.email-enabled:false}")
    private boolean emailEnabled;

    @Value("${portal.notification.default-email:aneleg@xacterp.co.za}")
    private String defaultEmail;

    @Value("${portal.app.url:http://localhost:5173}")
    private String appUrl;

    public void send(String subject, String body) {
        if (!emailEnabled || mailSender == null) return;
        try {
            MimeMessage mime = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mime, true, "UTF-8");
            helper.setTo(defaultEmail);
            helper.setSubject("[XactERP Portal] " + subject);
            helper.setFrom("noreply@xacterp.co.za");
            helper.setText(buildHtml(subject, body), true);
            mailSender.send(mime);
        } catch (Exception e) {
            System.err.println("Email notification failed: " + e.getMessage());
        }
    }

    private String buildHtml(String subject, String body) {
        String portalUrl = appUrl + "/#portal";
        return "<!DOCTYPE html>" +
            "<html lang='en'><head><meta charset='UTF-8'>" +
            "<meta name='viewport' content='width=device-width,initial-scale=1'>" +
            "<title>" + subject + "</title></head>" +
            "<body style='margin:0;padding:0;background:#f4f6f8;font-family:Arial,Helvetica,sans-serif;'>" +

            // Outer wrapper
            "<table width='100%' cellpadding='0' cellspacing='0' style='background:#f4f6f8;padding:32px 0;'><tr><td align='center'>" +
            "<table width='560' cellpadding='0' cellspacing='0' style='max-width:560px;width:100%;'>" +

            // Header
            "<tr><td style='background:#364553;border-radius:10px 10px 0 0;padding:24px 32px;'>" +
            "<table width='100%' cellpadding='0' cellspacing='0'><tr>" +
            "<td><span style='font-size:20px;font-weight:800;color:#ffffff;letter-spacing:0.02em;'>XACT</span>" +
            "<span style='font-size:20px;font-weight:800;color:#3aaa35;'>ERP</span>" +
            "<span style='font-size:13px;color:rgba(255,255,255,0.45);font-weight:600;margin-left:6px;'>Partner Portal</span></td>" +
            "</tr></table></td></tr>" +

            // Green accent bar
            "<tr><td style='background:#3aaa35;height:4px;'></td></tr>" +

            // Body
            "<tr><td style='background:#ffffff;padding:32px;border-left:1px solid #e2e8f0;border-right:1px solid #e2e8f0;'>" +
            "<h2 style='margin:0 0 16px;font-size:18px;font-weight:700;color:#1a2733;'>" + escHtml(subject) + "</h2>" +
            "<p style='margin:0 0 24px;font-size:15px;color:#475a68;line-height:1.6;'>" + escHtml(body) + "</p>" +

            // CTA button
            "<table cellpadding='0' cellspacing='0'><tr><td style='border-radius:8px;background:#3aaa35;'>" +
            "<a href='" + portalUrl + "' target='_blank' " +
            "style='display:inline-block;padding:12px 28px;font-size:14px;font-weight:700;" +
            "color:#ffffff;text-decoration:none;border-radius:8px;letter-spacing:0.02em;'>" +
            "Go to Partner Portal →</a></td></tr></table>" +

            "<p style='margin:24px 0 0;font-size:12px;color:#9baab7;'>If the button above doesn't work, " +
            "copy and paste this link into your browser:<br>" +
            "<a href='" + portalUrl + "' style='color:#3aaa35;word-break:break-all;'>" + portalUrl + "</a></p>" +
            "</td></tr>" +

            // Footer
            "<tr><td style='background:#f4f6f8;border:1px solid #e2e8f0;border-top:none;" +
            "border-radius:0 0 10px 10px;padding:18px 32px;text-align:center;'>" +
            "<p style='margin:0;font-size:12px;color:#9baab7;'>" +
            "This is an automated notification from <strong style='color:#364553;'>XactERP Partner Portal</strong>.<br>" +
            "You are receiving this because you are registered as a portal user." +
            "</p></td></tr>" +

            "</table></td></tr></table>" +
            "</body></html>";
    }

    private String escHtml(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;");
    }
}
