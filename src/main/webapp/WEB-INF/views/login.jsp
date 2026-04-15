<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<div class="container-fluid bg-white p-0">
    <div class="row g-0" style="min-height: 85vh;">
        
        <!-- Left Side: Corporate Branding -->
        <div class="col-lg-6 d-none d-lg-flex flex-column justify-content-center align-items-center text-white p-5" 
             style="background: linear-gradient(135deg, var(--primary-dark), var(--primary-light));">
            <div class="text-center">
                <div class="mb-4 bg-white bg-opacity-10 p-3 rounded-circle d-inline-block">
                    <i class="fas fa-microscope fa-4x"></i>
                </div>
                <h1 class="display-5 fw-bold mb-3">PoliteCare Partner Portal</h1>
                <p class="lead mb-4 text-white-50">Seamless ordering for distributors, hospitals, and pharmacies.</p>
                <div class="d-flex gap-3 justify-content-center">
                    <div class="text-center px-3 border-end border-white border-opacity-25">
                        <h4 class="fw-bold mb-0">24/7</h4>
                        <small>Support</small>
                    </div>
                    <div class="text-center px-3">
                        <h4 class="fw-bold mb-0">100%</h4>
                        <small>Quality Check</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right Side: Login Form -->
        <div class="col-lg-6 d-flex flex-column justify-content-center align-items-center p-4 p-md-5">
            <div class="w-100" style="max-width: 450px;">
                <div class="text-center mb-5">
                    <h3 class="fw-bold text-dark">Welcome Back</h3>
                    <p class="text-muted">Please sign in to access your dashboard.</p>
                </div>

                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger small border-0 bg-danger bg-opacity-10 text-danger">
                        <i class="fas fa-exclamation-circle me-1"></i> Authentication failed. Check credentials.
                    </div>
                </c:if>
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success small border-0 bg-success bg-opacity-10 text-success">
                        <i class="fas fa-check-circle me-1"></i> Registration complete. Please login.
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control bg-light border-0" id="email" name="email" placeholder="name@example.com" required>
                        <label for="email">Official Email ID</label>
                    </div>
                    <div class="form-floating mb-4">
                        <input type="password" class="form-control bg-light border-0" id="password" name="password" placeholder="Password" required>
                        <label for="password">Password</label>
                    </div>
                    
                    <button type="submit" class="btn btn-brand w-100 py-3 fw-bold rounded-1 shadow-sm">
                        SECURE LOGIN <i class="fas fa-arrow-right ms-2"></i>
                    </button>
                    
                    <div class="text-center mt-4">
                        <p class="small text-muted">Not a partner yet? <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none" style="color: var(--primary-dark);">Apply for Partnership</a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>