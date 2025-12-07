package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.Attendance;
import vn.doan.hrm.repository.AttendanceRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class AttendanceService {

    @Autowired
    private AttendanceRepository attendanceRepository;

    // Lấy danh sách chấm công theo ngày
    public List<Attendance> getAttendanceByDate(LocalDate date) {
        return attendanceRepository.findByDate(date);
    }

    // Lấy tất cả chấm công
    public List<Attendance> getAllAttendances() {
        return attendanceRepository.findAll();
    }    // Lấy attendance theo ID
    public Optional<Attendance> getAttendanceById(Long id) {
        return attendanceRepository.findById(id);
    }

    //  Lấy chấm công theo employee
    public List<Attendance> getAttendanceByEmployee(Long employeeId) {
        return attendanceRepository.findByEmployeeId(employeeId);
    }    //  Lấy chấm công theo employee và tháng hiện tại
    public List<Attendance> getCurrentMonthAttendancesByEmployee(Long employeeId) {
        LocalDate now = LocalDate.now();
        LocalDate startOfMonth = now.withDayOfMonth(1);
        LocalDate endOfMonth = now.withDayOfMonth(now.lengthOfMonth());
        return attendanceRepository.findByEmployeeIdAndDateBetween(employeeId, startOfMonth, endOfMonth);
    }

    //  Lưu attendance
    public Attendance saveAttendance(Attendance attendance) {
        return attendanceRepository.save(attendance);
    }
}
