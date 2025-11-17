package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import vn.doan.hrm.domain.DepartmentTransfer;
import vn.doan.hrm.domain.Employee;
import vn.doan.hrm.domain.Department;
import vn.doan.hrm.repository.DepartmentTransferRepository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class DepartmentTransferService {

    @Autowired
    private DepartmentTransferRepository departmentTransferRepository;

    // Lưu lịch sử chuyển phòng ban
    @Transactional
    public DepartmentTransfer saveDepartmentTransfer(DepartmentTransfer transfer) {
        return departmentTransferRepository.save(transfer);
    }

    // Tạo record chuyển phòng ban mới
    @Transactional
    public DepartmentTransfer createDepartmentTransfer(Employee employee, 
                                                       Department fromDepartment, 
                                                       Department toDepartment, 
                                                       String reason) {
        DepartmentTransfer transfer = new DepartmentTransfer();
        transfer.setEmployee(employee);
        transfer.setFromDepartment(fromDepartment);
        transfer.setToDepartment(toDepartment);
        transfer.setReason(reason != null ? reason : "Chuyển phòng ban");
        transfer.setTransferDate(LocalDate.now());

        return saveDepartmentTransfer(transfer);
    }

    // Lấy lịch sử chuyển phòng ban của một nhân viên
    public List<DepartmentTransfer> getTransferHistoryByEmployee(Long employeeId) {
        return departmentTransferRepository.findByEmployeeIdWithDetails(employeeId);
    }

    // Lấy tất cả lịch sử chuyển phòng ban
    public List<DepartmentTransfer> getAllTransferHistory() {
        return departmentTransferRepository.findAllWithDetails();
    }

    // Lấy lịch sử chuyển phòng ban theo department
    public List<DepartmentTransfer> getTransferHistoryByDepartment(Long departmentId) {
        return departmentTransferRepository.findByDepartmentId(departmentId);
    }

    // Tìm transfer theo ID
    public Optional<DepartmentTransfer> getDepartmentTransferById(Long id) {
        return departmentTransferRepository.findById(id);
    }

    // Xóa lịch sử chuyển phòng ban
    @Transactional
    public void deleteDepartmentTransfer(Long id) {
        departmentTransferRepository.deleteById(id);
    }
}