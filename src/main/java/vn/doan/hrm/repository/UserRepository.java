package vn.doan.hrm.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    List<User> findOneByEmail(String email);

    List<User> findAll();

    boolean existsByEmail(String email);

    // Thêm method đếm theo role
    long countByRole(User.Role role);

    Optional<User> findByEmail(String email);

    Optional<User> findByUsername(String username);
}