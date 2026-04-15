<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PoliteCare Pharmaceuticals | Innovating Life</title>
    
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Font: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            /* Corporate Palette - Deep Blue & Teal */
            --primary-dark: #002B5B;  
            --primary-light: #2B4C7E;
            --accent-color: #00A6A6;  
            --bg-light: #F4F7F6;
            --text-dark: #1F2937;
            --white: #ffffff;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Top Bar */
        .top-bar {
            background-color: var(--primary-dark);
            color: rgba(255,255,255,0.8);
            font-size: 0.8rem;
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        /* Navbar */
        .navbar {
            background: var(--white) !important;
            box-shadow: 0 2px 15px rgba(0,0,0,0.04);
            padding: 1rem 0;
        }
        .navbar-brand {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--primary-dark) !important;
            letter-spacing: -0.5px;
        }
        .nav-link {
            font-weight: 500;
            color: var(--primary-light) !important;
            margin: 0 8px;
            transition: all 0.3s;
        }
        .nav-link:hover, .nav-link.active {
            color: var(--accent-color) !important;
        }
        
        .btn-brand {
            background-color: var(--primary-dark);
            color: white;
            border-radius: 4px;
            padding: 0.5rem 1.5rem;
            transition: 0.3s;
        }
        .btn-brand:hover {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-outline-brand {
            border: 2px solid var(--primary-dark);
            color: var(--primary-dark);
            border-radius: 4px;
            font-weight: 600;
        }
        .btn-outline-brand:hover {
            background: var(--primary-dark);
            color: white;
        }

        main { flex: 1; }
    </style>
</head>
<body>

<!-- Corporate Top Bar -->
<div class="top-bar">
    <div class="container d-flex justify-content-between align-items-center">
        <div>
            <span class="me-3"><i class="fas fa-certificate me-1"></i> WHO-GMP Certified</span>
            <span><i class="fas fa-globe me-1"></i> Exporting to 20+ Countries</span>
        </div>
        <div class="d-none d-md-block">
            <span class="me-3"><i class="fas fa-phone-alt me-1"></i> +91 7879516662</span>
            <span><i class="fas fa-envelope me-1"></i> business@politecare.com</span>
        </div>
    </div>
</div>

<!-- Main Navigation -->
<nav class="navbar navbar-expand-lg sticky-top">
  <div class="container">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">
        <i class="fas fa-prescription-bottle-medical text-info me-2"></i>PoliteCare
    </a>
    <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navContent">
      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Overview</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/products">Product Portfolio</a></li>
        
        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <li class="nav-item ms-3">
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-brand btn-sm px-4">Distributor Login</a>
                </li>
                <li class="nav-item ms-2">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-brand btn-sm px-4">Apply for Partnership</a>
                </li>
            </c:when>

            <c:otherwise>
                <%-- DISTRIBUTOR / STOCKIST LINKS --%>
                <c:if test="${sessionScope.user.role == 'USER'}">
                    <li class="nav-item ms-2">
                        <a class="btn btn-light position-relative border" href="${pageContext.request.contextPath}/cart" title="Order Draft">
                            <i class="fas fa-boxes text-muted"></i>
                            <c:if test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                    ${sessionScope.cart.size()}
                                </span>
                            </c:if>
                        </a>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/my-orders">Track Orders</a></li>
                </c:if>
                
                <%-- ADMIN / MANUFACTURER LINKS --%>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <li class="nav-item"><a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/admin/dashboard">ADMIN PORTAL</a></li>
                    
                    <!-- NEW REPORTS LINK ADDED HERE -->
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/reports"><i class="fas fa-chart-pie me-1"></i>Business Reports</a></li>
                    
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/orders">Requests</a></li>
                </c:if>

                <li class="nav-item dropdown ms-3">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                        <div class="bg-light rounded-circle text-center d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px;">
                            <i class="fas fa-user text-dark"></i>
                        </div>
                        <span class="small fw-bold text-dark">${sessionScope.user.fullName}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                        <c:if test="${sessionScope.user.role == 'USER'}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/my-orders">Order History</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart">View PO Draft</a></li>
                        </c:if>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout">Sign Out</a></li>
                    </ul>
                </li>
            </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>

<main> <!-- Closes in footer.jsp -->