<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Billing Dashboard</title>
<script>
    var currentBillId = null;
    
    function updateCustomerInfo() {
        var select = document.getElementById("customer");
        var option = select.options[select.selectedIndex];
        document.getElementById("customerName").innerHTML = option.value ? "Customer: " + option.getAttribute("data-name") : "Customer: ";
    }
    
    function updateSelectionUnitPrice() {
        var select = document.getElementById("itemSelect");
        var option = select.options[select.selectedIndex];
        var price = parseFloat(option.getAttribute("data-price")) || 0;
        var stock = parseInt(option.getAttribute("data-stock")) || 0;
        
        document.getElementById("unitPriceDisplay").innerHTML = "$" + price.toFixed(2);
        document.getElementById("stockDisplay").innerHTML = "Stock: " + stock;
    }
    
    function addItemToTable() {
        var itemSelect = document.getElementById("itemSelect");
        var quantityInput = document.getElementById("quantityInput");
        var option = itemSelect.options[itemSelect.selectedIndex];
        var quantity = parseInt(quantityInput.value) || 0;
        var stock = parseInt(option.getAttribute("data-stock")) || 0;
        
        if (!option.value || quantity <= 0) {
            alert("Please select an item and enter quantity");
            return;
        }
        
        // Check stock availability
        if (quantity > stock) {
            alert("Not enough stock! Available: " + stock + ", Requested: " + quantity);
            return;
        }
        
        // Check if item already added
        var table = document.getElementById("itemsTable");
        var existingQty = 0;
        for (var i = 1; i < table.rows.length; i++) {
            if (table.rows[i].getAttribute('data-item-id') === option.value) {
                existingQty += parseInt(table.rows[i].getAttribute('data-quantity'));
            }
        }
        
        if ((existingQty + quantity) > stock) {
            alert("Not enough stock! Available: " + stock + ", Already added: " + existingQty + ", Requested: " + quantity);
            return;
        }
        
        // Add row
        var row = table.insertRow(table.rows.length);
        var price = parseFloat(option.getAttribute("data-price"));
        var total = quantity * price;
        
        row.innerHTML = '<td>' + option.text + '</td><td>' + quantity + '</td><td>$' + price.toFixed(2) + '</td><td>$' + total.toFixed(2) + '</td><td><button onclick="removeRow(this)">Remove</button></td>';
        row.setAttribute('data-item-id', option.value);
        row.setAttribute('data-quantity', quantity);
        
        // Reset
        itemSelect.selectedIndex = 0;
        quantityInput.value = "";
        document.getElementById("unitPriceDisplay").innerHTML = "$0.00";
        document.getElementById("stockDisplay").innerHTML = "Stock: 0";
        
        calculateTotal();
    }
    
    function removeRow(btn) {
        btn.parentNode.parentNode.remove();
        calculateTotal();
    }
    
    function calculateTotal() {
        var total = 0;
        var table = document.getElementById("itemsTable");
        for (var i = 1; i < table.rows.length; i++) {
            total += parseFloat(table.rows[i].cells[3].innerHTML.replace('$', ''));
        }
        
        var discount = parseFloat(document.getElementById("discount").value) || 0;
        var discountAmt = (total * discount) / 100;
        var finalTotal = total - discountAmt;
        
        document.getElementById("subtotal").innerHTML = "$" + total.toFixed(2);
        document.getElementById("discountAmount").innerHTML = "$" + discountAmt.toFixed(2);
        document.getElementById("total").innerHTML = "$" + finalTotal.toFixed(2);
    }
    
    function saveBill() {
        var customer = document.getElementById("customer").value;
        var table = document.getElementById("itemsTable");
        
        if (!customer) { alert("Please select a customer"); return; }
        if (table.rows.length <= 1) { alert("Please add items"); return; }
        if (currentBillId) { alert("Bill saved: " + currentBillId + ". Click 'New Bill'"); return; }
        
        var form = document.createElement('form');
        form.method = 'post';
        form.action = 'BillController';
        form.innerHTML = '<input type="hidden" name="action" value="generateBill">' +
                        '<input type="hidden" name="customer" value="' + customer + '">' +
                        '<input type="hidden" name="discount" value="' + document.getElementById("discount").value + '">';
        
        // Add items
        for (var i = 1; i < table.rows.length; i++) {
            var row = table.rows[i];
            form.innerHTML += '<input type="hidden" name="itemId" value="' + row.getAttribute('data-item-id') + '">' +
                             '<input type="hidden" name="quantity" value="' + row.getAttribute('data-quantity') + '">';
        }
        
        document.body.appendChild(form);
        form.submit();
    }
    
    function printBill() {
        if (currentBillId) {
            window.open("BillController?action=printReceipt&billId=" + currentBillId, "_blank");
        } else {
            alert("Save bill first");
        }
    }
    
    function newBill() {
        var table = document.getElementById("itemsTable");
        if (table.rows.length > 1 && !currentBillId && !confirm("Clear unsaved data?")) return;
        
        document.getElementById("customer").selectedIndex = 0;
        document.getElementById("customerName").innerHTML = "Customer: ";
        document.getElementById("itemSelect").selectedIndex = 0;
        document.getElementById("quantityInput").value = "";
        document.getElementById("unitPriceDisplay").innerHTML = "$0.00";
        document.getElementById("stockDisplay").innerHTML = "Stock: 0";
        document.getElementById("discount").value = "0";
        
        while (table.rows.length > 1) table.deleteRow(1);
        
        currentBillId = null;
        updateButtonStates();
        if (window.history.replaceState) window.history.replaceState({}, document.title, "BillController?action=dashboard");
    }
    
    function updateButtonStates() {
        var saveBtn = document.getElementById("saveBtn");
        var printBtn = document.getElementById("printBtn");
        
        if (currentBillId) {
            saveBtn.innerHTML = "Bill Saved ✓";
            saveBtn.disabled = true;
            printBtn.disabled = false;
        } else {
            saveBtn.innerHTML = "Save Bill";
            saveBtn.disabled = false;
            printBtn.disabled = true;
        }
    }
    
    window.onload = function() {
        var today = new Date();
        document.getElementById("todayDate").innerHTML = "Date: " + today.getFullYear() + '-' + 
            String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');
        
        var params = new URLSearchParams(window.location.search);
        if (params.get('success') === 'true') {
            currentBillId = params.get('billId');
            updateButtonStates();
        }
    }
</script>
</head>
<body>
    <h1>Billing Dashboard</h1>
    <p id="todayDate">Date: </p>
    
    <c:if test="${param.success == 'true'}">
        <script>alert("Bill saved! ID: ${param.billId}"); currentBillId = '${param.billId}';</script>
    </c:if>
    <c:if test="${param.error == 'true'}">
        <script>alert("Error saving bill");</script>
    </c:if>
    <c:if test="${param.error == 'customer_not_found'}">
        <script>alert("Customer not found");</script>
    </c:if>
    
    <h2>Customer</h2>
    <table>
        <tr>
            <td>Select Customer:</td>
            <td>
                <select id="customer" onchange="updateCustomerInfo()">
                    <option value="">Search Customer</option>
                    <c:forEach var="customer" items="${customers}">
                        <option value="${customer.accountNumber}" data-name="${customer.name}">
                            ${customer.name} - ${customer.accountNumber}
                        </option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr><td colspan="2"><span id="customerName">Customer: </span></td></tr>
    </table>
    
    <h2>Add Items</h2>
    <table>
        <tr>
            <td>Item:</td>
            <td>
                <select id="itemSelect" onchange="updateSelectionUnitPrice()">
                    <option value="">Select Item</option>
                    <c:forEach var="item" items="${items}">
                        <option value="${item.item_Id}" data-price="${item.unit_Price}" data-stock="${item.stockQuantity}">
                            ${item.itemName} (Stock: ${item.stockQuantity})
                        </option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr><td>Quantity:</td><td><input type="number" id="quantityInput" min="1"></td></tr>
        <tr><td>Unit Price:</td><td><span id="unitPriceDisplay">$0.00</span></td></tr>
        <tr><td>Stock:</td><td><span id="stockDisplay">Stock: 0</span></td></tr>
        <tr><td colspan="2"><button onclick="addItemToTable()">Add Item</button></td></tr>
    </table>
    
    <h2>Selected Items</h2>
    <table id="itemsTable" border="1">
        <tr><th>Item</th><th>Qty</th><th>Price</th><th>Total</th><th>Action</th></tr>
    </table>
    
    <h2>Summary</h2>
    <table>
        <tr><td>Discount (%):</td><td><input type="number" id="discount" value="0" min="0" max="100" onchange="calculateTotal()"></td></tr>
        <tr><td>Subtotal:</td><td><span id="subtotal">$0.00</span></td></tr>
        <tr><td>Discount:</td><td><span id="discountAmount">$0.00</span></td></tr>
        <tr><td><b>Total:</b></td><td><b><span id="total">$0.00</span></b></td></tr>
    </table>
    
    <h2>Actions</h2>
    <button id="saveBtn" onclick="saveBill()">Save Bill</button>
    <button id="printBtn" onclick="printBill()" disabled>Print Receipt</button>
    <button onclick="newBill()">New Bill</button>
    
</body>
</html>