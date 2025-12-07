package vn.doan.hrm.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;

import jakarta.validation.Valid;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder; // Hiển thị trang quản lý user (Chỉ Admin accounts)

    @GetMapping
    public String showUsers(Model model) {
        List<User> users = userService.getAllUsers();

        List<User> adminUsers = users.stream()
                .filter(u -> u.getRole() == User.Role.admin)
                .collect(Collectors.toList());

        model.addAttribute("users", adminUsers);

        // Statistics - Chỉ đếm admin
        model.addAttribute("totalUsers", adminUsers.size());
        model.addAttribute("totalAdmins", adminUsers.size());
        model.addAttribute("totalEmployees", userService.countUsersByRole(User.Role.employee));

        return "admin/user/show";
    }

    //  Hiển thị form tạo user mới
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    //  Xử lý tạo user mới
    @PostMapping("/create")
    public String createUser(@Valid @ModelAttribute("newUser") User user,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        //  CHỈ CHO PHÉP TẠO ADMIN ACCOUNTS
        if (user.getRole() != User.Role.admin) {
            bindingResult.rejectValue("role", "error.user",
                    "Không thể tạo tài khoản nhân viên từ đây. Vui lòng sử dụng 'Quản lý nhân viên' để tạo tài khoản nhân viên.");
            return "admin/user/create";
        }

        // Kiểm tra validation errors
        if (bindingResult.hasErrors()) {
            return "admin/user/create";
        }

        // Kiểm tra email đã tồn tại
        if (userService.existsByEmail(user.getEmail())) {
            bindingResult.rejectValue("email", "error.user", "Email đã tồn tại trong hệ thống!");
            return "admin/user/create";
        }

        try {
            // Mã hóa password và lưu user
            user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash()));
            userService.saveUser(user);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Thêm người dùng '" + user.getUsername() + "' thành công!");
            return "redirect:/admin/user";
        } catch (Exception e) {
            bindingResult.rejectValue("username", "error.user", "Có lỗi xảy ra: " + e.getMessage());
            return "admin/user/create";
        }
    }

    @GetMapping("/detail/{id}")
    public String showUserDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = userService.getUserById(id);
        if (!userOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + id);
            return "redirect:/admin/user";
        }

        model.addAttribute("user", userOpt.get());
        model.addAttribute("id", id);
        return "admin/user/detail";
    }

    // Hiển thị form cập nhật user
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = userService.getUserById(id);
        if (!userOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + id);
            return "redirect:/admin/user";
        }

        model.addAttribute("newUser", userOpt.get());
        return "admin/user/update";
    }

    // Xử lý cập nhật user
    @PostMapping("/update")
    public String updateUser(@Valid @ModelAttribute("newUser") User user,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        // Tìm user hiện tại
        Optional<User> existingUserOpt = userService.getUserById(user.getId());
        if (!existingUserOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng!");
            return "redirect:/admin/user";
        }

        User existingUser = existingUserOpt.get();

        // Kiểm tra email trùng lặp (nếu email thay đổi)
        if (!existingUser.getEmail().equals(user.getEmail()) && userService.existsByEmail(user.getEmail())) {
            bindingResult.rejectValue("email", "error.user", "Email đã được sử dụng bởi người dùng khác!");
            return "admin/user/update";
        }

        try {
            // Cập nhật thông tin (giữ nguyên password cũ)
            existingUser.setUsername(user.getUsername());
            existingUser.setEmail(user.getEmail());
            existingUser.setRole(user.getRole());

            userService.saveUser(existingUser);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Cập nhật người dùng '" + existingUser.getUsername() + "' thành công!");
            return "redirect:/admin/user";
        } catch (Exception e) {
            bindingResult.rejectValue("username", "error.user", "Có lỗi xảy ra: " + e.getMessage());
            return "admin/user/update";
        }
    }

    // Hiển thị form xác nhận xóa
    @GetMapping("/delete/{id}")
    public String showDeleteForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = userService.getUserById(id);
        if (!userOpt.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng với ID: " + id);
            return "redirect:/admin/user";
        }

        User user = userOpt.get();
        if (user.getRole() == User.Role.admin) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa tài khoản Admin!");
            return "redirect:/admin/user";
        }

        model.addAttribute("newUser", user);
        model.addAttribute("id", id);
        model.addAttribute("name", user.getUsername());
        return "admin/user/delete";
    }

    // Xử lý xóa user
    @PostMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Optional<User> userOpt = userService.getUserById(id);
            if (!userOpt.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy người dùng!");
                return "redirect:/admin/user";
            }

            User user = userOpt.get();
            if (user.getRole() == User.Role.admin) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa tài khoản Admin!");
                return "redirect:/admin/user";
            }

            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Xóa người dùng '" + user.getUsername() + "' thành công!");
            return "redirect:/admin/user";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi xóa: " + e.getMessage());
            return "redirect:/admin/user";
        }
    }
}