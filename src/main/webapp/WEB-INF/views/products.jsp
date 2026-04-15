
<%@ include file="common/header.jsp" %>

<div class="bg-dark text-white py-4 border-bottom border-secondary">
    <div class="container">
        <h3 class="fw-bold">Product Portfolio</h3>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0 small text-white-50">
                <li class="breadcrumb-item text-white-50">Home</li>
                <li class="breadcrumb-item active text-white" aria-current="page">Products</li>
            </ol>
        </nav>
    </div>
</div>

<div class="container py-5">
    <div class="row">
        <!-- Sidebar Filter -->
        <div class="col-lg-3 mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white fw-bold text-uppercase small py-3">Categories</div>
                <div class="list-group list-group-flush small">
                    <a href="${pageContext.request.contextPath}/products" class="list-group-item list-group-item-action ${activeCategory == 'All' || activeCategory == 'All Products' ? 'bg-light fw-bold text-primary' : ''}">All Medicines</a>
                    <c:forEach items="${categoryList}" var="cat">
                        <a href="${pageContext.request.contextPath}/products?category=${cat}" class="list-group-item list-group-item-action ${activeCategory == cat ? 'bg-light fw-bold text-primary' : ''}">${cat}</a>
                    </c:forEach>
                </div>
            </div>
            
            <div class="card bg-info bg-opacity-10 border-0 mt-3 p-3">
                <h6 class="fw-bold text-info"><i class="fas fa-headset me-2"></i>Bulk Inquiry?</h6>
                <p class="small text-muted mb-2">For hospital supplies and export queries, contact sales directly.</p>
                <a href="#" class="btn btn-sm btn-info text-white fw-bold">Contact Sales</a>
            </div>
        </div>

        <!-- Product Grid -->
        <div class="col-lg-9">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h5 class="fw-bold mb-0 text-dark">Showing: <span class="text-primary">${activeCategory}</span></h5>
                <span class="text-muted small">${products.size()} products found</span>
            </div>

            <div class="row row-cols-1 row-cols-md-3 g-4">
                <c:forEach items="${products}" var="p">
                    <div class="col">
                        <div class="card h-100 border-0 shadow-sm">
                            <div class="position-relative bg-light p-4 text-center" style="height: 200px;">
                             <c:if test="${not empty p.imageBase64}">
                             <img src="data:image/jpeg;base64,${p.imageBase64}" style="max-height: 100%; max-width: 100%; object-fit: contain;">
                         </c:if>
                         <c:if test="${empty p.imageBase64}">
                             <div class="d-flex align-items-center justify-content-center h-100 bg-light rounded">
                                <i class="fas fa-prescription-bottle-alt fa-3x text-secondary opacity-25"></i>
                             </div>
                         </c:if> 
                                
                                <c:if test="${p.stockQuantity == 0}">
                                    <div class="position-absolute top-0 start-0 w-100 h-100 bg-white bg-opacity-75 d-flex align-items-center justify-content-center">
                                        <span class="badge bg-danger">OUT OF STOCK</span>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="card-body">
                                <small class="text-muted text-uppercase" style="font-size: 0.7rem;">${p.category}</small>
                                <h6 class="fw-bold text-dark mt-1 text-truncate">${p.name}</h6>
                                <p class="small text-muted mb-3 text-truncate" style="min-height: 20px;">${p.description}</p>
                                
                                <div class="d-flex align-items-center justify-content-between mt-auto">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <h5 class="mb-0 fw-bold text-primary">&#8377;${p.price}</h5>
                                            <c:if test="${p.stockQuantity > 0}">
<form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-flex align-items-center">
    <input type="hidden" name="productId" value="${p.id}">
    
    <!-- CHANGE: min="5" and value="5" -->
    <input type="number" name="quantity" value="5" min="5" max="${p.stockQuantity}" 
           class="form-control form-control-sm text-center border-secondary me-2 p-1" 
           style="width: 55px;" required title="Minimum Order: 5 Boxes">
    
    <button class="btn btn-sm btn-primary rounded-1" type="submit">
        <i class="fas fa-cart-plus"></i>
    </button>
</form>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <small class="text-muted fst-italic">Login for rates</small>
                                            <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-outline-primary"><i class="fas fa-lock"></i></a>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<%@ include file="common/footer.jsp" %>