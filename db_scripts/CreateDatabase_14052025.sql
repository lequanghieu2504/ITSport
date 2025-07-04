-- Table: Categories
CREATE TABLE Categories (
    Category_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES Categories(Category_id)
);

-- Table: Brand
CREATE TABLE Brand (
    Brand_id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255),
    logo_url TEXT
);

-- Table: Product
CREATE TABLE Product (
    Product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    img_url TEXT,
    Category_id INT,
    Brand_id INT,
    FOREIGN KEY (Category_id) REFERENCES Categories(Category_id),
    FOREIGN KEY (Brand_id) REFERENCES Brand(Brand_id)
);

-- Table: User
CREATE TABLE [User] (
    User_id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    password VARCHAR(255),
    phoneNumber VARCHAR(20),
    Address TEXT,
    Role VARCHAR(50)
);

-- Table: Client
CREATE TABLE Client (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES [User](User_id)
);

-- Table: Cart
CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    FOREIGN KEY (cart_id) REFERENCES Client(cart_id)
);

-- Table: Cart_Item
CREATE TABLE Cart_Item (
    cart_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (product_id) REFERENCES Product(Product_id)
);

-- Table: Review
CREATE TABLE Review (
    id INT PRIMARY KEY IDENTITY(1,1),
    comment TEXT,
    rating INT,
    User_id INT,
    product_id INT,
    FOREIGN KEY (User_id) REFERENCES [User](User_id),
    FOREIGN KEY (product_id) REFERENCES Product(Product_id)
);

-- Table: Order
CREATE TABLE [Order] (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_date DATE,
    total_price DECIMAL(10, 2),
    shipping_address TEXT,
    status VARCHAR(50),
    User_id INT,
    FOREIGN KEY (User_id) REFERENCES [User](User_id)
);

-- Table: Order_Item
CREATE TABLE Order_Item (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES [Order](id),
    FOREIGN KEY (product_id) REFERENCES Product(Product_id)
);

-- Table: Shipment
CREATE TABLE Shipment (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    ship_address TEXT,
    shipped_date DATE,
    delivery_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES [Order](id)
);

-- Table: Payment
CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES [Order](id)
);

-- Categories
INSERT INTO Categories (name, parent_id) VALUES 
(N'Quần áo thể thao', NULL),
(N'Giày thể thao', NULL),
(N'Phụ kiện', NULL);

-- Brand
INSERT INTO Brand (name, logo_url) VALUES 
(N'Nike', 'nike_logo.png'),
(N'Adidas', 'adidas_logo.png'),
(N'Puma', 'puma_logo.png');

-- Product
INSERT INTO Product (product_name, description, price, img_url, Category_id, Brand_id) VALUES 
(N'Áo thun thể thao nam', N'Chất liệu co giãn, thoáng mát', 299000, 'ao1.jpg', 1, 1),
(N'Giày chạy bộ nữ', N'Đệm êm, chống trượt', 1200000, 'giay1.jpg', 2, 2),
(N'Túi đựng giày', N'Túi gọn nhẹ, chống nước', 150000, 'phukien1.jpg', 3, 3),
(N'Quần thể thao nữ', N'Dáng ôm, co giãn tốt', 350000, 'quan1.jpg', 1, 1);

-- User
INSERT INTO [User] (Name, password, phoneNumber, Address, Role) VALUES 
(N'Nguyen Van A', '123456', '0909123456', N'Hồ Chí Minh', 'Client'),
(N'Admin User', 'admin123', '0909988777', N'Hà Nội', 'Admin');

-- Client
INSERT INTO Client (User_id) VALUES (1); -- User_id = 1

-- Cart
INSERT INTO Cart (cart_id) VALUES (1); -- cart_id = 1

-- Cart_Item
INSERT INTO Cart_Item (cart_id, product_id, quantity) VALUES 
(1, 1, 2),  -- Áo thun
(1, 2, 1);  -- Giày

-- Review
INSERT INTO Review (comment, rating, User_id, product_id) VALUES 
(N'Sản phẩm rất tốt', 5, 1, 1),
(N'Giày hơi chật nhưng đẹp', 4, 1, 2);

