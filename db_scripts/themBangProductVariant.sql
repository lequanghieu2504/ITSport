CREATE TABLE ProductVariant (
    id INT PRIMARY KEY IDENTITY(1,1),
    product_id INT NOT NULL,
    size VARCHAR(10) NOT NULL,
    quantity INT NOT NULL,
    sku VARCHAR(50) NOT NULL,
    -- Giả sử bạn có bảng Product nên thêm FOREIGN KEY:
    CONSTRAINT FK_ProductVariant_Product FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
);
