-- crição do banco de daods para cenário de e-comerce

create database ecommerce;
use ecommerce;

create table clients(
			idClient int auto_increment primary key,
            fname varchar (20),
            Mint varchar (3),
            lname varchar (20),
            cpf char(11) not null,
            address varchar(30),
            constraint unique_cpf_client unique (cpf)
 );

 create table product(
			idProduct int auto_increment primary key,
            Pname varchar (20),
            Classification_kids bool default false,
            category enum ('eletronico', 'vestimento','brinquedos','alimentos', 'moveis'), 
            avaliação float default 0,
            size varchar(10)
 );
 
 
 create table payment(
	idclient int,
    id_payment int,
    typepayment enum ('pix','cartão de crédito','cartão de débito'),
    limitAvailable float,
    paymentcash bool default false, 
    primary key (idClient, id_payment)
 );

create table orders(
		idOrder int auto_increment primary key,
        idOrdersClient int,
        ordersStatus enum ('cancelado','confirmado','em andamento'),
        ordersdescription varchar(255),
        sendvalue float default 10,
		paymentcash bool default false, 
        idpayment int null,  
        constraint fk_orders_client foreign key (idOrdersClient) references clients(idClient)
	);
    
create table productStorege(
	idProductStorege int auto_increment primary key,
     storegelocation varchar(255),
     quantity int default 0
);

create table supplier(
	idSupplier int auto_increment primary key,
     Social_name varchar(255) not null,
     CNPJ char(15) not null,
     contact char(11) not null,
     constraint unique_supplier unique(CNPJ)
);

create table seller(
	idSeller int auto_increment primary key,
     Social_name varchar(255) not null,
     CNPJ char(15) not null,
     CPf char(11),
     location varchar (255),
     contact char(11) not null,
     constraint unique_cnpj_seller unique(CNPJ),
     constraint unique_cpf_seller unique(CNPJ)
);

create table productseller(
	idPseller int,
	idProduct int,
    quantity int default 1,
    primary key (idPseller,idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
	constraint fk_product_product foreign key (idProduct) references product (idProduct)
);

create table producOrder(
	idPOorder int,
	idPOproduct int,
    POquantity int default 1,
    POstatus enum ('Disponível',' Sem Estoque') default 'Disponível',
    primary key (idPOorder,idPOproduct),
    constraint fk_productorder_seller foreign key (idPOproduct) references product (idProduct),
	constraint fk_productorder_product foreign key (idPOorder) references orders (idOrder)
);

create table StorageLocation(
	idLstorage int,
	idLproduct int,
    location varchar(255),
    primary key (idLstorage,idLproduct),
    constraint fk_productstorage_seller foreign key (idLproduct) references product (idProduct),
	constraint fk_productstorage_product foreign key (idLstorage ) references productStorege (idProductStorege)
);

create table ProductSupplier(
	idPsupplier int,
	idPsproduct int,
  quantity int not null,
    primary key (idPsupplier,idPsproduct),
    constraint fk_product_supplier_supplier foreign key (idPsupplier) references supplier (idSupplier),
	constraint fk_product_supplier_product foreign key (idPsproduct) references product (idProduct)
);




