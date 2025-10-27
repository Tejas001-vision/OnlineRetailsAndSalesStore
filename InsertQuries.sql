-- ProductCategories
INSERT INTO Products.ProductCategories (CategoryCode, CategoryName, CategoryDescription, CreatedBy, CreatedOn)
VALUES ('CAT001', 'Electronics', 'Electronic gadgets and devices', 1, GETDATE()),
       ('CAT002', 'Clothing', 'Men and Women apparel', 1, GETDATE());

-- ProductSubCategories
INSERT INTO Products.ProductSubCategories (CategoryID, SubCategoryCode, SubCategoryName, SubCategoryDescription, CreatedBy, CreatedOn)
VALUES (1, 'SUB001', 'Mobile Phones', 'Smartphones and accessories', 1, GETDATE()),
       (2, 'SUB002', 'Men Shirts', 'Formal and casual shirts', 1, GETDATE());

-- Products
INSERT INTO Products.Products (ProductCode, ProductName, ProductCategoryID, ProductSubCategoryID, CreatedBy, CreatedOn)
VALUES ('PROD001', 'iPhone 15', 1, 1, 1, GETDATE()),
       ('PROD002', 'Raymond Shirt', 2, 2, 1, GETDATE());

-- ProductDetails
INSERT INTO Products.ProductDetails (ProductID, ProductSubCategoryID, SupplierID, ProductUniqueCode, ProductContentDetails, ProductExpirationPeriod, ProductPrice, ProductDescription, QuantityPerUnit, UnitOfMeasure, CreatedBy, CreatedOn)
VALUES (1, 1, 1, 'PU001', '128GB Storage, 6GB RAM', NULL, 79999.99, 'Latest iPhone model', 1, 'Piece', 1, GETDATE()),
       (2, 2, 2, 'PU002', 'Cotton Fabric', NULL, 1499.99, 'Premium quality Raymond shirt', 1, 'Piece', 1, GETDATE());

-- SupplierCategories
INSERT INTO Suppliers.SupplierCategories (SupplierCategoryCode, SupplierCategoryName, SupplierCategoryDescription, CreatedBy, CreatedOn)
VALUES ('SUPCAT001', 'Electronics Supplier', 'Suppliers of electronic goods', 1, GETDATE()),
       ('SUPCAT002', 'Clothing Supplier', 'Suppliers of garments and accessories', 1, GETDATE());

-- Suppliers
INSERT INTO Suppliers.Suppliers (SupplierCode, SupplierName, SupplierCategoryID, SupplierDescription, CreatedBy, CreatedOn)
VALUES ('SUP001', 'Tech Distributors', 1, 'Supplier of Apple products', 1, GETDATE()),
       ('SUP002', 'Raymond Pvt Ltd', 2, 'Clothing manufacturer and distributor', 1, GETDATE());

-- SupplierContactDetails
INSERT INTO Suppliers.SupplierContactDetails (SupplierID, SupplierAddress, SupplierPhoneNo, SupplierAlternatePhoneNo, SupplierGSTNo, SupplierPanNo, SupplierBankNo, SupplierBankName, SupplierIFSCCode, CreatedBy, CreatedOn)
VALUES (1, 'Mumbai, India', '9999999999', '8888888888', 'GST001', 'PAN001', 12345, 'HDFC Bank', 'HDFC0001234', 1, GETDATE()),
       (2, 'Delhi, India', '7777777777', '6666666666', 'GST002', 'PAN002', 67890, 'SBI Bank', 'SBIN0005678', 1, GETDATE());

-- SupplierPaymentDetails
INSERT INTO Suppliers.SupplierPaymentDetails (SupplierID, SupplierPaymentModeID, SupplierPaymentSubcategoryID, SupplierTotalAmount, SupplierPaymentDateTime, TransactionNo, CreatedBy, CreatedOn)
VALUES (1, 1, 1, 100000.00, GETDATE(), 'TRX001', 1, GETDATE()),
       (2, 1, 1, 50000.00, GETDATE(), 'TRX002', 1, GETDATE());

-- SupplierShipmentDetails
INSERT INTO Suppliers.SupplierShipmentDetails (ShipmentCode, SupplierID, ShipmentStatus, ShipmentDateTime, ExpectedDateTime, ShipmentTrackingNo, CreatedBy, CreatedOn)
VALUES ('SHIP001', 1, 'Delivered', GETDATE(), DATEADD(DAY, 3, GETDATE()), 'TRK001', 1, GETDATE()),
       ('SHIP002', 2, 'In Transit', GETDATE(), DATEADD(DAY, 5, GETDATE()), 'TRK002', 1, GETDATE());

-- SupplierStockInDetails
INSERT INTO Suppliers.SupplierStockInDetails (StockInCode, ShipmentID, ProductID, TotalQty, PricePerUnit, TotalPrice, ExpiryDate, BatchNumber, CreatedBy, CreatedOn)
VALUES ('STK001', 1, 1, 10, 78000.00, 780000.00, NULL, 'B001', 1, GETDATE()),
       ('STK002', 2, 2, 50, 1300.00, 65000.00, NULL, 'B002', 1, GETDATE());

-- Customers
INSERT INTO Customers.Customers (CustomerCode, CustomerName, CustomerGender, CreatedBy, CreatedOn)
VALUES ('CUST001', 'Rahul Sharma', 'Male', 1, GETDATE()),
       ('CUST002', 'Neha Patel', 'Female', 1, GETDATE());

-- CustomerContacts
INSERT INTO Customers.CustomerContacts (CustomerID, CustomerPhoneNo, CustomerAlternatePhoneNo, CustomerMailID, CustomerAddress, CustomerBankNo, CustomerBankName, CustomerDefaultPaymentCategoryID, City, State, PostalCode, CreatedBy, CreatedOn)
VALUES (1, '9991112222', '8881112222', 'rahul@gmail.com', 'Pune, India', '123456', 'SBI', 1, 'Pune', 'MH', '411001', 1, GETDATE()),
       (2, '9993334444', '8883334444', 'neha@gmail.com', 'Mumbai, India', '654321', 'ICICI', 1, 'Mumbai', 'MH', '400001', 1, GETDATE());

-- Orders
INSERT INTO Orders.Orders (OrderCode, OrderDateTime, OrderTotalAmount, OrderCustomerID, OrderPaymentType, OrderPaymentStatus, CreatedBy, CreatedOn)
VALUES ('ORD001', GETDATE(), 79999.99, 1, 1, 'PAID', 1, GETDATE()),
       ('ORD002', GETDATE(), 1499.99, 2, 1, 'COD', 1, GETDATE());

-- OrderDetails
INSERT INTO Orders.OrderDetails (OrderID, CustomerID, ProductID, ProductQty, ProductPricePerUnit, ProductTotalUnitPrice, BatchNumber, CreatedBy, CreatedOn)
VALUES (1, 1, 1, 1, 79999.99, 79999.99, 'B001', 1, GETDATE()),
       (2, 2, 2, 1, 1499.99, 1499.99, 'B002', 1, GETDATE());

-- PaymentCategory
INSERT INTO Transactions.PaymentCategory (PaymentCategoryCode, PaymentCategoryName, PaymentCategoryDescription, CreatedBy, CreatedOn)
VALUES ('PAYCAT001', 'Online', 'Online payments', 1, GETDATE()),
       ('PAYCAT002', 'Cash', 'Cash on delivery', 1, GETDATE());

-- PaymentSubCategory
INSERT INTO Transactions.PaymentSubCategory (PaymentSubCategoryCode, PaymentSubCategoryName, PaymentSubCategoryDescription, PaymentCategoryID, CreatedBy, CreatedOn)
VALUES ('PAYSUB001', 'Credit Card', 'Credit card payments', 1, 1, GETDATE()),
       ('PAYSUB002', 'Cash', 'Cash payments', 2, 1, GETDATE());

-- CustomerPayments
INSERT INTO Transactions.CustomerPayments (CustomerPaymentCode, CustomerOrderID, CustomerID, PaymentCategoryID, PaymentSubCategoryID, CustomerTotalAmount, CustomerPaidAmount, CustomerBalanceAmount, CustomerPaidDateTime, TransactionNo, CreatedBy, CreatedOn)
VALUES ('CPAY001', 1, 1, 1, 1, 79999.99, 79999.99, 0.00, GETDATE(), 'TXN001', 1, GETDATE()),
       ('CPAY002', 2, 2, 2, 2, 1499.99, 0.00, 1499.99, GETDATE(), 'TXN002', 1, GETDATE());

-- Roles
INSERT INTO Users.Roles (RoleCode, RoleName, RoleDescription, CreatedBy, CreatedOn)
VALUES ('ADMIN', 'Administrator', 'System administrator role', 1, GETDATE()),
       ('CUSTSRV', 'CustomerService', 'Handles customer queries', 1, GETDATE());

-- Users
INSERT INTO Users.Users (UserCode, UserName, UserPassword, UserRoleID, CreatedBy, CreatedOn)
VALUES ('USR001', 'AdminUser', 'Admin@123', 1, 1, GETDATE()),
       ('USR002', 'SupportUser', 'Support@123', 2, 1, GETDATE());

-- UserContactDetails
INSERT INTO Users.UserContactDetails (UserID, UserIdProofTypeID, UserIdProofNo, UserPhoneNo, UserAlternatePhoneNo, UserAddress, UserEmailID, CreatedBy, CreatedOn)
VALUES (1, 1, 'AADHAR001', '9000000001', '8000000001', 'Pune, India', 'admin@retail.com', 1, GETDATE()),
       (2, 1, 'AADHAR002', '9000000002', '8000000002', 'Mumbai, India', 'support@retail.com', 1, GETDATE());

-- IDProofType
INSERT INTO Security.IDProofType (IDProofTypeCode, IDProofName, IDProofDescription, CreatedBy, CreatedOn)
VALUES ('ID001', 'Aadhar Card', 'Indian national ID', 1, GETDATE()),
       ('ID002', 'PAN Card', 'Tax identification number', 1, GETDATE());

-- Modules
INSERT INTO Security.Modules (ModuleCode, ModuleName, ModuleDescription, CreatedBy, CreatedOn)
VALUES ('MOD001', 'Orders', 'Order management module', 1, GETDATE()),
       ('MOD002', 'Inventory', 'Inventory control module', 1, GETDATE());

-- UserAccessRights
INSERT INTO Security.UserAccessRights (UserID, ModuleID, [Add], [Edit], [Update], [Delete], CreatedBy, CreatedOn)
VALUES (1, 1, 1, 1, 1, 1, 1, GETDATE()),
       (2, 2, 1, 0, 0, 0, 1, GETDATE());

-- Feedback
INSERT INTO Feedback.CustomerReviews (CustomerReviewCode, CustomerReview, CustomerReviewDateTime, CustomerID, OrderID, Rating, CreatedBy, CreatedOn)
VALUES ('REV001', 'Excellent product', GETDATE(), 1, 1, 5, 1, GETDATE()),
       ('REV002', 'Good shirt', GETDATE(), 2, 2, 4, 1, GETDATE());

-- Returns
INSERT INTO Returns.OrderReturns (OrderReturnCode, OrderID, CustomerID, OrderReturnReason, OrderReturnDateTime, OrderReturnAmount, CreatedBy, CreatedOn)
VALUES ('RET001', 1, 1, 'Defective item', GETDATE(), 79999.99, 1, GETDATE()),
       ('RET002', 2, 2, 'Size issue', GETDATE(), 1499.99, 1, GETDATE());

-- Support
INSERT INTO Support.CustomerSupportTickets (CustomerSupportTicketCode, CustomerSupportTicketReason, CustomerSupportTicketStatus, CustomerSupportTicketDateTime, CustomerID, OrderID, AssignedToUserID, CreatedBy, CreatedOn)
VALUES ('TKT001', 'Late delivery', 'Open', GETDATE(), 1, 1, 2, 1, GETDATE()),
       ('TKT002', 'Wrong product', 'Closed', GETDATE(), 2, 2, 2, 1, GETDATE());

-- Inventory
INSERT INTO Inventory.InventoryStock (InventoryStockCode, ProductID, StockInID, BatchNumber, TotalReceivedQty, CurrentStockQty, MinimumStockQty, PricePerUnit, TotalValue, CreatedBy, CreatedOn)
VALUES ('INV001', 1, 1, 'B001', 10, 8, 2, 78000.00, 624000.00, 1, GETDATE()),
       ('INV002', 2, 2, 'B002', 50, 49, 5, 1300.00, 63700.00, 1, GETDATE());

-- Delivery
INSERT INTO Delivery.ShipmentDetails (ShipmentCode, TrackingNumber, OrderID, CustomerID, ShipmentDate, ExpectedDeliveryDate, ShipmentStatus, CourierPersonName, CourierPersonContactNo, NoOfItems, ShippingCharges, PaymentStatus, IsDelivered, CreatedBy, CreatedOn)
VALUES ('D001', 'TRKDEL001', 1, 1, GETDATE(), DATEADD(DAY, 3, GETDATE()), 'Delivered', 'Ramesh', '9998887777', 1, 100.00, 'Paid', 1, 1, GETDATE()),
       ('D002', 'TRKDEL002', 2, 2, GETDATE(), DATEADD(DAY, 4, GETDATE()), 'In Transit', 'Suresh', '9995554444', 1, 50.00, 'Pending', 0, 1, GETDATE());
