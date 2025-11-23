package br.com.neurosync.api.dto;

public class AuthResponse {
    private String token;
    private String type = "Bearer";
    private Long expiresIn;

    public AuthResponse(String token, Long expiresIn) {
        this.token = token;
        this.expiresIn = expiresIn;
    }

    public String getToken() {
        return token;
    }

    public String getType() {
        return type;
    }

    public Long getExpiresIn() {
        return expiresIn;
    }
}
