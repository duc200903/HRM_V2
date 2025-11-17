package vn.doan.hrm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.doan.hrm.domain.PerformanceReview;
import vn.doan.hrm.repository.PerformanceReviewRepository;

import java.util.List;
import java.util.Optional;

@Service
public class PerformanceReviewService {

    @Autowired
    private PerformanceReviewRepository reviewRepository;

    public List<PerformanceReview> getAllReviews() {
        return reviewRepository.findAll();
    }

    public Optional<PerformanceReview> getReviewById(Long id) {
        return reviewRepository.findById(id);
    }

    public PerformanceReview saveReview(PerformanceReview review) {
        return reviewRepository.save(review);
    }

    public void deleteReview(Long id) {
        reviewRepository.deleteById(id);
    }
}
