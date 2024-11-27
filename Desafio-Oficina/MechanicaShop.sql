CREATE SCHEMA IF NOT EXISTS MechanicShop;
USE MechanicShop;

-- criar tabela Mechanic
CREATE TABLE IF NOT EXISTS Mechanic (
  idMechanic INT NOT NULL AUTO_INCREMENT,
  FName VARCHAR(45) NOT NULL,
  MName VARCHAR(3) NULL,
  LName VARCHAR(45) NOT NULL,
  PRIMARY KEY (idMechanic)
);

-- criar tabela Clients
CREATE TABLE IF NOT EXISTS Clients (
  idClient INT NOT NULL AUTO_INCREMENT,
  FName VARCHAR(45) NOT NULL,
  MName VARCHAR(3) NULL,
  LName VARCHAR(45) NOT NULL,
  Contact CHAR(9) NOT NULL,
  Document_CPF_CNPJ VARCHAR(14) NOT NULL UNIQUE,
  Address VARCHAR(45) NOT NULL,
  CEP CHAR(8) NOT NULL,
  City VARCHAR(45) NOT NULL,
  State CHAR(2) NOT NULL,
  PRIMARY KEY (idClient)
);

-- criar tabela Vehicle
CREATE TABLE IF NOT EXISTS Vehicle (
  idVehicle INT NOT NULL AUTO_INCREMENT,
  CarBrand VARCHAR(45) NOT NULL,
  NumberPlate VARCHAR(45) NOT NULL,
  KM INT NULL,
  ServiceOrder INT NOT NULL,
  Mechanic_idMechanic INT NOT NULL,
  Clients_idClient INT NOT NULL,
  PRIMARY KEY (idVehicle, Mechanic_idMechanic, Clients_idClient),
  CONSTRAINT fk_Vehicle_Client
    FOREIGN KEY (Clients_idClient)
    REFERENCES Clients (idClient)
);

-- criar tabela Budget
CREATE TABLE IF NOT EXISTS Budget (
  idBudget INT NOT NULL AUTO_INCREMENT,
  Amount FLOAT NULL,
  Status ENUM('aguardando início', 'oficina', 'aguardar autorização do cliente', 'em serviço', 'entregue') NOT NULL DEFAULT 'aguardando início',
  Clients_idClient INT NOT NULL,
  PRIMARY KEY (idBudget, Clients_idClient),
  CONSTRAINT fk_Budget_Client
    FOREIGN KEY (Clients_idClient)
    REFERENCES Clients (idClient)
);

-- criar tabela ServiceOrder
CREATE TABLE IF NOT EXISTS ServiceOrder (
  idServiceOrder INT NOT NULL AUTO_INCREMENT,
  ServiceOrderNumber INT NOT NULL,
  Responsible VARCHAR(45) NOT NULL,
  DateOfReceipt DATE NOT NULL,
  ScheduledDelivery DATE NULL,
  DeliveryDate DATE NULL,
  OrderDescription VARCHAR(255) NOT NULL,
  Budget_idBudget INT NOT NULL,
  Budget_Clients_idClient INT NOT NULL,
  mechanic_idMechanic INT NOT NULL,
  PRIMARY KEY (idServiceOrder, Budget_idBudget, Budget_Clients_idClient, mechanic_idMechanic),
  CONSTRAINT fk_ServiceOrder_Budget1
    FOREIGN KEY (Budget_idBudget , Budget_Clients_idClient)
    REFERENCES Budget (idBudget , Clients_idClient),
  CONSTRAINT fk_ServiceOrder_mechanic
    FOREIGN KEY (mechanic_idMechanic)
    REFERENCES mechanic (idMechanic)
);

-- criar tabela Supplier
CREATE TABLE IF NOT EXISTS Supplier (
  idSupplier INT NOT NULL AUTO_INCREMENT,
  SocialName VARCHAR(255) NOT NULL,
  Document_CPF_CNPJ VARCHAR(14) NOT NULL UNIQUE,
  Contact CHAR(9) NOT NULL,
  PRIMARY KEY (idSupplier)
);

-- criar tabela Payment
CREATE TABLE IF NOT EXISTS Payment (
  idClient INT AUTO_INCREMENT,
  idPayment INT NOT NULL,
  TypePayment ENUM('Boleto', 'Débito', 'Crédito', 'Dinheiro', 'PIX') NOT NULL DEFAULT 'Dinheiro',
  PaymentStatus ENUM('em analise', 'pagamento aprovado', 'pagamento rejeitado') DEFAULT 'em análise',
  limitAvailable FLOAT DEFAULT 0,
  serviceorder_idServiceOrder INT NOT NULL,
  serviceorder_Budget_idBudget INT NOT NULL,
  serviceorder_Budget_Clients_idClient INT NOT NULL,
  serviceorder_mechanic_idMechanic INT NOT NULL,
  PRIMARY KEY (idClient, idPayment, serviceorder_idServiceOrder, serviceorder_Budget_idBudget, serviceorder_Budget_Clients_idClient, serviceorder_mechanic_idMechanic),
  CONSTRAINT fk_payment_serviceorder
  FOREIGN KEY (serviceorder_idServiceOrder, serviceorder_Budget_idBudget, serviceorder_Budget_Clients_idClient, serviceorder_mechanic_idMechanic)
  REFERENCES Serviceorder (idServiceOrder, Budget_idBudget, Budget_Clients_idClient, mechanic_idMechanic)
);

-- criar tabela ProductStorage
CREATE TABLE IF NOT EXISTS ProductStorage (
  idProductStorage INT NOT NULL AUTO_INCREMENT,
  ProductName VARCHAR(45) NULL,
  Quantity INT NULL DEFAULT 0,
  Vehicle_idVehicle INT NOT NULL,
  Vehicle_Mechanic_idMechanic INT NOT NULL,
  Vehicle_Clients_idClient INT NOT NULL,
  PRIMARY KEY (idProductStorage, Vehicle_idVehicle, Vehicle_Mechanic_idMechanic, Vehicle_Clients_idClient),
  CONSTRAINT fk_ProductStorage_Veículo
    FOREIGN KEY (Vehicle_idVehicle , Vehicle_Mechanic_idMechanic , Vehicle_Clients_idClient)
    REFERENCES Vehicle (idVehicle , Mechanic_idMechanic , Clients_idClient)
);

-- criar tabela ProductStorage_Supplier
CREATE TABLE IF NOT EXISTS ProductStorage_Supplier (
  ProductStorage_idProductStorage INT NOT NULL,
  Supplier_idSupplier INT NOT NULL,
  PRIMARY KEY (ProductStorage_idProductStorage, Supplier_idSupplier),
  CONSTRAINT fk_ProductStorage_Supplier_ProductStorage
    FOREIGN KEY (ProductStorage_idProductStorage)
    REFERENCES ProductStorage (idProductStorage),
  CONSTRAINT fk_ProductStorage_Supplier_Supplier
    FOREIGN KEY (Supplier_idSupplier)
    REFERENCES Supplier (idSupplier)
);
