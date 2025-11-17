package vn.doan.hrm.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import vn.doan.hrm.domain.Training;

@Repository
public interface TrainingRepository extends JpaRepository<Training, Long> {
}
