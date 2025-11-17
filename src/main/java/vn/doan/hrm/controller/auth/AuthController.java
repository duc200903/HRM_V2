package vn.doan.hrm.controller.auth;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String showLoginPage(HttpServletRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        // Nếu đã đăng nhập rồi (không phải anonymous)
        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {

            // Kiểm tra role để redirect phù hợp
            for (GrantedAuthority authority : auth.getAuthorities()) {
                String role = authority.getAuthority();

                if (role.equals("ROLE_ADMIN")) {
                    return "redirect:/admin/dashboard";
                } else if (role.equals("ROLE_HR")) {
                    return "redirect:/admin/recruitment";
                } else if (role.equals("ROLE_MANAGER")) {
                    return "redirect:/manager/performance";
                }
            }

            // Nếu không khớp role nào → về trang login
            return "redirect:/login";
        }

        // Nếu chưa đăng nhập → hiển thị trang login.jsp
        return "auth/login";
    }
}
