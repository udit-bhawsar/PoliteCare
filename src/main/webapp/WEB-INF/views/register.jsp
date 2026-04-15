<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<div class="container-fluid bg-white p-0">
    <div class="row g-0" style="min-height: 85vh;">
        
<!-- Background Column Update -->
 <div class="col-lg-6 d-none d-lg-flex flex-column justify-content-center align-items-center text-white p-5 sticky-top" 
             style="background: linear-gradient(135deg, var(--primary-dark) 0%, #00152b 100%); height: 90vh;">
            
            <div class="text-center px-5">
                <!-- Large Medicine/Science Icon -->
                <div class="mb-4 bg-white bg-opacity-10 p-4 rounded-circle d-inline-block border border-white border-opacity-10">
                    <i class="fas fa-prescription-bottle-medical fa-4x text-info"></i>
                </div>
                
                <h1 class="display-4 fw-bold mb-3">Distributor Partnership</h1>
                <p class="lead mb-5 text-white-50 px-lg-5">
                    Empower your distribution business by connecting directly with PoliteCare Manufacturing Units. Access ex-factory rates and live stock.
                </p>

                <!-- Partnership Benefits -->
                <div class="row g-4 justify-content-center mb-5">
                    <div class="col-4">
                        <i class="fas fa-certificate fa-2x mb-2 text-info"></i>
                        <h6 class="fw-bold mb-0">WHO-GMP</h6>
                        <small class="opacity-75">Certified Quality</small>
                    </div>
                    <div class="col-4 border-start border-end border-white border-opacity-10">
                        <i class="fas fa-globe-americas fa-2x mb-2 text-info"></i>
                        <h6 class="fw-bold mb-0">GLOBAL</h6>
                        <small class="opacity-75">Standard Norms</small>
                    </div>
                    <div class="col-4">
                        <i class="fas fa-file-signature fa-2x mb-2 text-info"></i>
                        <h6 class="fw-bold mb-0">TRANSPARENT</h6>
                        <small class="opacity-75">Contractual Rates</small>
                    </div>
                </div>

                <!-- Quality Badge Footer -->
                <div class="mt-4 pt-4 border-top border-white border-opacity-10 w-100">
                    <p class="small text-white-50 mb-0">
                        <i class="fas fa-lock me-2 text-info"></i> Secure Enterprise-Grade Enrollment Portal
                    </p>
                </div>
            </div>
        </div>

        <div class="col-lg-6 d-flex flex-column justify-content-center align-items-center p-4 p-md-5">
            <div class="w-100" style="max-width: 500px;">
                <h3 class="fw-bold text-primary mb-2">Partner Registration</h3>
                <p class="text-muted mb-4">Create an account to view wholesale rates and place orders.</p>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control bg-light border-0" id="name" name="fullName" placeholder="Company/Full Name" required>
                        <label for="name">Company / Full Name</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control bg-light border-0" id="email" name="email" placeholder="name@example.com" required>
                        <label for="email">Business Email</label>
                    </div>

                    <div class="form-floating mb-4">
                        <input type="password" class="form-control bg-light border-0" id="pass" name="password" placeholder="Password" required>
                        <label for="pass">Create Password</label>
                    </div>

                    <button type="submit" class="btn btn-brand w-100 py-3 fw-bold rounded-1 shadow-sm">
                        REGISTER ACCOUNT
                    </button>
                </form>
                
                <div class="text-center mt-4 border-top pt-3">
                    <p class="small text-muted">Already registered? <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none">Login here</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>