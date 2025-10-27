-- ==============================================
-- SCHEMA: Products
-- ==============================================

CREATE TABLE Products.ProductCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryCode VARCHAR(20) UNIQUE NOT NULL,
    CategoryName VARCHAR(50) UNIQUE NOT NULL,
    CategoryDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Products.ProductSubCategories (
    SubCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryID INT NOT NULL FOREIGN KEY REFERENCES Products.ProductCategories(CategoryID),
    SubCategoryCode VARCHAR(20) UNIQUE NOT NULL,
    SubCategoryName VARCHAR(50) UNIQUE NOT NULL,
    SubCategoryDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Products.Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductCode VARCHAR(20) UNIQUE NOT NULL,
    ProductName VARCHAR(50) NOT NULL,
    ProductCategoryID INT NOT NULL FOREIGN KEY REFERENCES Products.ProductCategories(CategoryID),
    -- Added below line to link subcategory directly for filtering and reporting purpose
    ProductSubCategoryID INT FOREIGN KEY REFERENCES Products.ProductSubCategories(SubCategoryID), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Products.ProductDetails (
    ProductDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products.Products(ProductID),
    ProductSubCategoryID INT NOT NULL FOREIGN KEY REFERENCES Products.ProductSubCategories(SubCategoryID),
    SupplierID INT NOT NULL,
    ProductUniqueCode VARCHAR(20) NOT NULL,
    ProductContentDetails VARCHAR(MAX),
    ProductExpirationPeriod INT,
    ProductPrice DECIMAL(10,2),
    ProductDescription VARCHAR(MAX),
    -- Added below for inventory tracking integration
    QuantityPerUnit INT, -- Added column
    UnitOfMeasure VARCHAR(20), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Suppliers
-- ==============================================

CREATE TABLE Suppliers.SupplierCategories (
    SupplierCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierCategoryCode VARCHAR(20) UNIQUE NOT NULL,
    SupplierCategoryName VARCHAR(50) UNIQUE NOT NULL,
    SupplierCategoryDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Suppliers.Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierCode VARCHAR(20) UNIQUE NOT NULL,
    SupplierName VARCHAR(50) NOT NULL,
    SupplierCategoryID INT NOT NULL FOREIGN KEY REFERENCES Suppliers.SupplierCategories(SupplierCategoryID),
    SupplierDescription VARCHAR(MAX),
    -- Added below to maintain active/inactive supplier status
    IsActive BIT DEFAULT 1, -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Suppliers.SupplierContactDetails (
    SupplierContactDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID INT NOT NULL FOREIGN KEY REFERENCES Suppliers.Suppliers(SupplierID),
    SupplierAddress VARCHAR(MAX),
    SupplierPhoneNo VARCHAR(20) UNIQUE NOT NULL,
    SupplierAlternatePhoneNo VARCHAR(20),
    SupplierGSTNo VARCHAR(20) UNIQUE NOT NULL,
    SupplierPanNo VARCHAR(20) UNIQUE NOT NULL,
    SupplierBankNo INT NOT NULL,
    -- Added below for better financial tracking
    SupplierBankName VARCHAR(100), -- Added column
    SupplierIFSCCode VARCHAR(15), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Suppliers.SupplierPaymentDetails (
    SupplierPaymentDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID INT NOT NULL FOREIGN KEY REFERENCES Suppliers.Suppliers(SupplierID),
    SupplierPaymentModeID INT NOT NULL,
    SupplierPaymentSubcategoryID INT NOT NULL,
    SupplierTotalAmount DECIMAL(10,2),
    SupplierPaymentDateTime DATETIME NOT NULL,
    TransactionNo VARCHAR(20) UNIQUE NOT NULL,
    -- Added below to handle payment confirmation
    PaymentStatus VARCHAR(20) DEFAULT 'Pending', -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Suppliers.SupplierShipmentDetails (
    SupplierShipmentID INT IDENTITY(1,1) PRIMARY KEY,
    ShipmentCode VARCHAR(20) UNIQUE NOT NULL,
    SupplierID INT NOT NULL FOREIGN KEY REFERENCES Suppliers.Suppliers(SupplierID),
    ShipmentStatus VARCHAR(50),
    ShipmentDateTime DATETIME NOT NULL,
    ExpectedDateTime DATETIME NOT NULL,
    DeliveredDateTime DATETIME,
    ShipmentTrackingNo VARCHAR(50),
    LastShipmentStatusUpdateTime DATETIME,
    -- Added below for linking to payment
    SupplierPaymentDetailsID INT FOREIGN KEY REFERENCES Suppliers.SupplierPaymentDetails(SupplierPaymentDetailsID), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Suppliers.SupplierStockInDetails (
    StockInID INT IDENTITY(1,1) PRIMARY KEY,
    StockInCode VARCHAR(20) UNIQUE NOT NULL,
    ShipmentID INT NOT NULL FOREIGN KEY REFERENCES Suppliers.SupplierShipmentDetails(SupplierShipmentID),
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products.Products(ProductID),
    TotalQty INT,
    PricePerUnit DECIMAL(10,2),
    TotalPrice DECIMAL(10,2),
    ExpiryDate DATETIME,
    BatchNumber VARCHAR(20) UNIQUE NOT NULL,
    -- Added below for inventory reconciliation
    ReceivedDate DATETIME NOT NULL DEFAULT GETDATE(), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);


-- ==============================================
-- SCHEMA: Customers
-- ==============================================

CREATE TABLE Customers.Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerCode VARCHAR(20) UNIQUE NOT NULL,
    CustomerName VARCHAR(150) NOT NULL,
    CustomerGender VARCHAR(20) NOT NULL,
    -- Added below to track customer status
    IsActive BIT DEFAULT 1, -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Customers.CustomerContacts (
    CustomerContactID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    CustomerPhoneNo VARCHAR(20) UNIQUE NOT NULL,
    CustomerAlternatePhoneNo VARCHAR(20),
    CustomerMailID VARCHAR(50) NOT NULL,
    CustomerAddress VARCHAR(MAX),
    CustomerBankNo VARCHAR(20),
    CustomerBankName VARCHAR(150),
    CustomerDefaultPaymentCategoryID INT NOT NULL,
    -- Added below for better data consistency
    City VARCHAR(50), -- Added column
    State VARCHAR(50), -- Added column
    PostalCode VARCHAR(10), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Orders
-- ==============================================

CREATE TABLE Orders.Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderCode VARCHAR(20) UNIQUE NOT NULL,
    OrderDateTime DATETIME NOT NULL,
    OrderTotalAmount DECIMAL(10,2),
    OrderCustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    OrderPaymentType INT NOT NULL,
    OrderPaymentStatus CHAR(7) CHECK (OrderPaymentStatus IN ('PAID','UNPAID','COD')),
    -- Added below to manage order lifecycle
    OrderStatus VARCHAR(30) DEFAULT 'Pending', -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Orders.OrderDetails (
    OrderDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products.Products(ProductID),
    ProductQty INT,
    ProductPricePerUnit DECIMAL(10,2),
    ProductTotalUnitPrice DECIMAL(10,2),
    -- Added below for stock linking
    BatchNumber VARCHAR(20), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Orders.OrderStatus (
    OrderStatusID INT IDENTITY(1,1) PRIMARY KEY,
    OrderStatusCode VARCHAR(20) UNIQUE NOT NULL,
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    OrderStatus VARCHAR(50) NOT NULL,
    OrderTrackingNo VARCHAR(50),
    OrderDateTime DATETIME NOT NULL,
    ExpectedDateTime DATETIME NOT NULL,
    DeliveredDateTime DATETIME,
    LastOrderStatusUpdateTime DATETIME NOT NULL,
    -- Added below for shipment linkage
    ShipmentID INT FOREIGN KEY REFERENCES Delivery.ShipmentDetails(ShipmentID), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Transactions
-- ==============================================

CREATE TABLE Transactions.PaymentCategory (
    PaymentCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentCategoryCode VARCHAR(20) UNIQUE NOT NULL,
    PaymentCategoryName VARCHAR(50) UNIQUE NOT NULL,
    PaymentCategoryDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Transactions.PaymentSubCategory (
    PaymentSubCategoryID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentSubCategoryCode VARCHAR(20) UNIQUE NOT NULL,
    PaymentSubCategoryName VARCHAR(50) UNIQUE NOT NULL,
    PaymentSubCategoryDescription VARCHAR(MAX),
    PaymentCategoryID INT NOT NULL FOREIGN KEY REFERENCES Transactions.PaymentCategory(PaymentCategoryID),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Transactions.CustomerPayments (
    CustomerPaymentID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerPaymentCode VARCHAR(20) UNIQUE NOT NULL,
    CustomerOrderID INT NOT NULL FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    PaymentCategoryID INT NOT NULL FOREIGN KEY REFERENCES Transactions.PaymentCategory(PaymentCategoryID),
    PaymentSubCategoryID INT NOT NULL FOREIGN KEY REFERENCES Transactions.PaymentSubCategory(PaymentSubCategoryID),
    CustomerTotalAmount DECIMAL(10,2),
    CustomerPaidAmount DECIMAL(10,2),
    CustomerBalanceAmount DECIMAL(10,2),
    CustomerPaidDateTime DATETIME NOT NULL,
    TransactionNo VARCHAR(20) UNIQUE NOT NULL,
    -- Added below for audit purpose
    PaymentStatus VARCHAR(20) DEFAULT 'Pending', -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Users
-- ==============================================

CREATE TABLE Users.Roles (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleCode VARCHAR(20) UNIQUE NOT NULL,
    RoleName VARCHAR(50) UNIQUE NOT NULL,
    RoleDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Users.Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserCode VARCHAR(20) UNIQUE NOT NULL,
    UserName VARCHAR(50) NOT NULL,
    UserPassword VARCHAR(100) NOT NULL, -- increased size for hashed passwords
    UserRoleID INT NOT NULL FOREIGN KEY REFERENCES Users.Roles(RoleID),
    -- Added below for login tracking
    LastLoginDate DATETIME, -- Added column
    IsActive BIT DEFAULT 1, -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Users.UserContactDetails (
    UserContactDetailsID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users.Users(UserID),
    UserIdProofTypeID INT NOT NULL,
    UserIdProofNo VARCHAR(20) UNIQUE NOT NULL,
    UserPhoneNo VARCHAR(20) UNIQUE NOT NULL,
    UserAlternatePhoneNo VARCHAR(20),
    UserAddress VARCHAR(MAX),
    UserEmailID VARCHAR(100) UNIQUE NOT NULL, -- increased length for modern emails
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Security
-- ==============================================

CREATE TABLE Security.IDProofType (
    IDProofTypeID INT IDENTITY(1,1) PRIMARY KEY,
    IDProofTypeCode VARCHAR(20) UNIQUE NOT NULL,
    IDProofName VARCHAR(50) UNIQUE NOT NULL,
    IDProofDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Security.Modules (
    ModuleID INT IDENTITY(1,1) PRIMARY KEY,
    ModuleCode VARCHAR(20) UNIQUE NOT NULL,
    ModuleName VARCHAR(50) UNIQUE NOT NULL,
    ModuleDescription VARCHAR(MAX),
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

CREATE TABLE Security.UserAccessRights (
    UserAccessRightID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users.Users(UserID),
    ModuleID INT NOT NULL FOREIGN KEY REFERENCES Security.Modules(ModuleID),
    [Add] BIT,
    [Edit] BIT,
    [Update] BIT,
    [Delete] BIT,
    -- Added below to track audit status
    IsActive BIT DEFAULT 1, -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Feedback
-- ==============================================

CREATE TABLE Feedback.CustomerReviews (
    CustomerReviewID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerReviewCode VARCHAR(20) UNIQUE NOT NULL,
    CustomerReview VARCHAR(MAX),
    CustomerReviewDateTime DATETIME NOT NULL,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    -- Added below to handle review ratings
    Rating INT CHECK (Rating BETWEEN 1 AND 5), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Returns
-- ==============================================

CREATE TABLE Returns.OrderReturns (
    OrderReturnID INT IDENTITY(1,1) PRIMARY KEY,
    OrderReturnCode VARCHAR(20) UNIQUE NOT NULL,
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    OrderReturnReason VARCHAR(MAX),
    OrderReturnDateTime DATETIME NOT NULL,
    OrderReturnAmount DECIMAL(10,2),
    -- Added below to capture approval & status of return
    ReturnStatus VARCHAR(30) DEFAULT 'Pending', -- Added column
    ApprovedBy INT, -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Support
-- ==============================================

CREATE TABLE Support.CustomerSupportTickets (
    CustomerSupportTicketID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerSupportTicketCode VARCHAR(20) UNIQUE NOT NULL,
    CustomerSupportTicketReason VARCHAR(MAX),
    CustomerSupportTicketStatus VARCHAR(20) NOT NULL,
    CustomerSupportTicketDateTime DATETIME NOT NULL,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    OrderID INT NOT NULL FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    -- Added below for assignment and priority
    AssignedToUserID INT FOREIGN KEY REFERENCES Users.Users(UserID), -- Added column
    PriorityLevel VARCHAR(20) DEFAULT 'Normal', -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Inventory
-- ==============================================

CREATE TABLE Inventory.InventoryStock (
    InventoryStockID INT IDENTITY(1,1) PRIMARY KEY,
    InventoryStockCode VARCHAR(20) UNIQUE NOT NULL,
    ProductID INT NOT NULL FOREIGN KEY REFERENCES Products.Products(ProductID),
    StockInID INT NOT NULL FOREIGN KEY REFERENCES Suppliers.SupplierStockInDetails(StockInID),
    BatchNumber VARCHAR(20) UNIQUE NOT NULL,
    TotalReceivedQty INT,
    CurrentStockQty INT,
    MinimumStockQty INT,
    PricePerUnit DECIMAL(10,2),
    TotalValue DECIMAL(10,2),
    -- Added below for real-time status tracking
    LastStockUpdate DATETIME DEFAULT GETDATE(), -- Added column
    StockStatus VARCHAR(20) DEFAULT 'Available', -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);

-- ==============================================
-- SCHEMA: Delivery
-- ==============================================

CREATE TABLE Delivery.ShipmentDetails (
    ShipmentID INT IDENTITY(1,1) PRIMARY KEY,
    ShipmentCode VARCHAR(20) UNIQUE NOT NULL,
    TrackingNumber VARCHAR(50),
    OrderID INT FOREIGN KEY REFERENCES Orders.Orders(OrderID),
    CustomerID INT FOREIGN KEY REFERENCES Customers.Customers(CustomerID),
    ShipmentDate DATETIME,
    ExpectedDeliveryDate DATETIME,
    ActualDeliveryDate DATETIME,
    ShipmentStatus VARCHAR(30),
    CourierPersonName VARCHAR(100),
    CourierPersonContactNo VARCHAR(15),
    NoOfItems INT,
    ShippingCharges DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    Remarks VARCHAR(250),
    ReturnReason VARCHAR(200),
    IsReturnShipment BIT,
    IsDelivered BIT,
    DeliveryProofURL VARCHAR(255),
    -- Added below for logistics integration
    CourierCompanyName VARCHAR(100), -- Added column
    DeliveryAddress VARCHAR(MAX), -- Added column
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    UpdatedBy INT,
    UpdatedOn DATETIME
);
