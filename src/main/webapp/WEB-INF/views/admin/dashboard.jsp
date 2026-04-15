<%@ include file="../common/header.jsp" %>
<div class="container-fluid bg-light py-4" style="min-height: 90vh;">
    <div class="container">
        
        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="fw-bold text-dark mb-0">Production Inventory</h4>
                <small class="text-muted">Admin Control Panel</small>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-dark btn-sm">
                    <i class="fas fa-list-alt me-2"></i>View Orders
                </a>
            </div>
        </div>

        <!-- KPI Cards (Static Visuals) -->
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card p-3 border-0 shadow-sm border-start border-4 border-primary">
                    <small class="text-muted text-uppercase fw-bold">Total Products</small>
                    <h3 class="fw-bold text-dark mb-0">${products.size()}</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3 border-0 shadow-sm border-start border-4 border-success">
                    <small class="text-muted text-uppercase fw-bold">Stock Status</small>
                    <h3 class="fw-bold text-success mb-0">Healthy</h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card p-3 border-0 shadow-sm border-start border-4 border-warning">
                    <small class="text-muted text-uppercase fw-bold">Pending Orders</small>
                    <h3 class="fw-bold text-warning mb-0">Check List</h3>
                </div>
            </div>
        </div>

        <!-- Add Product Panel -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white py-3 border-bottom">
                <h6 class="fw-bold text-primary mb-0"><i class="fas fa-plus-square me-2"></i>Add New Formulation</h6>
            </div>
            <div class="card-body bg-white">
                <form action="${pageContext.request.contextPath}/admin/add-product" method="post" enctype="multipart/form-data">
                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label small fw-bold">Medicine Name</label>
                            <input type="text" name="name" class="form-control bg-light border-0" placeholder="Brand Name + Dosage" required>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label small fw-bold">Therapeutic Category</label>
                            <input type="text" name="category" class="form-control bg-light border-0" 
                                   placeholder="e.g. Antibiotics / Cardiology" required>
                            </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Price (PTR)</label>
                            <input type="number" step="0.01" name="price" class="form-control bg-light border-0" placeholder="0.00" required>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label small fw-bold">Batch Qty</label>
                            <input type="number" name="stock" class="form-control bg-light border-0" placeholder="0" required>
                        </div>
                         <div class="col-md-1">
                             <label class="form-label small fw-bold">Image</label>
                            <label class="btn btn-outline-secondary w-100 p-1">
                                <i class="fas fa-camera"></i> <input type="file" name="image" hidden accept="image/*">
                            </label>
                        </div>
                        <div class="col-md-12">
                            <input type="text" name="desc" class="form-control bg-light border-0" placeholder="Composition and description...">
                        </div>
                        <div class="col-12 text-end">
                            <button class="btn btn-primary px-4 fw-bold">Add to Batch</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Table -->
        <div class="card border-0 shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light text-muted small text-uppercase">
                        <tr>
                            <th class="ps-4">Product Details</th>
                            <th>Category</th>
                            <th>Stock Level</th>
                            <th>Price</th>
                            <th class="d-flex align-items-center justify-content-center" >Batch Refill (Boxes)</th>
                        </tr>
                    </thead>
                    <tbody class="border-top-0">
                        <c:forEach items="${products}" var="p">
                            <tr>
                                <td class="ps-4">
                                    <div class="d-flex align-items-center">
                                        <div class="rounded border p-1 me-3 bg-white" style="width: 40px; height: 40px;">
                         <c:if test="${not empty p.imageBase64}">
                             <img src="data:image/jpeg;base64,${p.imageBase64}" style="max-height: 100%; max-width: 100%; object-fit: contain;">
                         </c:if>
                         <c:if test="${empty p.imageBase64}">
                             <div class="d-flex align-items-center justify-content-center h-100 bg-light rounded">
                                <i class="fas fa-prescription-bottle-alt fa-3x text-secondary opacity-25"></i>
                             </div>
                         </c:if> 
                 

                                        </div>
                                        <div>
                                            <div class="fw-bold text-dark">${p.name}</div>
                                            <small class="text-muted">ID: SKU-${p.id}</small>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="badge bg-light text-dark border">${p.category}</span></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="progress w-100 me-2" style="height: 6px; width: 60px;">
                                            <div class="progress-bar ${p.stockQuantity < 20 ? 'bg-danger' : 'bg-success'}" 
                                                 style="width: ${p.stockQuantity > 100 ? 100 : p.stockQuantity}%"></div>
                                        </div>
                                        <small class="text-muted">${p.stockQuantity}</small>
                                    </div>
                                </td>
                                <td class="fw-bold text-dark">&#8377;${p.price}</td>
                               <td class="text-center " style="min-width: 150px;">
    <form action="${pageContext.request.contextPath}/admin/add-stock" method="post" class="d-flex align-items-center justify-content-center">
        <input type="hidden" name="id" value="${p.id}">
        <div class="input-group input-group-sm" style="width: 120px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
            <!-- Qty input for extra boxes -->
            <input type="number" name="refillQty" 
                   class="form-control text-center fw-bold border-secondary shadow-none" 
                   value="10" min="1" style="font-size: 0.8rem; background-color: #fafafa;">
            
            <!-- Sleek Add Button -->
            <button type="submit" class="btn btn-primary px-3 py-1" style="background-color: #0061ff; border: none;">
                <i class="fas fa-plus-circle small"></i>
            </button>
        </div>
    </form>
</td>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<%@ include file="../common/footer.jsp" %>