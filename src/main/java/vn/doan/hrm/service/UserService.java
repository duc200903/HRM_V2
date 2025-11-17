package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.doan.hrm.domain.User;
import vn.doan.hrm.repository.UserRepository;

import java.util.List;
import java.util.Optional;

// import javax.transaction.Transactional;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    // Xóa user
    @Transactional
    public void deleteUser(Long id) {
        System.out.println("UserService: Đang xóa user ID " + id);
        if (userRepository.existsById(id)) {
            userRepository.deleteById(id);
            System.out.println("UserService: Đã xóa user ID " + id);
        } else {
            System.out.println("UserService: User ID " + id + " không tồn tại");
        }
    }

    public long countUsers() {
        return userRepository.count();
    }

    public long countUsersByRole(User.Role role) {
        return userRepository.countByRole(role);
    }

    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy người dùng với email: " + email));
    }
}
