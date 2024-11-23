-- criação do bando de dados para o cenário de E-commerce
-- DROP SCHEMA ecommerces;
CREATE SCHEMA IF NOT EXISTS ecommerces;
USE ecommerces;

-- CRIAR TABELA CLIENTE
CREATE TABLE IF NOT EXISTS Clients (
  idClient INT NOT NULL AUTO_INCREMENT,
  Fname VARCHAR(10) NOT NULL,
  Minit VARCHAR(3),
  Lname VARCHAR(20),
  CPF CHAR(11) NOT NULL,
  CONSTRAINT unique_cpf_client UNIQUE(CPF),
  Address VARCHAR(255),
  Bdate DATE NOT NULL,
  PRIMARY KEY (idClient)
);
DESC Clients;

ALTER TABLE Clients AUTO_INCREMENT=1;

-- criar tabela Produto
-- SIZE equivale a dimensão do produto
CREATE TABLE IF NOT EXISTS Product(
  idProduct INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Pname VARCHAR(30) NOT NULL,
  Category ENUM('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
  Descriptions VARCHAR(255),
  Avalição FLOAT DEFAULT 0,
  Size VARCHAR(10),
  Valor FLOAT NOT NULL
);
ALTER TABLE Product RENAME COLUMN Avalição TO Avaliação;

CREATE TABLE IF NOT EXISTS Orders (
  idOrder INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  idOrderClient INT NOT NULL,
  OrderStatus ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL DEFAULT 'Processando',
  OrderDescription VARCHAR(255),
  Freight FLOAT DEFAULT 10,
  CONSTRAINT fk_Orders_Client
    FOREIGN KEY (idOrderClient)
    REFERENCES Clients(idClient)
);
DESC Orders;

-- criar tabela Pagamento
CREATE TABLE IF NOT EXISTS Payment (
  idClient INT AUTO_INCREMENT,
  idPayment INT NOT NULL,
  TypePayment ENUM('Boleto', 'Débito', 'Crédito', 'Dinheiro', 'PIX'),
  PaymentStatus ENUM('em analise', 'pagamento aprovado', 'pagamento rejeitado') DEFAULT 'em análise',
  limitAvailable FLOAT,
  PRIMARY KEY (idClient, idPayment)
);

-- criar tabela Estoque
CREATE TABLE IF NOT EXISTS ProductStorage (
  idProductStorage INT NOT NULL,
  StorageLocation VARCHAR(45),
  Quantity INT DEFAULT 0,
  PRIMARY KEY (idProductStorage)
);

-- criar tabela Fornecedor
CREATE TABLE IF NOT EXISTS Supplier (
  idSupplier INT AUTO_INCREMENT NOT NULL,
  SocialName VARCHAR(255) NOT NULL,
  CNPJ CHAR(15) NOT NULL,
  Contact VARCHAR(11) NOT NULL,
  PRIMARY KEY (idSupplier),
  CONSTRAINT SocialName_UNIQUE UNIQUE (SocialName),
  CONSTRAINT CNPJ_UNIQUE UNIQUE (CNPJ)
);
DESC Supplier;

-- criar tabela Vendedor
CREATE TABLE IF NOT EXISTS Seller (
  idSeller INT AUTO_INCREMENT,
  SocialName VARCHAR(255) NOT NULL,
  Address VARCHAR(45),
  AbstName VARCHAR(255) NOT NULL,
  CNPJ CHAR(15),
  CPF CHAR(9),
  CONTACT CHAR(11) NOT NULL,
  CONSTRAINT UNIQUE_CNPJ_SELLER UNIQUE (CNPJ),
  CONSTRAINT UNIQUE_CPF_SELLER UNIQUE (CPF),
  PRIMARY KEY (idSeller)
  );
DESC Seller;

-- criar tabela Entrega
CREATE TABLE IF NOT EXISTS Delivery (
  idDelivery INT NOT NULL,
  Statu ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL DEFAULT 'em andamento',
  TrackingCode VARCHAR(45) NOT NULL,
  PRIMARY KEY (idDelivery)
  );

-- criar tabela Produto/Vendedor
CREATE TABLE IF NOT EXISTS productSeller (
  idPSeller INT AUTO_INCREMENT,
  idPproduct INT NOT NULL,
  prodQuantity INT DEFAULT 1,
  PRIMARY KEY (idPSeller, idPproduct),
  CONSTRAINT fk_product_seller
    FOREIGN KEY (idPSeller)
    REFERENCES Seller (idSeller),
  CONSTRAINT fk_product_product
    FOREIGN KEY (idPproduct)
    REFERENCES Product (idProduct)
);
DESC productSeller;

-- criar tabela Produto/Pedido
CREATE TABLE IF NOT EXISTS productOrder(
  idPOproduct INT AUTO_INCREMENT,
  idPOorder INT,
  poQuantity INT DEFAULT 1,
  poStatus ENUM('disponível', 'sem estoque') DEFAULT 'disponível',
  PRIMARY KEY (idPOproduct, idPOorder),
  CONSTRAINT fk_productorder_seller
    FOREIGN KEY (idPOproduct)
    REFERENCES Product (idProduct),
  CONSTRAINT fk_productorder_product
    FOREIGN KEY (idPOorder)
    REFERENCES Orders (idOrder)
);
DESC productOrder;

-- criar tabela Produto_em_Estoque
CREATE TABLE IF NOT EXISTS storageLocation (
  idLproduct INT,
  idLStorage INT,
  Location VARCHAR(255) NOT NULL,
  PRIMARY KEY (idLproduct, idLStorage),
  CONSTRAINT fk_productstorage_seller
    FOREIGN KEY (idLproduct)
    REFERENCES Product (idProduct),
  CONSTRAINT fk_productstorage_product
    FOREIGN KEY (idLStorage)
    REFERENCES ProductStorage (idProductStorage)
);
DESC storageLocation;

-- criar tabela Disponibilizando um produto
CREATE TABLE IF NOT EXISTS ProvidingProduct (
  idPrvSupplier INT,
  idPrvProduct INT,
  PRIMARY KEY (idPrvSupplier, idPrvProduct),
  CONSTRAINT fk_providing_supplier
    FOREIGN KEY (idPrvSupplier)
    REFERENCES Supplier (idSupplier),
  CONSTRAINT fk_providing_product
    FOREIGN KEY (idPrvProduct)
    REFERENCES Product (idProduct)
);

SHOW TABLES;

SHOW DATABASES;
USE information_schema;
SHOW TABLES;
DESC REFERENTIAL_CONSTRAINTS;
SELECT * FROM REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_SCHEMA = 'ecommerces';

