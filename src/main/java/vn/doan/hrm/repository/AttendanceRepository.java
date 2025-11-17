package vn.doan.hrm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.Attendance;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface AttendanceRepository extends JpaRepository<Attendance, Long> {

    List<Attendance> findByDate(LocalDate date);

    Optional<Attendance> findByEmployeeIdAndDate(Long employeeId, LocalDate date);    List<Attendance> findByEmployeeIdAndDateBetween(Long employeeId, LocalDate startDate, LocalDate endDate);
      // ✅ Lấy chấm công theo employee
    List<Attendance> findByEmployeeId(Long employeeId);
}