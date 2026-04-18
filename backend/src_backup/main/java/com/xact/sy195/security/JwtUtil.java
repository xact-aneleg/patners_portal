package com.xact.sy195.security;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import javax.crypto.SecretKey;
import java.util.Date;

@Component
public class JwtUtil {
    @Value("${portal.jwt.secret}")   private String secret;
    @Value("${portal.jwt.expiration-ms}") private long expirationMs;
    private SecretKey key() { return Keys.hmacShaKeyFor(secret.getBytes()); }

    public String generateToken(String email, String role, Long partnerId) {
        return Jwts.builder().subject(email).claim("role",role).claim("partnerId",partnerId)
                .issuedAt(new Date()).expiration(new Date(System.currentTimeMillis()+expirationMs))
                .signWith(key()).compact();
    }
    public Claims parseToken(String token) {
        return Jwts.parser().verifyWith(key()).build().parseSignedClaims(token).getPayload();
    }
    public boolean isValid(String token) {
        try { parseToken(token); return true; } catch (Exception e) { return false; }
    }
    public String getEmail(String token)   { return parseToken(token).getSubject(); }
    public String getRole(String token)    { return parseToken(token).get("role",String.class); }
    public Long getPartnerId(String token) { return parseToken(token).get("partnerId",Long.class); }
}
