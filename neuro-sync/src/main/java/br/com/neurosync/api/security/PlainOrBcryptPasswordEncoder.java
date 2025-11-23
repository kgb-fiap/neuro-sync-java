package br.com.neurosync.api.security;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * Permite autenticar senhas já cifradas em bcrypt ou armazenadas em texto simples (legado).
 */
public class PlainOrBcryptPasswordEncoder implements PasswordEncoder {

    private final BCryptPasswordEncoder delegate = new BCryptPasswordEncoder();

    @Override
    public String encode(CharSequence rawPassword) {
        return delegate.encode(rawPassword);
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        if (encodedPassword == null) {
            return false;
        }
        // tenta bcrypt
        try {
            if (delegate.matches(rawPassword, encodedPassword)) {
                return true;
            }
        } catch (Exception ignored) {
        }
        return encodedPassword.contentEquals(rawPassword);
    }
}
