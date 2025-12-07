package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.RequestLeave;
import vn.doan.hrm.repository.RequestLeaveRepository;

import java.util.List;
import java.util.Optional;

@Service
public class RequestLeaveService {

    @Autowired
    private RequestLeaveRepository requestLeaveRepository;

    public List<RequestLeave> getAllRequestLeaves() {
        return requestLeaveRepository.findAll();
    }

    public Optional<RequestLeave> getRequestLeaveById(Long id) {
        return requestLeaveRepository.findById(id);
    }

    public RequestLeave saveRequestLeave(RequestLeave requestLeave) {
        return requestLeaveRepository.save(requestLeave);
    }

    public void deleteRequestLeave(Long id) {
        requestLeaveRepository.deleteById(id);
    }

    public void approveRequest(Long id) {
        RequestLeave request = requestLeaveRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn xin nghỉ"));
        request.setStatus(RequestLeave.Status.approved);
        requestLeaveRepository.save(request);
    }

    public void rejectRequest(Long id) {
        RequestLeave request = requestLeaveRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn xin nghỉ"));
        request.setStatus(RequestLeave.Status.rejected);
        requestLeaveRepository.save(request);
    }

    //  Filter methods
    public List<RequestLeave> getRequestLeavesByYear(Integer year) {
        if (year == null) {
            return getAllRequestLeaves();
        }
        return requestLeaveRepository.findByLeaveYear(year);
    }

    public List<RequestLeave> getRequestLeavesByMonthAndYear(Integer month, Integer year) {
        if (month == null && year == null) {
            return getAllRequestLeaves();
        }
        if (month == null) {
            return getRequestLeavesByYear(year);
        }
        if (year == null) {
            // Nếu chỉ có tháng thì lấy tháng của năm hiện tại
            year = java.time.LocalDate.now().getYear();
        }
        return requestLeaveRepository.findByLeaveMonthAndLeaveYear(month, year);
    }

    public List<RequestLeave> getRequestLeavesWithFilters(Integer year, Integer month, String status) {
        RequestLeave.Status statusEnum = null;
        if (status != null && !status.trim().isEmpty() && !"all".equals(status)) {
            try {
                statusEnum = RequestLeave.Status.valueOf(status);
            } catch (IllegalArgumentException e) {
                // Ignore invalid status
            }
        }
        return requestLeaveRepository.findWithFilters(year, month, statusEnum);
    }    public List<Integer> getAvailableYears() {
        return requestLeaveRepository.findDistinctYears();
    }

    //  Lấy đơn nghỉ phép theo employee
    public List<RequestLeave> getRequestLeavesByEmployee(Long employeeId) {
        return requestLeaveRepository.findByEmployeeId(employeeId);
    }

    //  Lấy đơn nghỉ phép gần đây theo employee
    public List<RequestLeave> getRecentRequestLeavesByEmployee(Long employeeId, int limit) {
        var allRequests = requestLeaveRepository.findByEmployeeId(employeeId);
        return allRequests.stream()
                .sorted((a, b) -> b.getStartDate().compareTo(a.getStartDate())) // Sort by start date desc
                .limit(limit)
                .collect(java.util.stream.Collectors.toList());
    }
}
