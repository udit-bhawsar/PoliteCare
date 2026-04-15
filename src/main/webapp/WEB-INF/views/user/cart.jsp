<%@ include file="../common/header.jsp" %>

<div class="container py-5" style="min-height: 80vh;">
    <h3 class="fw-bold mb-4">Purchase Order Draft</h3>

    <c:if test="${empty cartItems}">
        <div class="text-center py-5 border rounded bg-light">
            <i class="fas fa-clipboard-list fa-3x text-muted mb-3"></i>
            <h5 class="text-muted">No items in the draft.</h5>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary mt-2">Browse Catalog</a>
        </div>
    </c:if>

    <c:if test="${not empty cartItems}">
        <div class="row">
            <div class="col-lg-8">
                <div class="card border-0 shadow-sm mb-4">
                    <table class="table align-middle mb-0">
                        <thead class="bg-light text-secondary small text-uppercase">
                            <tr>
                                <th class="ps-4 py-3">Item Description</th>
                                <th>Distributor Rate</th>
                                <!-- HEADER CHANGED -->
                                <th>Quantity (Unit: Boxes)</th>
                                <th class="text-end pe-4">Line Total</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cartItems}" var="item">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold">${item.product.name}</div>
                                        <small class="text-muted">${item.product.category}</small>
                                    </td>
                                    <td class="fw-bold">&#8377;${item.product.price}</td>
                                    <td>
                                        <span class="badge bg-white text-dark border px-3 py-2 shadow-sm" style="font-size: 0.9rem; border-color: #dee2e6 !important;">
                                            <i class="fas fa-boxes me-1 text-primary"></i> ${item.quantity} Boxes
                                        </span>
                                    </td>
                                    <td class="text-end pe-4 fw-bold text-primary">
                                        &#8377;${item.product.price * item.quantity}
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/cart/remove/${item.product.id}" 
                                           class="text-danger btn btn-link p-0 shadow-none" title="Remove Item">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="alert alert-warning small py-2 mt-2 shadow-sm">
                    <i class="fas fa-info-circle me-1"></i> PoliteCare Guidelines: Standard packaging is 10 Strips per Box.
                </div>
            </div>
            
            <div class="col-lg-4">
                <div class="card border-0 shadow-lg bg-dark text-white p-4">
                    <h5 class="fw-bold mb-4 border-bottom border-secondary pb-3 text-uppercase">Summary (PO)</h5>
                    <div class="d-flex justify-content-between mb-2 text-white-50 small">
                        <span>Invoice Subtotal</span>
                        <span>&#8377;${total}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3 text-white-50 small">
                        <span>Applicable GST (Est. 18%)</span>
                        <span>&#8377;${total * 0.18}</span>
                    </div>
                    <hr class="border-secondary opacity-50">
                    <div class="d-flex justify-content-between mb-4 fs-5 fw-bold text-info">
                        <span>Final PO Total</span>
                        <span>&#8377;${total + (total * 0.18)}</span>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="post">
                        
                        <!-- ADDED ADDRESS SECTION BELOW -->
                        <div class="mb-4">
                            <label class="form-label small text-white-50 text-uppercase fw-bold mb-2">Delivery / Warehouse Address:</label>
                            <textarea name="address" class="form-control form-control-sm border-secondary text-white bg-dark shadow-none" 
                                      style="font-size: 0.85rem;" rows="3" 
                                      placeholder="Building Name, State, PIN..." 
                                      required></textarea>
                        </div>
                        <!-- END ADDRESS SECTION -->

                        <button class="btn btn-info w-100 fw-bold py-2 shadow border-0 text-white rounded-1">
                            CONFIRM & SEND PO <i class="fas fa-paper-plane ms-2"></i>
                        </button>
                    </form>
                    
                    <div class="mt-4 text-center text-white-50 small">
                        <i class="fas fa-shield-alt me-1"></i> Direct Secure Dispatch
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<%@ include file="../common/footer.jsp" %>