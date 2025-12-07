package vn.doan.hrm.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import vn.doan.hrm.service.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration {

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider(CustomUserDetailsService userDetailsService) {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService); // Khi user nhập email + password → lấy user bằng
                                                            // CustomUserDetailsService
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(auth -> auth

                        //  Admin Management
                        .requestMatchers("/admin/user/**").hasRole("ADMIN")

                        //  Department Management & leave-requests
                       .requestMatchers("/admin/department/**").hasRole("ADMIN")
                        .requestMatchers("/admin/request-leave/**").hasRole("ADMIN")

                       //  Attendance
                        .requestMatchers("/admin/attendance/**").hasAnyRole("ADMIN", "HR")

                        //  Salary report
                        .requestMatchers("/admin/salary-report/**").hasAnyRole("ADMIN", "HR")
                        // Training
                        .requestMatchers("/admin/training/**").hasAnyRole("ADMIN", "HR")
                        //  Recruitment
                        .requestMatchers("/admin/recruitment/**").hasAnyRole("ADMIN", "HR")

                        //  Performance Review
                        .requestMatchers("/admin/performance-review/create",
                                "/admin/performance-review/update/**",
                                "/admin/performance-review/delete/**")
                        .hasRole("ADMIN")
                        .requestMatchers("/admin/performance-review",
                                "/admin/performance-review/detail/**")
                        .hasAnyRole("ADMIN", "MANAGER")

                        //  Employee Management
                        .requestMatchers("/admin/employee/create",
                                "/admin/employee/update/**",
                                "/admin/employee/delete/**")
                        .hasAnyRole("ADMIN", "HR")
                        .requestMatchers("/admin/employee", "/admin/employee/detail/**")
                        .hasAnyRole("ADMIN", "HR", "MANAGER")                        //  Dashboard
                        .requestMatchers("/admin/dashboard").hasAnyRole("ADMIN", "HR", "MANAGER")

                        //  User Personal Pages
                        .requestMatchers("/home", "/me", "/my-**").hasAnyRole("ADMIN", "HR", "MANAGER", "EMPLOYEE")

                        //  Allow public/static pages
                        .anyRequest().permitAll())
                .formLogin(form -> form
                        .loginPage("/login")
                        .successHandler(customLoginSuccessHandler())
                        .permitAll())
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .permitAll())
                .csrf(csrf -> csrf.disable());

        return http.build();
    }

    @Bean
    public CustomLoginSuccessHandler customLoginSuccessHandler() {
        return new CustomLoginSuccessHandler();
    }
}
