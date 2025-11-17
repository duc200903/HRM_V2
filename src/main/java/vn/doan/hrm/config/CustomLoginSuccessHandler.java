package vn.doan.hrm.config;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import org.springframework.security.core.*;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import vn.doan.hrm.service.CustomUserDetails;

import java.io.IOException;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();        String redirectUrl = "/";
        switch (userDetails.getUser().getRole()) {
            case admin -> redirectUrl = "/admin/dashboard";
            case hr -> redirectUrl = "/admin/dashboard";
            case manager -> redirectUrl = "/admin/dashboard";
            case employee -> redirectUrl = "/home";
            default -> redirectUrl = "/";
        }

        response.sendRedirect(redirectUrl);
    }
}
