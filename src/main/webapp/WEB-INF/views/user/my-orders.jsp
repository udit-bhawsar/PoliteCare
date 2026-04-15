<%@ include file="../common/header.jsp" %>

<div class="container py-5" style="min-height: 80vh;">
    
    <div class="mb-4">
        <h2 class="fw-bold"><i class="fas fa-history me-2 text-primary"></i>My Order History</h2>
        <p class="text-muted">Track your past purchases and delivery status.</p>
    </div>

    <c:if test="${empty orders}">
        <div class="text-center py-5 bg-white shadow-sm rounded">
            <i class="fas fa-shopping-basket fa-4x text-muted mb-3"></i>
            <h5 class="text-muted">You haven't placed any orders yet.</h5>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-3 px-4 rounded-pill">Start Shopping</a>
        </div>
    </c:if>

    <div class="row">
        <div class="col-lg-10 mx-auto">
            <c:forEach items="${orders}" var="o">
                <div class="card mb-4 border-0 shadow-sm overflow-hidden">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3 border-bottom-0">
                        <div>
                            <span class="badge bg-light text-dark border me-2">Order #${o.id}</span>
                            <span class="text-muted small"><i class="far fa-clock me-1"></i>${o.orderDate}</span>
                        </div>
                        <span class="badge rounded-pill px-3 py-2 ${o.status == 'APPROVED' ? 'bg-success' : (o.status == 'REJECTED' ? 'bg-danger' : 'bg-warning text-dark')}">
                            ${o.status}
                        </span>
                            <a href="${pageContext.request.contextPath}/user/order/invoice/${o.id}" 
       class="btn btn-sm btn-outline-primary shadow-sm" target="_blank">
       <i class="fas fa-file-invoice-dollar me-1"></i> Invoice
    </a>
                    </div>
                    
                    <div class="card-body bg-light">
                        <ul class="list-group list-group-flush rounded mb-3">
                            <c:forEach items="${o.items}" var="item">
                                <li class="list-group-item d-flex justify-content-between align-items-center bg-white">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-secondary rounded-circle me-3 d-flex align-items-center justify-content-center text-white" style="width:40px; height:40px;">
                                            <i class="fas fa-pills"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 fw-bold">${item.product.name}</h6>
                                            <small class="text-muted">Quantity: ${item.quantity}</small>
                                        </div>
                                    </div>
                                    <span class="fw-bold">&#8377;${item.priceAtPurchase * item.quantity}</span>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="d-flex justify-content-end align-items-center">
                            <span class="text-muted me-2">Order Total:</span>
                            <h4 class="text-primary mb-0 fw-bold">&#8377;${o.totalAmount}</h4>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>