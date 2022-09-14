create database Despanser
go

use Despanser
go

create type Adres from varchar(70)
go

create type FIO from varchar(50)
go

create type Telefon from char(12)
go

create table Med_inst(cod_MI smallint primary key,
					  name_MI varchar(20),
					  legal_adres Adres,
					  Tel_numb Telefon,
					  Stamp varchar(20))
go

create table Family_doctor(Cod_fam_doctor int primary key,
						   fio_doct FIO,
						   Tel_munb Telefon,
						   area varchar(70),
						   Stamp varchar(20))
go

create table Tratement(cod_trate int primary key,
					   trat_name varchar(25),
					   trat_method varchar(50),
					   duration smallint)
go

create table Medicaments(cod_med int primary key,
					     med_name varchar(20),
						 purpose varchar(30),
						 dosage smallint,
						 instruction varchar(100))
go

create table Tratement_Medicamenst(cod_trate int foreign key references Tratement(cod_trate) not null,
								   cod_med int foreign key references Medicaments(cod_med) not null)
go

create table Speciallist(cod_spec int primary key,
						 fio_spec FIO,
						 post varchar(20),
						 Stamp varchar(20),
						 cod_MI smallint foreign key references Med_inst(cod_MI) not null)
go

create table Patient(cod_pac int primary key,
					 fio_pac FIO,
					 age smallint check (age>0 and age <150),
					 gender char check(gender = 'M' or gender = 'F'),
					 Birth_date date,
					 pac_adres Adres,
					 Cod_fam_doctor int foreign key references Family_doctor(Cod_fam_doctor) not null,
					 pac_tel Telefon,
					 Number_insurance_police int,
					 Work varchar(20),
					 IDNP varchar(13))
go

create table Diagnoza(cod_diagnoz int primary key,
					  name_diagnoz varchar(30),
					  cod_trate int foreign key references Tratement(cod_trate) not null)
go

create table Referral(cod_ref int primary key,
					  cod_pac int foreign key references Patient(cod_pac) not null,
					  cod_diagnoz int foreign key references Diagnoza(cod_diagnoz) not null,
					  Cod_fam_doctor int foreign key references Family_doctor(Cod_fam_doctor) not null,
					  cod_spec int foreign key references Speciallist(cod_spec) not null,
					  vizit_date datetime,
					  cod_MI smallint foreign key references Med_inst(cod_MI) not null)
go

create table Note(note_numb int primary key,
				  cod_spec int foreign key references Speciallist(cod_spec) not null,
				  cod_pac int foreign key references Patient(cod_pac) not null,
				  cod_diagnoz int foreign key references Diagnoza(cod_diagnoz) not null,
				  cod_MI smallint foreign key references Med_inst(cod_MI) not null)
go

create table Recept(recept_numb int primary key,
					cod_pac int foreign key references Patient(cod_pac) not null,
					cod_med int foreign key references Medicaments(cod_med) not null,
					Dosage smallint,
					trat_duration smallint default 30,
					prescription_date date,
					cod_MI smallint foreign key references Med_inst(cod_MI) not null,
					cod_spec int foreign key references Speciallist(cod_spec) not null)
go










insert into Med_inst(cod_MI, name_MI, legal_adres, Tel_numb, Stamp)
values (1001, 'Med Family', 'str.Sadovianu 7/5', '+37369982418', 'MedFamily'),
	   (1002, 'Galaxia', 'str.Puskin 21/1', '+37367756224', 'Galaxia gr.')
Go

select * from Med_inst
Go






insert into Family_doctor(Cod_fam_doctor, fio_doct, Tel_munb, area, Stamp)
values (2067, 'Burlakova Anna Sergei', '+37367766545', 'Dacia', 'Burlakova A.S.'),
	   (2068, 'Fulger Elena Matvei', '+37368453213', 'Nicolae Milescu Spataru', 'Fulger A.M.'),
	   (2069, 'Antonescu Anton Anton', '+37369999675', 'Sodoveanu', 'Antonescu A.A.'),
	   (2070, 'Maskov Andrei Mihail', '+37367893421', 'Petru Zadnipru', 'Maskov A.M.'),
	   (2071, 'Nastasiu Olgo Ivan', '+37368568258', 'Alecu Russo', 'Nastasiu O.I.')
Go

select * from Family_doctor
Go





insert into Tratement(cod_trate, trat_name, trat_method, duration)
values (1000, 'Phiziotherapy', 'Light phizical load', 20),
	   (1001, 'Electroforez', 'Light electric discharges', 20),
	   (1002, 'Aqua procedures', 'swimming in the pool', 30),
	   (1003, 'Magnetic rezonans', 'Magnetic belt', 20),
	   (1004, 'Massage', 'massage', 15)
Go

select * from Tratement
Go

update Tratement
set trat_method = 'Swimming in the pool'
where trat_method = 'swimming in the pool'
Go

update Tratement
set trat_method = 'Massage'
where trat_method = 'massage'
go


delete from Tratement where trat_method = 'massage'
Go




insert into Medicaments(cod_med, med_name, purpose, dosage, instruction)
values (2000, 'Menovazan', 'Knees', 100, 'Apply to knees'),
	   (2001, 'Geucamen', 'Back', 70, 'Apply to back'),
	   (2002, 'Aertal', 'Joints', 80, 'Apply to joints or back'),
	   (2003, 'Lorista', 'Headache', 120, '1 pill per 24 hours'),
	   (2005, 'Aspirin', 'Thins the blood', 75, 'for Headache')
Go

select * from Medicaments
Go

update Medicaments
set instruction = 'For headache'
where instruction = 'for Headache'
Go





insert into Tratement_Medicamenst(cod_trate, cod_med)
values (1000, 2000),
	   (1004, 2002)
Go

select * from Tratement_Medicamenst
Go




insert into Speciallist(cod_spec, fio_spec, post, Stamp, cod_MI)
values (10001, 'Crudov Dmitrii Anton', 'Nevrolog', 'Crudov D.M.', 1001),
	   (12002, 'Malahov Andrei Nicolai', 'Terapeft', 'Malahov A.N.', 1002),
	   (11003, 'Malisheva Elena Vasilii', 'Cardiolog', 'Malisheva E.V.', 1002),
	   (11004, 'Cojocaru Aliona Eugen', 'Genicolog', 'Cojocaru A.E.', 1001)
go

select * from Speciallist
Go






insert into Patient(cod_pac, fio_pac, age, gender, Birth_date, pac_adres, Cod_fam_doctor, pac_tel, Number_insurance_police, Work, IDNP)
values (10001, 'Botnaru Iurii Ivan', 24, 'M', '1998-03-13', 'str.Sadovianu 7/5, 13', 2069,'+37369982417', 100872, 'Combinat Poligrafic', '1998475612432'),
	   (10002, 'Botsan Nicolai Vladimir', 17, 'M', '2004-08-22', 'str.Nicolae Milescu Spataru 32, 323', 2068,'+37367722224', 164535, 'CEITI student', '2004500167543'),
	   (10003, 'Globu Sergei Vitalii', 37, 'M', '1985-11-11', 'str.Puskin 19, 123', 2069,'+37368888967', 562369, 'Librarius', '1985550354233'),
	   (10004, 'Gutu Vladimir Vladimir', 41, 'M', '1981-12-31', 'str.Petru Zadnipru 36, 66', 2071,'+37369123456', 164535, 'Paza Bercut', '1981300300300'),
	   (10005, 'Leanu Vasilisa Andrei', 28, 'F', '1994-07-05', 'str.Nicolae Milescu Spataru 2, 100', 2067,'+37360564354', 974530, 'Mobias Banca', '1994500111112')
go

select * from Patient
Go


update Patient
set Cod_fam_doctor = 2068
where fio_pac = 'Leanu Vasilisa Andrei'
go

update Patient
set Cod_fam_doctor = 2070
where fio_pac = 'Gutu Vladimir Vladimir'
go




insert into Diagnoza(cod_diagnoz, name_diagnoz, cod_trate)
values (5007, 'Fracture', 1000),
	   (5010, 'Back pain', 1003),
	   (5015, 'Headache', 1000),
	   (5100, 'Throat pain', 1002)
go

select * from Diagnoza
Go




insert into Note(note_numb, cod_spec, cod_pac, cod_diagnoz, cod_MI)
values (19751, 12002, 10005, 5100, 1001),
	   (16859, 10001, 10003, 5015, 1002)
go

select * from Note
Go

delete Note where cod_diagnoz = 5015 or cod_diagnoz = 5100
go






insert into Referral(cod_ref, cod_pac, cod_diagnoz, Cod_fam_doctor, cod_spec, vizit_date, cod_MI)
values (16543, 10002, 5015, 2068, 10001, '2022-02-17 15:30:00', 1001),
	   (18599, 10003, 5015, 2069, 10001, '2022-02-09 16:30:00', 1001),
	   (28564, 10005, 5010, 2068, 12002, '2022-02-18 17:00:00', 1001)
go

select * from Referral
Go





insert into Recept(recept_numb, cod_pac, cod_med, Dosage, trat_duration, prescription_date, cod_MI, cod_spec)
values (98346, 10003, 2000, 100, 30, '2022-02-09', 1001, 12002),
	   (86253, 10005, 2005, 50, 15, '2022-02-18', 1001, 10001)
go

select * from Recept
Go








create index med_inst_indx on Med_inst(name_MI)
go

create index med_inst_stamp_indx on Med_inst(Stamp)
go


create index family_doct_intx on Family_doctor(fio_doct)
go

create index family_doct_stamp_indx on Family_doctor(Stamp)
go


create index tratement_indx on Tratement(trat_name)
go

create index tratement_method_indx on Tratement(trat_method)
go








drop table Med_inst
go
drop table Family_doctor
go
drop table Tratement
go
drop table Medicaments
go
drop table Tratement_Medicamenst
go
drop table Speciallist
go
drop table Patient
go
drop table Diagnoza
go
drop table Referral
go
drop table Note
go
drop table Recept
go

drop database Despanser
go