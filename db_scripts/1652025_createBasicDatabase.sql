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