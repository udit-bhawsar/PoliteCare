<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Purchase_Order_#${order.id}</title>
    <!-- Fonts and Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f5f5f5; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .invoice-card { 
            background: white; 
            max-width: 850px; 
            margin: 40px auto; 
            padding: 50px; 
            box-shadow: 0 0 20px rgba(0,0,0,0.1); 
            border-top: 10px solid #002B5B; 
        }
        .header-logo { font-weight: 800; color: #002B5B; font-size: 1.8rem; }
        .table-custom thead { background-color: #f8f9fa; border-top: 2px solid #002B5B; }
        .label-text { font-size: 0.75rem; text-transform: uppercase; color: #888; font-weight: bold; }
        
        /* Buttons should hide when printing */
        @media print { .no-print { display: none; } body { background: white; margin: 0; padding: 0; } .invoice-card { border:none; box-shadow:none; width: 100%; margin: 0; } }
    </style>
</head>
<body>

<div class="invoice-card">
    <!-- Top Branding & ID -->
    <div class="row align-items-center mb-5">
        <div class="col-6">
            <div class="header-logo text-uppercase"><i class="fas fa-prescription-bottle-medical text-info me-2"></i>PoliteCare</div>
            <p class="small text-muted mt-1 mb-0">Pharmaceuticals Manufacturing Unit</p>
        </div>
        <div class="col-6 text-end">
            <h4 class="fw-bold mb-0">PURCHASE ORDER</h4>
            <div class="mt-2">
                <div class="label-text">Order Identification:</div>
                <div class="fw-bold fs-5">#POL-${order.id}</div>
            </div>
        </div>
    </div>

    <!-- Company and Customer Addresses -->
    <div class="row mb-5 py-4 border-top border-bottom">
        <div class="col-6">
            <div class="label-text mb-2 text-primary">MANUFACTURER:</div>
            <div class="fw-bold">PoliteCare Pharmaceuticals Ltd.</div>
            <div class="small text-muted">
                Factory Plot No. 102, Pharma City Area,<br>
                Mumbai - 400001, Maharashtra<br>
                <strong>GSTIN:</strong> 27AABCP0000X1Z5
            </div>
        </div>
        <div class="col-6 text-end">
            <div class="label-text mb-2 text-success">AUTHORIZED DISTRIBUTOR (Ship to):</div>
            <div class="fw-bold">${order.user.fullName}</div>
            <div class="small text-muted">
                Associated Channel Partner<br>
                <strong>Email:</strong> ${order.user.email}<br>
                <strong>Order Status:</strong> ${order.status}
            </div>
        </div>
    </div>

    <!-- Table Section -->
    <table class="table table-bordered align-middle text-center mt-4">
        <thead class="bg-light small">
            <tr>
                <th class="text-start py-3">Medicine Formulation (Standard Bulk Pack)</th>
                <th>Rate/Box</th>
                <th>Total Quantity</th>
                <th class="text-end">Line Total</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${order.items}" var="item">
                <tr>
                    <td class="text-start p-3">
                        <div class="fw-bold">${item.product.name}</div>
                        <div class="text-muted small">${item.product.category} (Standard Box of 10x10)</div>
                    </td>
                    <td>&#8377;${item.priceAtPurchase}</td>
                    <td><strong>${item.quantity} Boxes</strong></td>
                    <td class="text-end fw-bold">&#8377;${item.priceAtPurchase * item.quantity}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <!-- Calculations Section -->
    <div class="row justify-content-end mt-4">
        <div class="col-md-5">
            <div class="d-flex justify-content-between mb-2">
                <span class="text-muted">Net Base Amount:</span>
                <span class="fw-bold">&#8377;${order.totalAmount}</span>
            </div>
            <div class="d-flex justify-content-between mb-2">
                <span class="text-muted">Estimated Tax (18%):</span>
                <span>&#8377;${order.totalAmount * 0.18}</span>
            </div>
            <hr>
            <div class="d-flex justify-content-between">
                <span class="fw-bold text-dark fs-5">PO GRAND TOTAL:</span>
                <span class="fw-bold text-primary fs-5">&#8377;${order.totalAmount + (order.totalAmount * 0.18)}</span>
            </div>
        </div>
    </div>

    <!-- Legal Terms -->
    <div class="mt-5 pt-4 border-top">
        <div class="label-text mb-2 text-dark">Declarations & Instructions:</div>
        <ul class="text-muted small ps-3">
            <li>Dispatch of these products is subject to actual stock availability at factory warehouse.</li>
            <li>Subject to Pune jurisdiction only. Medicines once sold will not be taken back after expiry.</li>
            <li>Rates are per Master Case/Box of 100 strips. E. & O.E.</li>
        </ul>
    </div>

    <!-- Printing Buttons -->
    <div class="mt-5 no-print text-center pt-3 border-top border-dashed">
        <button onclick="window.print()" class="btn btn-dark rounded-0 px-5 fw-bold">
            <i class="fas fa-print me-2"></i> Print Document / Export PDF
        </button>
        <a href="${pageContext.request.contextPath}/user/my-orders" class="btn btn-link text-decoration-none ms-3 text-secondary">
            Go back to Order List
        </a>
    </div>
</div>

</body>
</html>