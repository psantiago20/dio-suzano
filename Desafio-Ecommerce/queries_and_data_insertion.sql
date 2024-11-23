-- inserção de dados e queries
USE ecommerces;

SHOW TABLES;
-- idClient, Fname, Minit, Lname, CPF, Address, Bdate
INSERT INTO Clients (Fname, Minit, Lname, CPF, Address, Bdate) 
	   VALUES('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores', '1999-07-05'),
		     ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro - Cidade das flores', '1984-08-20'),
			 ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro - Cidade das flores', '2004-05-01'),
			 ('Julia','S','França', 789123456,'rua lareijras 861, Centro - Cidade das flores', '2006-10-30'),
			 ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro - Cidade das flores', '1967-11-22'),
			 ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro - Cidade das flores', '1988-03-08');

SELECT * FROM Clients;

-- idProduct, Pname, classification_kids boolean, category('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
INSERT INTO Product (Pname, Category, Descriptions, Avaliação, Size, Valor) VALUES
							  ('Fone de ouvido','Eletrônico','Lorem ipsum dolor sit amet.','4',null,45.40),
                              ('Barbie Elsa','Brinquedos','Lorem ipsum dolor sit amet.','3',null,57.58),
                              ('Body Carters','Vestimenta','Lorem ipsum dolor sit amet.','5',null,31.33),
                              ('Microfone Vedo - Youtuber','Eletrônico','Lorem ipsum dolor sit amet.','4',null,12.45),
                              ('Sofá retrátil','Móveis','Lorem ipsum dolor sit amet.','3','3x57x80',108.00),
                              ('Farinha de arroz','Alimentos','Lorem ipsum dolor sit amet.','2',null,5.45),
                              ('Fire Stick Amazon','Eletrônico','Lorem ipsum dolor sit amet.','3',null,13.99);
SELECT * FROM Product;

-- idOrder, idOrderClient, OrderStatus, OrderDescription, sendValue, paymentCash
INSERT INTO Orders (idOrderClient, OrderStatus, OrderDescription, Freight) VALUES 
							 (1, DEFAULT,'compra via aplicativo',50),
                             (2,DEFAULT,'compra via aplicativo',50),
                             (3,'Enviado',NULL,100),
                             (4,DEFAULT,'compra via web site',150);
SELECT * FROM Orders;

-- idPayment, TypePayment, PaymentStatus, limitAvailable
INSERT INTO Payment (idPayment, TypePayment, PaymentStatus, limitAvailable) VALUES
					(1,'Boleto',DEFAULT,100),
                    (2,'Débito','pagamento aprovado',150),
                    (3,'Crédito','pagamento rejeitado',0),
                    (4,'Dinheiro','pagamento aprovado',150);
SELECT * FROM Payment;

-- idProductStorage,StorageLocation,Quantity
INSERT INTO productStorage (idProductStorage,storageLocation,quantity) VALUES 
							(1,'Rio de Janeiro',1000),
                            (2,'Rio de Janeiro',500),
                            (3,'São Paulo',10),
                            (4,'São Paulo',100),
                            (5,'São Paulo',10),
                            (6,'Brasília',60);
SELECT * FROM productStorage;

-- idSupplier, SocialName, CNPJ, contact
INSERT INTO Supplier (SocialName, CNPJ, contact) VALUES 
							('Almeida e filhos', 123456789123456,'21985474'),
                            ('Eletrônicos Silva',854519649143457,'21985484'),
                            ('Eletrônicos Valma', 934567893934695,'21975474');
SELECT * FROM Supplier;

-- idSeller, SocialName, Address, AbstName, CNPJ, CPF, CONTACT
INSERT INTO Seller (SocialName, Address, AbstName, CNPJ, CPF, CONTACT) VALUES 
						('Tech eletronics', 'Rio de Janeiro','Tech eletronics', 123456789456321, null,  219946287),
					    ('Botique Durgas','Rio de Janeiro','Botique Durgas',null,123456783, 219567895),
						('Kids World','São Paulo','Kids World',456789123654485,null, 1198657484);
SELECT * FROM Seller;

-- idDelivery, Statu, TrackingCode
INSERT INTO Delivery(idDelivery, Statu, TrackingCode) VALUES
						(1, 'Processando', 458),
                        (2, 'Enviado', 789),
                        (3, 'Entregue', 387),
                        (4, 'Processando', 198),
                        (5, 'Entregue', 455);
SELECT * FROM Delivery;

-- idPSeller, idPproduct, prodQuantity
INSERT INTO productSeller (idPproduct, prodQuantity) VALUES
								(2,5),
                                (3,1),
                                (1,8);
SELECT * FROM productSeller;

-- idPOproduct, idPOorder, poQuantity, poStatus
INSERT INTO productOrder (idPOorder, poQuantity, poStatus) VALUES
						 (1,2,NULL),
                         (2,1,NULL),
                         (3,1,NULL);
SELECT * FROM productOrder;

-- idLproduct, idLstorage, location
INSERT INTO storageLocation (idLproduct, idLstorage, location) VALUES
								 (1,2,'RJ'),
								 (2,6,'GO');
SELECT * FROM storageLocation;

-- idPrvSupplier, idPrvProduct
INSERT INTO ProvidingProduct (idPrvSupplier, idPrvProduct) VALUES
								(1,2),
                                (2,5),
                                (3,4);

SELECT COUNT(*) FROM Clients;
SELECT * FROM Clients c, Orders o WHERE c.idClient = idOrderClient;

SELECT Fname,Lname, idOrder, orderStatus FROM Clients c, Orders o WHERE c.idClient = idOrderClient;
SELECT CONCAT(Fname,' ',Lname) AS Client, idOrder AS Request, orderStatus AS StatuS FROM Clients c, Orders o WHERE c.idClient = idOrderClient;

INSERT INTO Orders (idOrderClient, OrderStatus, OrderDescription, Freight) VALUES 
							 (2, DEFAULT,'compra via aplicativo',1);
                             
SELECT COUNT(*) FROM Clients c, Orders o 
			WHERE c.idClient = idOrderClient;

SELECT * FROM Clients LEFT OUTER JOIN Orders ON idClient = idOrderClient;

SELECT * FROM productOrder;

-- recuperação de pedidos com produto associado
SELECT * FROM Clients c 
				INNER JOIN Orders o ON c.idClient = o.idOrderClient
                INNER JOIN productOrder p ON p.idPOorder = o.idOrder; 

-- Recuperar quantos pedidos foram realizados pelos clientes?
SELECT c.idClient, Fname, count(*) AS Number_of_orders FROM clients c 
				INNER JOIN Orders o ON c.idClient = o.idOrderClient
		GROUP BY idClient;

-- Preço máximo, mínimo e soma dos fretes
SELECT * FROM Orders;
SELECT MAX(Freight) AS Max_Freight, MIN(Freight) AS Min_Freight, SUM(Freight) AS Sum_Freight FROM Orders;

-- Avaliação com notas iguais ou maior do que 4
SELECT * FROM Product;
SELECT Pname, Avaliação FROM Product WHERE Avaliação>=4;

SELECT p.Pname, p.Avaliação, s.SocialName
	FROM Product AS p, Seller AS s
	WHERE Avaliação>=4;

-- Quantidade de produtos com valor acima de 30 e avaliação igual ou acima de 3
SELECT Valor, COUNT(*) AS CountValue
	FROM Product
    WHERE Valor>30
		AND Avaliação IN (SELECT Avaliação FROM Product
					GROUP BY Avaliação
                    HAVING COUNT(*)>=3)
	GROUP BY Valor;

SELECT Pname, Category FROM Product AS p
	WHERE EXISTS(SELECT * FROM Seller
					WHERE idPRoduct=idSeller);

-- Localizar nome do fornecedor por CNPJ
SELECT * FROM Supplier;
SELECT DISTINCT SocialName, CNPJ FROM Supplier WHERE CNPJ IN (123456789123456);

-- Quantidade de pagamentos com status de rejeitado e forma de pagamento = boleto
SELECT * FROM Payment;
SELECT COUNT(*) FROM Clients, Payment
	WHERE PaymentStatus='pagamento rejeitado' AND TypePayment='Boleto';

-- Quantos pedidos foram feitos por cada cliente?
SELECT c.Fname, p.Pname, q.poQuantity FROM Clients as c, Product as p, productorder as q;

-- Algum vendedor também é fornecedor?
SELECT * FROM Seller;
SELECT * FROM Supplier;
SELECT s.SocialName, p.SocialName FROM Seller as s, Supplier as p
	where s.socialname=p.socialname;

