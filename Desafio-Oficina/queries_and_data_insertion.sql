-- inserção de dados e queries
USE MechanicShop;

SHOW TABLES;

-- FName, MName, LName
INSERT INTO Mechanic (FName, MName, LName) VALUES
						('Antonio','B','Santos'),
                        ('José','D','Barros'),
                        ('Josué','M','Campos'),
                        ('José Augusto','S','Junior'),
                        ('Sebastião',NULL,'Carvalho');
SELECT * FROM Mechanic;

-- FName, MName, LName, Contact, Document_CPF_CNPJ, Address, CEP, City, State
INSERT INTO Clients (idClient,FName, MName, LName, Contact, Document_CPF_CNPJ, Address, CEP, City, State) VALUES
						(1,'Pedro Augusto','S','Junior', '123456789', 12345678900, 'Rua dos Bobos, 0', 11000000,'São Paulo','SP'),
                        (2,'Suzuka',NULL,'Nakamoto','234567890',12345678901,'Rua Fox, 01',10000000,'Hiroshima','HI'),
                        (3,'Alex','T','Shikolai','345678901',12345678902,'Rua Terrible, 10',15000000,'Moscou','RO'),
                        (4,'Massimiliano Antônio','M','Cavalera','456789012',12345678903,'Rua Belo Horizonte, 96',30000000,'Belo Horizonte','BH'),
                        (5,'Klein','F','Moretti','567890123',12345678904,'Rua Zouteland, 36',00000000,'Tingen','TI');
SELECT * FROM Clients;

-- CarBrand, NumberPlate, KM, ServiceOrder, Mechanic_idMechanic, Clients_idClient
INSERT INTO Vehicle (CarBrand, NumberPlate, KM, ServiceOrder, Mechanic_idMechanic, Clients_idClient) VALUES
						('Toyota','AVG4789', 120000, 1, 1, 1),
                        ('Ferrari','FOX2012', 80000,2,2,2),
                        ('Toyota Supra','STP4084', 150000,3,3,3),
                        ('500','SSC0196',30000,4,1,4),
                        ('BYD','LOTM2028',15000,5,5,5);
SELECT * FROM Vehicle;

-- Amount, Status, Clients_idClient
INSERT INTO Budget(Amount, Status, Clients_idClient) VALUES
					(1500, 'aguardando início', 1),
                    (50000,'em serviço',2),
                    (20000,'oficina',3),
                    (35000,DEFAULT,4),
                    (15000,'entregue',5);
SELECT * FROM Budget;

-- ServiceOrderNumber, Responsible, DateOfReceipt, ScheduledDelivery, DeliveryDate, OrderDescription, Budget_idBudget, Budget_Clients_idClient, mechanic_idMechanic
INSERT INTO ServiceOrder (ServiceOrderNumber, Responsible, DateOfReceipt, ScheduledDelivery, DeliveryDate, OrderDescription, Budget_idBudget, Budget_Clients_idClient, mechanic_idMechanic) VALUES
							(1, 1,'2024-11-24', NULL, NULL, 'Lorem ipsum dolor sit amet.', 1, 1, 1),
                            (2,2,'2024-10-14','2024-11-26',NULL,'Lorem ipsum dolor sit amet.',2,2,2),
                            (3,3,'2024-09-15','2024-11-28',NULL,'Lorem ipsum dolor sit amet.',3,3,3),
                            (4,4,'2024-01-20',NULL,NULL,'Lorem ipsum dolor sit amet.',4,4,1),
                            (5,5,'2024-08-03',NULL,'2024-11-22','Lorem ipsum dolor sit amet.',5,5,5);
SELECT * FROM ServiceOrder;

-- SocialName, Document_CPF_CNPJ, Contact
INSERT INTO Supplier (SocialName, Document_CPF_CNPJ, Contact) VALUES
						('Tech eletronics',12345678945632, 219946287),
                        ('Tesla Company',12345678318479, 219567895),
                        ('Oficina Tio João',12345678315, 219567894);
SELECT * FROM Supplier;

-- idPayment, TypePayment, PaymentStatus, limitAvailable, serviceorder_idServiceOrder, serviceorder_Budget_idBudget, serviceorder_Budget_Clients_idClient, serviceorder_mechanic_idMechanic
INSERT INTO Payment (idPayment, TypePayment, PaymentStatus, limitAvailable, serviceorder_idServiceOrder,
						serviceorder_Budget_idBudget, serviceorder_Budget_Clients_idClient, serviceorder_mechanic_idMechanic) VALUES
						(1,DEFAULT,'pagamento aprovado',30000,1,1,1,1),
                        (2,'Boleto',DEFAULT,2000000,2,2,2,2),
                        (3,'Crédito','pagamento rejeitado',150000,3,3,3,3),
                        (4,'PIX', DEFAULT,125000,4,4,4,1),
                        (5,'Débito', 'pagamento rejeitado',300000,5,5,5,5);
SELECT * FROM Payment;

-- ProductName, Quantity, Vehicle_idVehicle, Vehicle_Mechanic_idMechanic, Vehicle_Clients_idClient
INSERT INTO ProductStorage (ProductName, Quantity, Vehicle_idVehicle, Vehicle_Mechanic_idMechanic, Vehicle_Clients_idClient) VALUES
								('Hot Weel', 4, 1, 1,1),
                                ('WindShield',2,2,2,2),
                                ('Rebimboca da parafuseta',27,3,3,3),
                                ('The Doors', 3,4,1,4),
                                ('Antena pro Palio', 1,5,5,5);
SELECT * FROM ProductStorage;
SELECT * FROM Supplier;
-- ProductStorage_idProductStorage, Supplier_idSupplier
INSERT INTO ProductStorage_Supplier (ProductStorage_idProductStorage, Supplier_idSupplier) VALUES
											(1,1),
                                            (2,2),
                                            (3,3),
                                            (4,2),
                                            (5,1);
SELECT * FROM ProductStorage_Supplier;

SELECT c.Document_CPF_CNPJ, s.Document_CPF_CNPJ FROM Clients AS c, Supplier AS s;
SELECT Document_CPF_CNPJ,
	CASE WHEN LENGTH(Document_CPF_CNPJ) <= 11 THEN 'Física'
    ELSE 'Jurídica'
    END AS TIPO
	FROM Supplier;

SELECT c.Document_CPF_CNPJ
	FROM Clients AS c
    LEFT JOIN Supplier AS s
    ON c.Document_CPF_CNPJ=s.Document_CPF_CNPJ;

SELECT CONCAT(Fname, ' ', Mname, ' ', Lname) AS Nome_Completo, CONCAT(Address, ' - ', CEP, ' - ', City, ' - ', State) AS Endereço FROM Clients;
SELECT c.Fname, b.Amount, p.TypePayment FROM Clients AS c, Budget as B, Payment as p;

SELECT COUNT(*) FROM Clients;

SELECT * FROM Payment;
SELECT Amount AS ValorOrçamento
	FROM Budget
    WHERE Amount>20000;

SELECT c.Fname AS Nome, b.Amount AS Valor, p.PaymentStatus AS StatusPagamento
	FROM Clients c, Budget b
    INNER JOIN Payment AS p ON p.serviceorder_Budget_idBudget=b.idBudget
    HAVING p.PaymentStatus='pagamento rejeitado';
