create database hotelJoin;
use hotelJoin;
create table cliente(
cod integer auto_increment not null primary key,
nome varchar(80) not null,
cpf int not null,
tipo_convenio varchar(40)
)engine=InnoDB;
create table servico_copa(
cod integer auto_increment not null primary key,
registro varchar(100),
tipo_servico varchar(40)
)engine=InnoDB;
create table reserva(
cod integer auto_increment not null primary key,
dataInicio date not null,
dataFim date not null,
quarto int not null,
valor double(9,2) not null,
Cliente_cod integer not null,
foreign key(Cliente_cod) references cliente(cod)
)engine=InnoDB;
create table hospede(
cod integer auto_increment not null primary key,
nome varchar(80) not null,
reserva_cod integer not null,
telefone char(15) not null,
email varchar(60) not null,
foreign key(reserva_cod) references reserva(cod)
)engine=InnoDB;
create table quarto(
cod integer auto_increment not null primary key,
numero int not null,
andar int not null,
classificacao varchar(40) not null,
hospede_cod integer not null,
foreign key(hospede_cod) references hospede(cod)
)engine=InnoDB;
create table servicos(
cod integer auto_increment not null primary key,
itens varchar(50) not null,
tipo varchar(50) not null,
observacao varchar(100) not null,
quarto_cod integer not null,
servicocopa_cod integer not null,
foreign key(quarto_cod) references quarto(cod),
foreign key(servicocopa_cod) references servico_copa(cod)
)engine=InnoDB;
-- 2) Quantos clientes fizeram reserva para o quarto 2
SELECT count(hospede.cod)
FROM hospede JOIN quarto
ON hospede.COD =quarto.COD
where numero =2;
-- 3) Qual o nome do cliente que fez reserva para o quarto 3 na data de inicio igual a 08/08/2020
SELECT cliente.nome
FROM cliente JOIN reserva
ON cliente.cod =reserva.Cliente_cod
where  reserva.quarto =3 and reserva.dataInicio = 2020/08/08;
-- 4) Selecionar valor e quarto da reserva e nomenome e telefone do hospede
SELECT reserva.valor,reserva.quarto,hospede.nome,hospede.telefone
from reserva join hospede
on reserva.cod = hospede.reserva_cod;
-- 5) Quantas reservas foram realizadas para o hospede de código 3
select count(reserva.cod)
from reserva join hospede
on reserva.cod = hospede.reserva_cod
where hospede.cod = 3;
-- 6) Qual a soma de valores da reservas dos clientes com código entre 1 e 3
select sum(reserva.valor) 
from reserva join hospede
on reserva.cod = hospede.reserva_cod
where hospede.cod between 1 and 3;
-- 7)  Qual a média de valor das reservas para hospedes com código maior que 4
select avg(reserva.valor) 
from reserva join hospede
on reserva.cod = hospede.reserva_cod
where hospede.cod > 4;
-- 8) Selecionar numero do quarto, andar e nome e telefone do hospede
SELECT quarto.numero,quarto.andar,hospede.nome,hospede.telefone
from quarto join hospede
on hospede.cod = quarto.hospede_cod;
-- 9)  Qual o nome do hospede que está no quarto de número 2
select hospede.nome 
from quarto join hospede
on hospede.cod = quarto.hospede_cod
where quarto.numero= 2;
-- 10) Quantos hospedes estão hospedados nos quartos de andar igual a 3
select Count(hospede.cod) 
from quarto join hospede
on hospede.cod = quarto.hospede_cod
where quarto.andar= 3;
-- 11) Qual a classificação do quarto onde se hospedou o hospede de nome ‘Carlos’
select quarto.classificacao
from quarto join hospede
on hospede.cod = quarto.hospede_cod
where hospede.nome="carlos";
-- 12) Quantos serviços foram realizados para o quarto de código 3
select count(servicos.cod)
from servicos join quarto
on quarto.cod = servicos.quarto_cod
where quarto.cod = 3;
-- 13) Quantos serviços foram pedidos pelo hospede de código 3 para o quarto de número 2
select count(servicos.cod)
from servicos join quarto
on quarto.cod = servicos.quarto_cod
where quarto.cod = 2 and quarto.hospede_cod = 3;
-- 14) Listar tipo de serviço do serviço_copa e itens de serviços para o quarto de código maior que 8
select servicos.itens,servicos.tipo 
from servicos join quarto
on quarto.cod = servicos.quarto_cod
where quarto.cod > 8;
-- 15) Selecionar numero do quarto e itens de serviços pedidos do tipo ‘limpeza’
select servicos.itens,quarto.numero 
from servicos join quarto
on quarto.cod = servicos.quarto_cod
where servicos.tipo ="limpeza";