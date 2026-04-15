<%@ include file="../common/header.jsp" %>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h2 class="fw-bold text-dark"><i class="fas fa-chart-line text-primary me-2"></i>Business Analytics</h2>
        <button class="btn btn-sm btn-outline-secondary" onclick="window.print()"><i class="fas fa-print me-1"></i> Print Report</button>
    </div>

    <!-- 1. KEY PERFORMANCE INDICATORS (KPI) CARDS -->
    <div class="row g-3 mb-5">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-primary text-white p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase small mb-1">Total Revenue (Approved)</h6>
                        <h3 class="fw-bold mb-0">&#8377;${totalRevenue != null ? totalRevenue : '0.00'}</h3>
                    </div>
                    <i class="fas fa-dollar-sign fa-2x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-success text-white p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase small mb-1">Live Inventory Items</h6>
                        <h3 class="fw-bold mb-0">${totalProducts} SKU's</h3>
                    </div>
                    <i class="fas fa-pills fa-2x opacity-50"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm bg-dark text-white p-3">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="text-uppercase small mb-1">Total Purchase Orders</h6>
                        <h3 class="fw-bold mb-0">${totalOrders} Orders</h3>
                    </div>
                    <i class="fas fa-file-invoice fa-2x opacity-50"></i>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- 2. PRODUCT-WISE DISPATCH REPORT (Movement) -->
        <div class="col-lg-7 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white fw-bold py-3">
                    <i class="fas fa-box-open me-2 text-warning"></i>Medicine Movement (Boxes Sold)
                </div>
                <div class="card-body">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light small">
                            <tr>
                                <th>Medicine Name</th>
                                <th class="text-center">Total Dispatch (Boxes)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${productSales}" var="row">
                                <tr>
                                    <td>${row[0]}</td>
                                    <td class="text-center fw-bold text-primary">${row[1]}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 3. TOP STOCKISTS REPORT -->
        <div class="col-lg-5 mb-4">
            <div class="card shadow-sm border-0 h-100">
                <div class="card-header bg-white fw-bold py-3">
                    <i class="fas fa-user-tie me-2 text-info"></i>Top Performing Stockists
                </div>
                <div class="card-body">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light small">
                            <tr>
                                <th>Distributor Name</th>
                                <th class="text-end">Total Business</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${stockistSales}" var="row">
                                <tr>
                                    <td>${row[0]}</td>
                                    <td class="text-end fw-bold text-success">&#8377;${row[1]}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 4. INVENTORY / STOCK REPORT -->
        <div class="col-lg-12">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white fw-bold py-3">
                    <i class="fas fa-warehouse me-2 text-danger"></i>Warehouse Stock Status
                </div>
                <div class="card-body">
                    <table class="table table-bordered align-middle">
                        <thead class="bg-light small">
                            <tr>
                                <th>SKU Name</th>
                                <th>Category</th>
                                <th class="text-center">Rate/Box</th>
                                <th class="text-center">Available Stock (Boxes)</th>
                                <th class="text-end">Inventory Value</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${inventory}" var="p">
                                <tr class="${p.stockQuantity < 50 ? 'table-warning' : ''}">
                                    <td>${p.name}</td>
                                    <td class="small text-muted">${p.category}</td>
                                    <td class="text-center">&#8377;${p.price}</td>
                                    <td class="text-center fw-bold ${p.stockQuantity < 50 ? 'text-danger' : ''}">
                                        ${p.stockQuantity}
                                    </td>
                                    <td class="text-end fw-bold">&#8377;${p.price * p.stockQuantity}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>