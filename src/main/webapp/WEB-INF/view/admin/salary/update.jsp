<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.png" />
        <title>Cập nhật lương nhân viên - HRM System</title>
        <link href="/css/styles.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .readonly-field {
                background-color: #f8f9fa;
                color: #6c757d;
                cursor: not-allowed;
            }
            .editable-field {
                border: 2px solid #0d6efd;
                box-shadow: 0 0 4px rgba(13, 110, 253, 0.3);
            }
            .money-input {
                text-align: right;
                font-weight: 500;
            }
            .form-hint {
                font-size: 0.85rem;
                color: #6c757d;
            }
        </style>
    </head>
    <body class="sb-nav-fixed">
        <jsp:include page="/WEB-INF/view/layout/header.jsp" />
        <div id="layoutSidenav">
            <jsp:include page="/WEB-INF/view/layout/sidebar.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h4 class="mt-4 text-primary"><i class="fas fa-edit me-2"></i> Cập nhật bảng lương</h4>
                        <div class="mt-4 mx-auto" style="max-width: 700px">
                            <div class="card shadow-sm">
                                <div class="card-header bg-primary text-white">
                                    <h5 class="mb-0">
                                        <i class="fas fa-money-bill-wave me-2"></i>Thông tin lương nhân viên
                                    </h5>
                                </div>
                                <div class="card-body">
                                    <form:form
                                        method="post"
                                        action="/admin/salary-report/update"
                                        modelAttribute="salary"
                                        class="row g-3"
                                    >
                                        <form:hidden path="id" />
                                        <form:hidden path="employee.id" />

                                        <!-- Nhân viên (readonly) -->
                                        <div class="col-12">
                                            <label class="form-label fw-bold"
                                                ><i class="fas fa-user me-1"></i>Nhân viên</label
                                            >
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"
                                                    ><i class="fas fa-lock text-secondary"></i
                                                ></span>
                                                <input
                                                    type="text"
                                                    class="form-control readonly-field"
                                                    value="${salary.employee.fullName}"
                                                    readonly
                                                />
                                            </div>
                                        </div>

                                        <!-- Tháng (readonly) -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold"
                                                ><i class="fas fa-calendar-alt me-1"></i>Tháng</label
                                            >
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"
                                                    ><i class="fas fa-lock text-secondary"></i
                                                ></span>
                                                <input
                                                    type="text"
                                                    class="form-control readonly-field"
                                                    value="${salary.month}"
                                                    readonly
                                                />
                                            </div>
                                        </div>
                                        <!-- Lương cơ bản (readonly) -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold"
                                                ><i class="fas fa-wallet me-1"></i>Lương cơ bản</label
                                            >
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"
                                                    ><i class="fas fa-lock text-secondary"></i
                                                ></span>
                                                <input
                                                    type="text"
                                                    class="form-control readonly-field money-input"
                                                    id="baseSalaryDisplay"
                                                    readonly
                                                />
                                                <span class="input-group-text">₫</span>
                                            </div>
                                            <div class="form-hint">Được tính từ Employee và chấm công</div>
                                        </div>

                                        <!-- Chấm công info -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold"
                                                ><i class="fas fa-calendar-check me-1"></i>Chấm công</label
                                            >
                                            <div class="row g-2">
                                                <div class="col-4">
                                                    <div class="text-center p-2 bg-success text-white rounded">
                                                        <div class="fw-bold">${salary.workingDays}</div>
                                                        <small>Làm việc</small>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="text-center p-2 bg-warning text-white rounded">
                                                        <div class="fw-bold">${salary.lateDays}</div>
                                                        <small>Đi trễ</small>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="text-center p-2 bg-danger text-white rounded">
                                                        <div class="fw-bold">${salary.absentDays}</div>
                                                        <small>Vắng mặt</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Separator -->
                                        <div class="col-12">
                                            <hr class="my-4" />
                                            <h6 class="text-secondary mb-3">
                                                <i class="fas fa-info-circle me-1"></i>Chi tiết breakdown lương (chỉ
                                                xem)
                                            </h6>
                                        </div>

                                        <!-- Phụ cấp breakdown (readonly) -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-info">
                                                <i class="fas fa-plus-circle me-1"></i>Phụ cấp
                                            </label>
                                            <div class="card">
                                                <div class="card-body p-2">
                                                    <div class="row g-1 text-small">
                                                        <div class="col-6">Tiền ăn:</div>
                                                        <div class="col-6 text-end">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${salary.allowanceMeal != null && salary.allowanceMeal > 0}"
                                                                >
                                                                    <fmt:formatNumber
                                                                        value="${salary.allowanceMeal}"
                                                                        pattern="#,###"
                                                                    />₫
                                                                </c:when>
                                                                <c:otherwise
                                                                    ><span class="text-muted">0₫</span></c:otherwise
                                                                >
                                                            </c:choose>
                                                        </div>
                                                        <div class="col-6">Tiền xe:</div>
                                                        <div class="col-6 text-end">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${salary.allowanceTransport != null && salary.allowanceTransport > 0}"
                                                                >
                                                                    <fmt:formatNumber
                                                                        value="${salary.allowanceTransport}"
                                                                        pattern="#,###"
                                                                    />₫
                                                                </c:when>
                                                                <c:otherwise
                                                                    ><span class="text-muted">0₫</span></c:otherwise
                                                                >
                                                            </c:choose>
                                                        </div>
                                                        <div class="col-6">Thâm niên:</div>
                                                        <div class="col-6 text-end">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${salary.allowanceSeniority != null && salary.allowanceSeniority > 0}"
                                                                >
                                                                    <fmt:formatNumber
                                                                        value="${salary.allowanceSeniority}"
                                                                        pattern="#,###"
                                                                    />₫
                                                                </c:when>
                                                                <c:otherwise
                                                                    ><span class="text-muted">0₫</span></c:otherwise
                                                                >
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Bảo hiểm breakdown (readonly) -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-danger">
                                                <i class="fas fa-shield-alt me-1"></i>Bảo hiểm
                                            </label>
                                            <div class="card">
                                                <div class="card-body p-2">
                                                    <div class="row g-1 text-small">
                                                        <div class="col-6">Y tế:</div>
                                                        <div class="col-6 text-end">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${salary.insuranceHealth != null && salary.insuranceHealth > 0}"
                                                                >
                                                                    <fmt:formatNumber
                                                                        value="${salary.insuranceHealth}"
                                                                        pattern="#,###"
                                                                    />₫
                                                                </c:when>
                                                                <c:otherwise
                                                                    ><span class="text-muted">0₫</span></c:otherwise
                                                                >
                                                            </c:choose>
                                                        </div>
                                                        <div class="col-6">Xã hội:</div>
                                                        <div class="col-6 text-end">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${salary.insuranceSocial != null && salary.insuranceSocial > 0}"
                                                                >
                                                                    <fmt:formatNumber
                                                                        value="${salary.insuranceSocial}"
                                                                        pattern="#,###"
                                                                    />₫
                                                                </c:when>
                                                                <c:otherwise
                                                                    ><span class="text-muted">0₫</span></c:otherwise
                                                                >
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Separator 2 -->
                                        <div class="col-12">
                                            <hr class="my-4" />
                                            <h6 class="text-success mb-3">
                                                <i class="fas fa-edit me-1"></i>Chỉnh sửa thưởng & khấu trừ
                                            </h6>
                                        </div>

                                        <!-- Thưởng (editable) -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-success"
                                                ><i class="fas fa-gift me-1"></i>Thưởng</label
                                            >
                                            <div class="input-group">
                                                <form:input
                                                    path="bonus"
                                                    type="text"
                                                    class="form-control editable-field money-input"
                                                    inputmode="numeric"
                                                />
                                                <span class="input-group-text">₫</span>
                                            </div>
                                            <div class="form-hint">
                                                Nhập số tiền thưởng (ví dụ: 200000 hoặc 200.000)
                                            </div>
                                        </div>

                                        <!-- Khấu trừ (editable) -->
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold text-danger"
                                                ><i class="fas fa-minus-circle me-1"></i>Khấu trừ</label
                                            >
                                            <div class="input-group">
                                                <form:input
                                                    path="deduction"
                                                    type="text"
                                                    class="form-control editable-field money-input"
                                                    inputmode="numeric"
                                                />
                                                <span class="input-group-text">₫</span>
                                            </div>
                                            <div class="form-hint">Nhập số tiền khấu trừ (ví dụ: 50.000)</div>
                                        </div>

                                        <!-- Lương Net (readonly – tự tính) -->
                                        <div class="col-12">
                                            <label class="form-label fw-bold text-primary"
                                                ><i class="fas fa-sack-dollar me-1"></i>Lương Net</label
                                            >
                                            <div class="input-group">
                                                <input
                                                    type="text"
                                                    id="netSalaryDisplay"
                                                    class="form-control money-input readonly-field"
                                                    readonly
                                                />

                                                <span class="input-group-text">₫</span>

                                                <!-- hidden thật để gửi số thuần -->
                                                <form:hidden path="netSalary" />
                                            </div>
                                            <div class="form-hint">
                                                Tự động = (Lương CB + Phụ cấp + Thưởng) - (Bảo hiểm + Khấu trừ)
                                            </div>
                                        </div>

                                        <!-- Ghi chú -->
                                        <div class="col-12">
                                            <label class="form-label fw-bold"
                                                ><i class="fas fa-sticky-note me-1"></i>Ghi chú chỉnh sửa</label
                                            >
                                            <form:textarea
                                                path="note"
                                                class="form-control editable-field"
                                                rows="3"
                                                placeholder="Ví dụ: Thưởng thêm do hoàn thành dự án A, trừ tiền đi trễ..."
                                            />
                                        </div>

                                        <div class="col-12 mt-3 text-end">
                                            <button type="submit" class="btn btn-success">
                                                <i class="fas fa-save me-1"></i>Cập nhật lương
                                            </button>
                                            <a href="/admin/salary-report" class="btn btn-secondary ms-2"
                                                ><i class="fas fa-arrow-left me-1"></i>Quay lại</a
                                            >
                                        </div>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
                <jsp:include page="/WEB-INF/view/layout/footer.jsp" />
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const bonusInput = document.querySelector('[name="bonus"]');
                const deductionInput = document.querySelector('[name="deduction"]');
                const netDisplay = document.getElementById('netSalaryDisplay');
                const netHidden = document.querySelector('[name="netSalary"]');
                const baseSalaryDisplay = document.getElementById('baseSalaryDisplay');

                const baseSalaryRaw = '${salary.baseSalary}';
                const bonusRaw = '${salary.bonus}';
                const deductionRaw = '${salary.deduction}';
                const netRaw = '${salary.netSalary}';
                function parseMoney(str) {
                    if (!str || str === '' || str === 'null' || str === 'undefined') return 0;
                    // Nếu là số thuần (từ server), convert trực tiếp
                    if (typeof str === 'number') return str;
                    // Nếu là string, loại bỏ tất cả ký tự không phải số
                    const clean = String(str).replace(/[^\d]/g, '');
                    return clean ? parseInt(clean, 10) : 0;
                }

                function fmt(n) {
                    return Number(n || 0).toLocaleString('vi-VN');
                }

                baseSalaryDisplay.value = fmt(baseSalaryRaw);
                bonusInput.value = fmt(bonusRaw);
                deductionInput.value = fmt(deductionRaw);
                netDisplay.value = fmt(netRaw);
                function recalcNet() {
                    // Parse giá trị từ JSP (số thuần, không có formatting)
                    const base = parseFloat('${salary.baseSalary}') || 0;
                    const allowanceMeal = parseFloat('${salary.allowanceMeal}') || 0;
                    const allowanceTransport = parseFloat('${salary.allowanceTransport}') || 0;
                    const allowanceSeniority = parseFloat('${salary.allowanceSeniority}') || 0;

                    // Parse giá trị từ input (có thể có formatting)
                    const bonus = parseMoney(bonusInput.value);

                    const grossSalary = base + allowanceMeal + allowanceTransport + allowanceSeniority + bonus;

                    // Parse bảo hiểm từ JSP
                    const insuranceHealth = parseFloat('${salary.insuranceHealth}') || 0;
                    const insuranceSocial = parseFloat('${salary.insuranceSocial}') || 0;

                    // Parse khấu trừ từ input
                    const otherDeduction = parseMoney(deductionInput.value);

                    const totalDeduction = insuranceHealth + insuranceSocial + otherDeduction;

                    // Net salary = gross - total deduction
                    const net = grossSalary - totalDeduction;

                    console.log('Debug calculation:');
                    console.log('Base:', base);
                    console.log('Allowances:', allowanceMeal, allowanceTransport, allowanceSeniority);
                    console.log('Bonus:', bonus);
                    console.log('Gross:', grossSalary);
                    console.log('Insurance:', insuranceHealth, insuranceSocial);
                    console.log('Other deduction:', otherDeduction);
                    console.log('Total deduction:', totalDeduction);
                    console.log('Net:', net);

                    netDisplay.value = fmt(net);
                    netHidden.value = net;
                }

                [bonusInput, deductionInput].forEach((el) => {
                    el.addEventListener('input', () => {
                        const n = parseMoney(el.value);
                        el.value = fmt(n);
                        recalcNet();
                    });
                    el.addEventListener('blur', () => {
                        const n = parseMoney(el.value);
                        el.value = fmt(n);
                        recalcNet();
                    });
                });

                const form = document.querySelector('form');
                if (form) {
                    form.addEventListener('submit', function () {
                        // Xóa dấu . ₫ khỏi các input bonus/deduction
                        [bonusInput, deductionInput].forEach((f) => {
                            f.value = parseMoney(f.value);
                        });
                        netHidden.value = parseMoney(netDisplay.value);
                    });
                }

                recalcNet();
            });
        </script>
    </body>
</html>
