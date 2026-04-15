<%@ include file="common/header.jsp" %>

<!-- 1. Corporate Hero Section -->
<div class="position-relative bg-dark text-white overflow-hidden" style="min-height: 550px;">
    <!-- Abstract Tech Background -->
    <div class="position-absolute top-0 start-0 w-100 h-100" 
         style="background: linear-gradient(135deg, var(--primary-dark) 0%, #001f3f 100%); z-index: 0;">
         <div style="opacity: 0.1; background-image: radial-gradient(#fff 1px, transparent 1px); background-size: 30px 30px; width: 100%; height: 100%;"></div>
    </div>
    
    <div class="container position-relative d-flex align-items-center h-100 pt-5 mt-5" style="z-index: 1;">
        <div class="row w-100 align-items-center">
            <div class="col-lg-6">
                <span class="badge bg-info bg-opacity-25 text-info border border-info border-opacity-25 mb-3 px-3 py-2 rounded-pill">Leading Pharmaceutical Manufacturer</span>
                <h1 class="display-4 fw-bold mb-4" style="line-height: 1.2;">Innovation for a <br><span style="color: var(--accent-color);">Healthier Tomorrow</span></h1>
                <p class="lead mb-5 text-white-50">Producing high-quality, affordable generics and branded formulations. ISO 9001:2015 & WHO-GMP Certified facilities.</p>
                
                <c:if test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-light btn-lg px-5 fw-bold rounded-1">Become a Distributor</a>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <a href="#products" class="btn btn-info btn-lg px-5 fw-bold text-white rounded-1">Browse Catalog</a>
                </c:if>
            </div>
            <div class="col-lg-6 d-none d-lg-block text-end">
                <i class="fas fa-dna fa-10x text-white opacity-10"></i>
                <i class="fas fa-pills fa-6x text-info opacity-25 ms-4"></i>
            </div>
        </div>
    </div>
</div>

<!-- 2. Company Stats -->
<div class="bg-white py-5 shadow-sm border-bottom">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3 col-6 mb-3">
                <h2 class="fw-bold text-primary">25+</h2>
                <p class="text-muted small text-uppercase">Years of Excellence</p>
            </div>
            <div class="col-md-3 col-6 mb-3">
                <h2 class="fw-bold text-primary">500+</h2>
                <p class="text-muted small text-uppercase">Formulations</p>
            </div>
            <div class="col-md-3 col-6 mb-3">
                <h2 class="fw-bold text-primary">3</h2>
                <p class="text-muted small text-uppercase">Mfg. Units</p>
            </div>
            <div class="col-md-3 col-6 mb-3">
                <h2 class="fw-bold text-primary">40+</h2>
                <p class="text-muted small text-uppercase">Global Markets</p>
            </div>
        </div>
    </div>
</div>

<!-- 3. Featured Portfolio -->
<div class="container my-5 py-5" id="products">
    <div class="row align-items-end mb-5">
        <div class="col-md-8">
            <h6 class="text-uppercase text-info fw-bold letter-spacing">Our Portfolio</h6>
            <h2 class="fw-bold" style="color: var(--primary-dark);">Therapeutic Categories</h2>
            <p class="text-muted">High-quality medicines across key therapeutic areas.</p>
        </div>
        <div class="col-md-4 text-md-end">
            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline-dark">View Full List <i class="fas fa-arrow-right ms-2"></i></a>
        </div>
    </div>

    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <c:forEach items="${products}" var="p" begin="0" end="7"> 
            <div class="col">
                <div class="card h-100 border-0 shadow-sm hover-up">
                    <div class="card-header bg-transparent border-0 pt-3 text-end">
                        <span class="badge bg-light text-secondary border">Rx</span>
                    </div>
                    
                    <!-- IMAGE AREA - UPDATED TO DISK PATH -->
                    <div class="text-center p-3" style="height: 180px;">
                         <c:if test="${not empty p.imageName}">
                             <!-- Physical path mapping to C: Drive -->
                             <img src="${pageContext.request.contextPath}/product-images/${p.imageName}" 
                                  style="max-height: 100%; max-width: 100%; object-fit: contain;">
                         </c:if>
                         <c:if test="${empty p.imageName}">
                             <div class="d-flex align-items-center justify-content-center h-100 bg-light rounded">
                                <i class="fas fa-prescription-bottle-alt fa-3x text-secondary opacity-25"></i>
                             </div>
                         </c:if> 
                    </div>

                    <div class="card-body d-flex flex-column">
                        <small class="text-info fw-bold" style="font-size: 0.7rem;">${p.category}</small>
                        <h6 class="card-title fw-bold text-dark mb-1 text-truncate">${p.name}</h6>
                        <p class="card-text text-muted small text-truncate mb-3">${p.description}</p>
                        
                        <div class="mt-auto pt-2 border-top">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <div class="d-flex justify-content-between align-items-center">
                         <%--          <h5 class="fw-bold text-primary mb-0">$${p.price}</h5> --%>
                                        <h5 class="fw-bold text-primary mb-0">&#8377;${p.price}</h5>
                                        <c:if test="${p.stockQuantity > 0}">
                                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="d-flex align-items-center">
                                                <input type="hidden" name="productId" value="${p.id}">
                                                <input type="number" name="quantity" value="5" min="5" max="${p.stockQuantity}" 
                                                       class="form-control form-control-sm text-center border-secondary me-2 p-1" 
                                                       style="width: 55px;" required title="Minimum Order: 5 Boxes">
                                                
                                                <button class="btn btn-sm btn-primary rounded-1" type="submit" title="Add to Order Draft">
                                                    <i class="fas fa-cart-plus"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${p.stockQuantity == 0}">
                                            <span class="badge bg-danger">Sold Out</span>
                                        </c:if>
                                    </div>
                                </c:when>

                                <c:otherwise>
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/login" class="btn btn-sm btn-outline-secondary">
                                            <i class="fas fa-lock me-1"></i> Log in for Rates
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<style>
    .hover-up { transition: transform 0.3s ease, box-shadow 0.3s ease; }
    .hover-up:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important; }
    .letter-spacing { letter-spacing: 1px; }
</style>

<%@ include file="common/footer.jsp" %>