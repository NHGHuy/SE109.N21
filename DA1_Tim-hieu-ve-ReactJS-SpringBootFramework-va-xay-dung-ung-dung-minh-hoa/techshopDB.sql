DROP DATABASE TECHSHOP;
CREATE DATABASE TECHSHOP CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci';
USE TECHSHOP;

-- **************************************************************************************************************
-- create table --
CREATE TABLE BRAND (
    brandID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    brandName VARCHAR(40),
    brandImg VARCHAR(40),
    isDeleted BOOL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE CATEGORY (
    categoryID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    categoryName VARCHAR(40),
    categorySlug VARCHAR(40),
    categoryExact BOOL,
    isDeleted BOOL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE `USER`(
    userID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fullname VARCHAR(40),
    email VARCHAR(100),
    pswd VARCHAR(100) DEFAULT '1',
    DOB DATE,
    phone VARCHAR(12),
    address VARCHAR(40),
    roleID INT DEFAULT 1,
    gender VARCHAR(7),
    totalInvoices INT DEFAULT 0,
    isDeleted BOOL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE ROLE (
    roleID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    roleName VARCHAR(30)
) ENGINE=INNODB ;

CREATE TABLE INVOICE (
    invoiceID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userID INT,
    totalCost INT,
    invoiceDate DATE,
    shippingDate DATE,
    note TEXT,
    userInvoiceIndex VARCHAR(30),
    statusInvoice VARCHAR(30) DEFAULT 'PENDING',
    otherShippingAddress BOOL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE DETAILEDINVOICE (
	detailedInvoiceID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    invoiceID INT,
    productID INT,
    quantity INT,
    price INT,
    totalPrice INT,
    isReviewed  BOOL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE SHIPPINGINFO (
	shippingInfoID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    invoiceID INT,
    fullname VARCHAR(40),
    phone VARCHAR(12),
    address VARCHAR(40)
) ENGINE=INNODB;

CREATE TABLE PRODUCT (
    productID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    categoryID INT, 
    brandID INT,
    productRate FLOAT,
    productName VARCHAR(200),
    productPrice INT,
    shortDescrip TEXT,
    shortTech TEXT,
    longDescrip TEXT,
    stock INT,
    warranty INT,
    purchased INT,
    specs TEXT,
    isSale BOOL DEFAULT FALSE,
    totalReviews INT DEFAULT 0,
    images TEXT,
    isDeleted BOOL DEFAULT FALSE
) ENGINE=INNODB;

-- lưu trữ giá của những chương trình sale
-- Trong SALE_PRODUCTS, 1 productID chỉ có 1 row sale hiện hành, còn tất cả row còn lại đều là isDeleted = true
-- khi thêm 1 chương trình sale, set isSale = true

-- trong TH lấy những sp sale thì lấy trong bảng SALE_PRODUCTS join với bảng product
-- lấy các sp sale có isDeleted = false
-- 		Nếu trước startDate thì bỏ qua
-- 		Nếu trong tgian sale thì lấy 
-- 		Nếu sau endDate thì 
-- 			set isDeleted = true trong SALE_PRODUCT
-- 			set isSale = false trong PRODUCT

-- trong TH lấy từ giá từ bảng product: 
-- 		Nếu isSale = false thì lấy giá trong Product
--  	Nếu isSale = true thì check expired trong SALE_PRODUCT: lấy các row có isDeleted = false
-- 			Nếu trước startDate thì lấy price trong PRODUCT
-- 			Nếu trong tgian sale thì lấy price trong SALE_PRODUCT
-- 			Nếu sau endDate thì set isSale = false, lấy price trong PRODUCT và isDeleted = true trong SALE_PRODUCT

CREATE TABLE SALEPRODUCT (
    productID INT,
    startSale DATE,
    endSale DATE,
    productPrice INT,
    isDeleted BOOL DEFAULT FALSE
) ENGINE=INNODB;

CREATE TABLE REVIEW (
	reviewID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    productID INT,
    userID INT,
    reviewDate DATE,
    reviewContent TEXT,
    rate FLOAT,
    isDeleted BOOL DEFAULT FALSE
) ENGINE=INNODB;
-- **************************************************************************************************************
-- foreign key
-- PRODUCT
ALTER TABLE PRODUCT ADD CONSTRAINT PRD_BRAND_FK FOREIGN KEY(brandID) REFERENCES BRAND(brandID);
ALTER TABLE PRODUCT ADD CONSTRAINT PRD_CATEGORY_FK FOREIGN KEY(categoryID) REFERENCES CATEGORY(categoryID);

-- ROLE_USER
ALTER TABLE USER ADD CONSTRAINT USER_ROLE_USER_FK FOREIGN KEY(roleID) REFERENCES `ROLE`(roleID);

-- INVOICE
ALTER TABLE INVOICE ADD CONSTRAINT INVOICE_USER_FK FOREIGN KEY(userID) REFERENCES `USER`(userID);

-- DETAILED_INVOICE
ALTER TABLE DETAILEDINVOICE ADD CONSTRAINT DI_INVOICE_FK FOREIGN KEY(invoiceID) REFERENCES INVOICE(invoiceID);
ALTER TABLE DETAILEDINVOICE ADD CONSTRAINT DI_PRD_FK FOREIGN KEY(productID) REFERENCES PRODUCT(productID);

-- SHIPPING_INFO
ALTER TABLE SHIPPINGINFO ADD CONSTRAINT SI_INVOICE_FK FOREIGN KEY(invoiceID) REFERENCES INVOICE(invoiceID);

-- SALE_PRODUCTS
ALTER TABLE SALEPRODUCT ADD CONSTRAINT SALEPRD_PRD_FK FOREIGN KEY(productID) REFERENCES PRODUCT(productID);

-- REVIEW
ALTER TABLE REVIEW ADD CONSTRAINT REVIEW_PRD_FK FOREIGN KEY(productID) REFERENCES PRODUCT(productID);
ALTER TABLE REVIEW ADD CONSTRAINT REVIEW_USER_FK FOREIGN KEY(userID) REFERENCES `USER`(userID);

-- **************************************************************************************************************
-- INSERT INTO PRODUCT(specs) VALUES 
-- ("[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'}]");

-- insert data ROLE
INSERT INTO ROLE (roleName) VALUES ('ROLE_CUSTOMER');
INSERT INTO ROLE (roleName) VALUES ('ROLE_ADMIN');

-- insert data ROLE_USER
INSERT INTO USER (fullname, email, pswd, DOB, phone, address, roleID, gender)
VALUES('Đinh Ngọc UP', 'phuong@gmail.com', '1', '2000-01-01', '0904588091', '39/4/37 Huynh Van Banh', 1,'female');

INSERT INTO USER (fullname, email, pswd, DOB, phone, address, roleID, gender)
VALUES('Phùng KL', 'linh@gmail.com', '1', '2000-01-01', '0904588091', '39A Đoàn Thị Điểm', 1,'female');

--  insert data category

INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Smart Watch', 'smart-watch', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('PC Accessories', 'pc-accessories', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Audio System', 'audio-system', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('HeadPhone', 'headphone', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Mouse', 'mouse', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Gaming Desk/Chair', 'gaming-desk-chair', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Laptop', 'laptop', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Monitor', 'monitor', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Keyboard', 'keyboard', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('Smart Phone', 'smart-phone', false);
INSERT INTO CATEGORY (categoryName, categorySlug, categoryExact)
VALUES('All', '', true);
-- insert data BRAND
INSERT INTO BRAND (brandName, brandImg) VALUES ('Asus', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('Apple', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('HP', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('DELL', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('SAMSUNG', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('XIAOMI', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('HUAWEI', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('MSI', null);
INSERT INTO BRAND (brandName, brandImg) VALUES ('ACER', null);


--  insert data PRODUCT

-- SMART WATCH
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, totalReviews, images) 
VALUES(1, 2, 5, 'Apple watch series 3',  4000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 23, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]",9,"['images/watch1.jpeg','images/watch5.jpeg','images/watch2.jpeg','images/watch6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, totalReviews, images) 
VALUES(1, 1, 3.5, 'Apple watch series 4',  6000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]",10,"['images/watch2.jpeg','images/watch4.jpeg','images/watch1.jpeg','images/watch6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, totalReviews, images) 
VALUES(1, 3, 4.5, 'Daniel Wellington',  9000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]",4,"['images/watch5.jpeg','images/watch1.jpeg','images/watch2.jpeg','images/watch6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, totalReviews, images) 
VALUES(1, 2, 3.5, 'G-shock Pro Unisex',  8000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]",3,"['images/watch6.jpeg','images/watch5.jpeg','images/watch2.jpeg','images/watch6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, totalReviews, images) 
VALUES(1, 3, 2.5, 'Apple watch series 5',  2000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]",3,"['images/watch3.jpeg','images/watch1.jpeg','images/watch2.jpeg','images/watch6.jpeg']");

-- PC Accessories
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, totalReviews, images) 
VALUES(2, 2, 5, 'PlayStation 4',  1200000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]",2,"['images/console4.jpeg','images/console5.jpeg','images/console4.jpeg','images/console3.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(2, 1, 3.5, 'Nitendo Switch',  2000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/console5.jpeg','images/console2.jpeg','images/console3.jpeg','images/console4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(2, 3, 4.5, 'Xbox Pro', 800000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 25, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/console1.jpeg','images/console2.jpeg','images/console3.jpeg','images/console4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(2, 2, 3.5, 'PlayStation 3',  700000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/console2.jpeg','images/console4.jpeg','images/console4.jpeg','images/console5.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(2, 3, 2.5, 'PlayStation 5',  1300000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/console3.jpeg','images/console5.jpeg','images/console1.jpeg','images/console4.jpeg']");

-- Audio System
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(3, 1, 4.5, 'Audio System Razer',  5000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 4, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone7.jpeg','images/headphone1.jpeg','images/headphone4.jpeg','images/headphone6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(3, 2, 3, 'Audio System 2',  3000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone2.jpeg','images/headphone3.jpeg','images/headphone2.jpeg','images/headphone6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(3, 3, 2, 'Mpow Air',  600000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone1.jpeg','images/headphone4.jpeg','images/headphone5.jpeg','images/headphone2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(3, 8, 4, 'Audio System Kraken',  800000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone3.jpeg','images/headphone5.jpeg','images/headphone7.jpeg','images/headphone2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(3, 1, 4, 'Audio System 5',  1400000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 120, 50, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone4.jpeg','images/headphone6.jpeg','images/headphone8.jpeg','images/headphone1.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(3, 3, 2.7, 'Audio System Dareu',  3100000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone5.jpeg','images/headphone7.jpeg','images/headphone3.jpeg','images/headphone6.jpeg']");

-- HeadPhone
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(4, 1, 4.5, 'HeadPhone Logitech',  3100000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 4, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone1.jpeg','images/headphone2.jpeg','images/headphone3.jpeg','images/headphone6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(4, 2, 3, 'HeadPhone Apple',  3200000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone7.jpeg','images/headphone2.jpeg','images/headphone4.jpeg','images/headphone1.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(4, 3, 2, 'HeadPhone Jabra',  200000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone8.jpeg','images/headphone3.jpeg','images/headphone1.jpeg','images/headphone2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(4, 8, 4, 'HeadPhone HP',  1100000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 30, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone3.jpeg','images/headphone5.jpeg','images/headphone7.jpeg','images/headphone6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(4, 1, 4, 'HeadPhone Razer',  700000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 120, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone4.jpeg','images/headphone1.jpeg','images/headphone8.jpeg','images/headphone2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(4, 3, 2.7, 'HeadPhone Samsung 4',  400000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 40, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/headphone6.jpeg','images/headphone8.jpeg','images/headphone2.jpeg','images/headphone7.jpeg']");

-- MOUSE 
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(5, 2, 5, 'Logitech G8',  800000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mouse2.jpeg','images/mouse1.jpeg','images/mouse2.jpeg','images/mouse4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(5, 2, 5, 'Mouse Rapoo', 200000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mouse1.jpeg','images/mouse4.jpeg','images/mouse5.jpeg','images/mouse3.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(5, 2, 5, 'Mouse Fuhlen', 400000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mouse3.jpeg','images/mouse5.jpeg','images/mouse2.jpeg','images/mouse4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(5, 5, 5, 'Razer K3', 800000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mouse4.jpeg','images/mouse1.jpeg','images/mouse2.jpeg','images/mouse5.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(5, 5, 5, 'Razer Pro', 600000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mouse5.jpeg','images/mouse4.jpeg','images/mouse2.jpeg','images/mouse4.jpeg']");

-- Gaming Desk/Chair
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(6, 2, 5, 'Luxury Desk',  1400000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/desk5.jpeg','images/desk4.jpeg','images/desk2.jpeg','images/desk4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(6, 2, 5, 'Wood Desk', 780000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/desk4.jpeg','images/desk1.jpeg','images/desk2.jpeg','images/desk5.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(6, 2, 5, 'Gaming Desk Iron-3', 890000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/desk3.jpeg','images/desk2.jpeg','images/desk5.jpeg','images/desk4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(6, 5, 5, 'Desk Speed R1', 230000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/desk2.jpeg','images/desk4.jpeg','images/desk5.jpeg','images/desk1.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(6, 5, 5, 'Gaming Desk SOAYI', 340000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/desk1.jpeg','images/desk5.jpeg','images/desk2.jpeg','images/desk4.jpeg']");

-- LAPTOP
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(7, 1, 4.5, 'Macbook Pro 13 2018',  15000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 4, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mac1.jpeg','images/mac5.jpeg','images/mac2.jpeg','images/mac4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(7, 2, 3, 'Macbook Air 2020',  23000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mac6.jpeg','images/mac7.jpeg','images/mac8.jpeg','images/mac4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(7, 3, 2, 'Macbook Pro M1',  12000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mac2.jpeg','images/mac3.jpeg','images/mac7.jpeg','images/mac5.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(7, 8, 4, 'Macbook Pro 2019',  16000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mac8.jpeg','images/mac4.jpeg','images/mac7.jpeg','images/mac5.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(7, 1, 4, 'Macbook Pro 15inch',  19000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 120, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mac3.jpeg','images/mac8.jpeg','images/mac2.jpeg','images/mac4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(7, 3, 2.7, 'Macbook Air 2018',  23000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/mac7.jpeg','images/mac1.jpeg','images/mac6.jpeg','images/mac4.jpeg']");

-- Monitor
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(8, 1, 4.5, 'LCD LED 24inch',  3400000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 4, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/monitor1.jpeg','images/monitor2.jpeg','images/monitor3.jpeg','images/monitor4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(8, 2, 3, 'Dell 15inch',  4500000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
10, 10, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/monitor4.jpeg','images/monitor3.jpeg','images/monitor1.jpeg','images/monitor2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(8, 3, 2, 'HP Pavillon',  3400000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 2, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/monitor5.jpeg','images/monitor4.jpeg','images/monitor2.jpeg','images/monitor1.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(8, 8, 4, 'Apple X Pro',  6700000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 100, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/monitor2.jpeg','images/monitor5.jpeg','images/monitor3.jpeg','images/monitor6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(8, 1, 4, 'Dell LED',  1200000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 120, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/monitor3.jpeg','images/monitor6.jpeg','images/monitor2.jpeg','images/monitor1.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(8, 3, 2.7, 'Asus Pro 15in',  1100000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']", 
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/monitor6.jpeg','images/monitor1.jpeg','images/monitor2.jpeg','images/monitor3.jpeg']");

-- KEYBOARD
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(9, 2, 5, 'Keychrone K8',  230000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/keyboard6.jpeg','images/keyboard1.jpeg','images/keyboard2.jpeg','images/keyboard3.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(9, 1, 3.5, 'Keyboard Rapoo',  1200000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/keyboard3.jpeg','images/keyboard5.jpeg','images/keyboard6.jpeg','images/keyboard7.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(9, 3, 4.5, 'Keyboard Razer',  2300000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/keyboard4.jpeg','images/keyboard6.jpeg','images/keyboard1.jpeg','images/keyboard3.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(9, 2, 3.5, 'Keyboard Newmen',  500000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/keyboard5.jpeg','images/keyboard4.jpeg','images/keyboard2.jpeg','images/keyboard6.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(9, 3, 2.5, 'Keyboard Dareu',  700000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/keyboard2.jpeg','images/keyboard5.jpeg','images/keyboard3.jpeg','images/keyboard7.jpeg']");

-- SMART PHONE
INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(10, 2, 5, 'Iphone 12',  23000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/iphone1.jpeg','images/iphone2.jpeg','images/iphone3.jpeg','images/iphone4.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(10, 2, 5, 'Iphone 12 Pro', 20000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/iphone5.jpeg','images/iphone6.jpeg','images/iphone7.jpeg','images/iphone2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(10, 2, 5, 'Iphone 12 Pro Max', 3000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/iphone4.jpeg','images/iphone6.jpeg','images/iphone5.jpeg','images/iphone2.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(10, 5, 5, 'Samsung Note 8', 12000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/iphone7.jpeg','images/iphone6.jpeg','images/iphone4.jpeg','images/iphone5.jpeg']");

INSERT INTO PRODUCT (categoryID, brandID, productRate, productName, productPrice, shortTech, 
shortDescrip, longDescrip, warranty, stock, purchased, specs, images) 
VALUES(10, 5, 5, 'Samsung GALAXY 8', 12000000,"['Chip: S5 with 64-bit dual-core processor','Retina Display: LTPO OLED (1000 nits)','Capacity: 32GB','Battery Life: up to 18 hours','Water resistant: 50 meters','Color: Space Gray, Gold, Silver']",
'Lorem, ipsum dolor sit amet consectetur adipisicing elit. Natus incidunt distinctio saepe laudantium, nam unde quaerat perferendis harum, 
aspernatur atque blanditiis rerum possimus! Praesentium dolorum, accusamus repellat doloribus ex ipsam', 
"[{'header': 'The power to bring your creations to life','content': 'The powerful combination of an Intel® Core™ processor, ample memory and storage make your creative vision seamlessly come to life faster than ever before.'},{'header': 'Thoughtfully designed','content': 'Sometimes bigger is better. Watch your creations come to life in accurate, vibrant color on this massive high definition, micro-edge display.'},{'header': 'Privacy for your peace of mind','content': 'Keep it confidential with an unhackable camera shutter and dedicated microphone mute button.'}]",
2, 50, 10, 
"[{'tag': 'Color','content': 'Rose Gold'},{'tag': 'Brightness','content': '300 nits'},{'tag': 'Display resolution','content': '24'},{'tag': 'Signal input connectors','content': '1 HDMI 2.0 (with HDCP support); 1 DisplayPort™ 1.4 (with HDCP support)'},{'tag': 'Ports','content': '1 analog and digital audio-out; 3 USB 3.0 (1 upstream, 2 downstream)'},{'tag': 'Dimensions (W X D X H)','content': '25.98 x13.07 x 18.62 in Without stand'},{'tag': 'Weight','content': '15.8 lb'},{'tag': 'Display viewing angle','content': '160° vertical; 170° horizontal'},{'tag': 'Display type','content': 'LED backlight'}]","['images/iphone6.jpeg','images/iphone3.jpeg','images/iphone5.jpeg','images/iphone1.jpeg']");



-- inset data SALE_PRODUCT
INSERT INTO SALEPRODUCT (productID, startSale , endSale , productPrice) 
VALUES (1, '2021-01-01 00:00:00', '2021-10-01 00:00:00', 10000000);
INSERT INTO SALEPRODUCT (productID, startSale , endSale , productPrice) 
VALUES (2, '2021-01-01 00:00:00', '2021-10-02 00:00:00', 4000000);
INSERT INTO SALEPRODUCT (productID, startSale , endSale , productPrice) 
VALUES (3, '2021-01-01 00:00:00', '2021-05-01 00:00:00', 3000000);
INSERT INTO SALEPRODUCT (productID, startSale , endSale , productPrice) 
VALUES (4, '2021-01-01 00:00:00', '2021-06-01 00:00:00', 3000000);
INSERT INTO SALEPRODUCT (productID, startSale , endSale , productPrice) 
VALUES (5, '2021-01-01 00:00:00', '2021-12-01 00:00:00', 4000000);
INSERT INTO SALEPRODUCT (productID, startSale , endSale , productPrice) 
VALUES (6, '2021-01-01 00:00:00', '2021-10-03 00:00:00', 1000000);

-- inset data REVIEW
-- PRODUCT 1
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 1, '2021-03-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 2, '2021-03-04', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 2, '2021-03-05', 'Màu sắc sản phầm không giống quảng cáo', 3);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 1, '2021-03-06', 'Sản phẩm tốt', 4);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 1, '2021-03-07', 'Giao hàng quá chậm, sản phẩm có vẻ không chắc chắn như đã giới thiệu', 2);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 1, '2021-03-08', 'Sản phẩm đúng với quảng cáo, giao hàng nhanh, đóng gói đẹp', 5);

-- PRODUCT 2
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 1, '2021-03-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 1, '2021-03-04', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 2, '2021-03-05', 'Màu sắc sản phầm không giống quảng cáo', 3);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 1, '2021-03-06', 'Sản phẩm tốt', 4);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 2, '2021-03-07', 'Giao hàng quá chậm, sản phẩm có vẻ không chắc chắn như đã giới thiệu', 2);

-- PRODUCT 3
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (3, 1, '2021-03-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (3, 2, '2021-03-04', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (3, 1, '2021-03-05', 'Màu sắc sản phầm không giống quảng cáo', 3);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (3, 1, '2021-03-06', 'Sản phẩm tốt', 4);

-- PRODUCT 4
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (4, 1, '2021-03-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (4, 1, '2021-03-04', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (4, 1, '2021-03-05', 'Màu sắc sản phầm không giống quảng cáo', 3);

-- PRODUCT 5
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (5, 1, '2021-03-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (5, 1, '2021-03-04', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (5, 1, '2021-03-05', 'Màu sắc sản phầm không giống quảng cáo', 3);

-- PRODUCT 6
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (6, 1, '2021-03-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (6, 1, '2021-03-04', 'Sản phẩm rất đẹp', 5);

-- PRODUCT 1
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 2, '2021-03-10', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 2, '2021-03-11', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (1, 1, '2021-03-12', 'Màu sắc sản phầm không giống quảng cáo', 3);

-- PRODUCT 2
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 2, '2021-04-03', 'Sản phẩm được gói cẩn thận, chất lượng tốt, mẫu mã như quảng cáo', 4.5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 2, '2021-05-04', 'Sản phẩm rất đẹp', 5);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 1, '2021-01-05', 'Màu sắc sản phầm không giống quảng cáo', 3);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 2, '2021-02-06', 'Sản phẩm tốt', 4);
INSERT INTO REVIEW (productID, userID, reviewDate, reviewContent, rate)
VALUES (2, 1, '2021-01-07', 'Giao hàng quá chậm, sản phẩm có vẻ không chắc chắn như đã giới thiệu', 2);


-- use techshop;


-- update product set productRate = (select SUM(rate)/2 from review where productID = 6) where productID = 6;
-- select productID, productRate, totalReviews from product where productID = 6;

-- update detailedinvoice set isReviewed = false where invoiceID = 2;

-- delete from review where reviewID >= 44 and reviewID <=48;
-- update product set totalReviews = 9, productRate = 4 where productID =1;
-- update detailedInvoice set isReviewed = false where detailedInvoiceID = 3;
-- select * from review where productID = 1;
-- 1 4 9
-- select productID, productRate, totalReviews from product where productID = 1;







