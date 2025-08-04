<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bill Details - ${bill.billId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .header-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
        }
        .card {
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: none;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .bill-header {
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            padding: 2rem;
            border-radius: 10px 10px 0 0;
        }
        .info-row {
            border-bottom: 1px solid #e9ecef;
            padding: 0.75rem 0;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            font-weight: 600;
            color: #495057;
        }
        .info-value {
            color: #212529;
        }
        .table th {
            background-color: #f8f9fa;
            border-top: none;
            font-weight: 600;
        }
        .summary-card {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 0.5rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
        }
        .summary-row:last-child {
            border-bottom: none;
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 0.5rem;
            padding-top: 1rem;
            border-top: 2px solid rgba(255, 255, 255, 0.3);
        }
        .bill-id {
            font-family: 'Courier New', monospace;
            background: #f8f9fa;
            padding: 0.5rem;
            border-radius: 5px;
            font-weight: bold;
        }
        .item-image {
            width: 40px;
            height: 40px;
            border-radius: 5px;
            object-fit: cover;
        }
        .print-section {
            background: #fff;
            border-radius: 10px;
            padding: 2rem;
            margin: 2rem 0;
        }
        @media print {
            .no-print {
                display: none !important;
            }
            .print-section {
                box-shadow: none;
                margin: 0;
                padding: 1rem;
            }
        }
    </style>
</head>
<body class="bg-light">
    <!-- Header Section -->
    <div class="header-section no-print">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-0">
                        <i class="fas fa-file-invoice me-3"></i>Bill Details
                    </h1>
                    <p class="mb-0 mt-2 opacity-75">Detailed view of bill ${bill.billId}</p>
                </div>
                <div class="col-md-4 text-end">
                    <button onclick="window.print()" class="btn btn-light">
                        <i class="fas fa-print me-2"></i>Print
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Navigation -->
        <div class="row mb-4 no-print">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="BillController?action=dashboard">
                                <i class="fas fa-home me-1"></i>Dashboard
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="BillController?action=viewAllBills">All Bills</a>
                        </li>
                        <li class="breadcrumb-item active">${bill.billId}</li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="row mb-4 no-print">
            <div class="col-md-6">
                <a href="BillController?action=viewAllBills" class="btn btn-outline-primary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Bills
                </a>
            </div>
            <div class="col-md-6 text-end">
                <a href="BillController?action=printReceipt&billId=${bill.billId}" 
                   class="btn btn-success" target="_blank">
                    <i class="fas fa-download me-2"></i>Download PDF
                </a>
                <button onclick="window.print()" class="btn btn-outline-secondary ms-2">
                    <i class="fas fa-print me-2"></i>Print
                </button>
            </div>
        </div>

        <!-- Print Section -->
        <div class="print-section">
            <!-- Bill Header -->
            <div class="card">
                <div class="bill-header">
                    <div class="row">
                        <div class="col-md-6">
                            <h2 class="text-primary mb-3">
                                <i class="fas fa-receipt me-2"></i>PAHANA EDU (PVT) Ltd
                            </h2>
                            <p class="mb-1">No, 123 Galle Road, Colombo 03</p>
                            <p class="mb-1">Sri Lanka</p>
                            <p class="mb-0">Tel: +94 76 77 60113</p>
                        </div>
                        <div class="col-md-6 text-end">
                            <h3 class="text-primary">INVOICE</h3>
                            <div class="bill-id mt-3">${bill.billId}</div>
                            <p class="mt-2 mb-0">
                                <strong>Date:</strong> 
                                <fmt:formatDate value="${bill.billDate}" pattern="MMMM dd, yyyy"/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Customer Information -->
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-user me-2"></i>Customer Information
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-row">
                                <div class="info-label">Customer Name:</div>
                                <div class="info-value">
                                    <strong>${customer.name}</strong>
                                </div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Account Number:</div>
                                <div class="info-value">
                                    <span class="badge bg-secondary">${customer.accountNumber}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-row">
                                <div class="info-label">Email:</div>
                                <div class="info-value">${customer.email}</div>
                            </div>
                            <div class="info-row">
                                <div class="info-label">Phone:</div>
                                <div class="info-value">${customer.contactNo}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bill Items -->
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-shopping-cart me-2"></i>Items Purchased
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th>Item</th>
                                    <th>Item ID</th>
                                    <th class="text-center">Quantity</th>
                                    <th class="text-end">Unit Price</th>
                                    <th class="text-end">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="subtotal" value="0" />
                                <c:forEach var="billItem" items="${billItems}">
                                    <c:set var="itemName" value="Unknown Item" />
                                    <c:set var="unitPrice" value="0" />
                                    
                                    <c:forEach var="item" items="${allItems}">
                                        <c:if test="${item.item_Id eq billItem.itemId}">
                                            <c:set var="itemName" value="${item.itemName}" />
                                            <c:set var="unitPrice" value="${item.unit_Price}" />
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:set var="lineTotal" value="${billItem.quantity * unitPrice}" />
                                    <c:set var="subtotal" value="${subtotal + lineTotal}" />
                                    
                                    <tr>
                                        <td>
                                            <strong>${itemName}</strong>
                                        </td>
                                        <td>
                                            <code>${billItem.itemId}</code>
                                        </td>
                                        <td class="text-center">
                                            <span class="badge bg-primary">${billItem.quantity}</span>
                                        </td>
                                        <td class="text-end">
                                            <fmt:formatNumber value="${unitPrice}" pattern="$#,##0.00"/>
                                        </td>
                                        <td class="text-end">
                                            <strong>
                                                <fmt:formatNumber value="${lineTotal}" pattern="$#,##0.00"/>
                                            </strong>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Bill Summary -->
            <div class="card">
                <div class="card-body summary-card">
                    <h5 class="mb-4">
                        <i class="fas fa-calculator me-2"></i>Bill Summary
                    </h5>
                    
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span><fmt:formatNumber value="${subtotal}" pattern="$#,##0.00"/></span>
                    </div>
                    
                    <c:set var="discountAmount" value="${subtotal * bill.discount / 100}" />
                    <div class="summary-row">
                        <span>Discount (${bill.discount}%):</span>
                        <span>-<fmt:formatNumber value="${discountAmount}" pattern="$#,##0.00"/></span>
                    </div>
                    
                    <div class="summary-row">
                        <span>TOTAL AMOUNT:</span>
                        <span><fmt:formatNumber value="${bill.totalAmount}" pattern="$#,##0.00"/></span>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="text-center mt-4">
                <p class="text-muted">Thank you for your business!</p>
                <p class="small text-muted">
                    This is a computer-generated invoice. No signature required.
                </p>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>