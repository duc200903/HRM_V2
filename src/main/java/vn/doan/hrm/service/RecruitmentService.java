package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.Recruitment;
import vn.doan.hrm.repository.RecruitmentRepository;

import java.util.List;
import java.util.Optional;

@Service
public class RecruitmentService {

    @Autowired
    private RecruitmentRepository recruitmentRepository;

    public List<Recruitment> getAllRecruitments() {
        return recruitmentRepository.findAll();
    }

    public Optional<Recruitment> getRecruitmentById(Long id) {
        return recruitmentRepository.findById(id);
    }

    public Recruitment saveRecruitment(Recruitment recruitment) {
        return recruitmentRepository.save(recruitment);
    }

    public void deleteRecruitment(Long id) {
        recruitmentRepository.deleteById(id);
    }
}
