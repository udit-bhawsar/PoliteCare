<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../common/header.jsp" %>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Customer Orders</h2>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary">Back to Dashboard</a>
    </div>

    <div class="card shadow">
        <div class="card-body">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Name</th>
                        <th style="min-width: 140px;">Date</th>
                        <th>Total Amount</th>
                        <th>Items</th>
                         <th>Ship To Address</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="o">
                        <tr>
                            <td>#${o.id}</td>
                            <td class="ps-4">
    <div class="fw-bold">${o.user.fullName}</div>
    <small class="text-muted">${o.user.email}</small>
</td>
                            <!-- 1. DATE FORMATTING (Extra time removed) -->
                            <td>
                                <small>${o.orderDate.toString().replace('T', ' ').substring(0, 16)}</small>
                            </td>

                            <td class="fw-bold">&#8377;${o.totalAmount}</td>
                            <td>
                                <ul class="list-unstyled mb-0">
                                    <c:forEach items="${o.items}" var="item">
                                        <li><small>${item.product.name} (x${item.quantity})</small></li>
                                    </c:forEach>
                                </ul>
                            </td>
                            <td style="max-width: 250px;">
    <div class="small text-dark fw-bold">
        <i class="fas fa-map-marker-alt text-danger me-1"></i> ${o.deliveryAddress}
    </div>
</td>
                            <td>
                                <span class="badge rounded-pill 
                                    ${o.status == 'APPROVED' ? 'bg-success' : (o.status == 'REJECTED' ? 'bg-danger' : 'bg-warning text-dark')}">
                                    ${o.status}
                                </span>
                            </td>
                            
                            <!-- 2. ACTIONS PROPERLY MANAGED (Flex layout for buttons) -->
                            <td style="min-width: 160px;">
                                <c:if test="${o.status == 'PENDING'}">
                                    <div class="d-flex gap-1">
                                        <a href="${pageContext.request.contextPath}/admin/order-action/${o.id}/APPROVED" class="btn btn-sm btn-success px-2 py-1 flex-fill">Approve</a>
                                        <a href="${pageContext.request.contextPath}/admin/order-action/${o.id}/REJECTED" class="btn btn-sm btn-danger px-2 py-1 flex-fill">Reject</a>
                                    </div>
                                </c:if>
                                <c:if test="${o.status != 'PENDING'}">
                                    <span class="text-muted small">Completed</span>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>