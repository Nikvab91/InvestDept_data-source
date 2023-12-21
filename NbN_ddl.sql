-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 1.0.0-beta1
-- PostgreSQL version: 15.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- -- object: pg_database_owner | type: ROLE --
-- -- DROP ROLE IF EXISTS pg_database_owner;
-- CREATE ROLE pg_database_owner WITH 
-- 	INHERIT
-- 	 PASSWORD '********';
-- -- ddl-end --
-- 

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: provider1 | type: DATABASE --
-- DROP DATABASE IF EXISTS provider1;
CREATE DATABASE provider1
	ENCODING = 'UTF8'
	LC_COLLATE = 'en_US.UTF-8'
	LC_CTYPE = 'en_US.UTF-8'
	TABLESPACE = pg_default
	OWNER = postgres;
-- ddl-end --


-- object: operreport | type: SCHEMA --
-- DROP SCHEMA IF EXISTS operreport CASCADE;
CREATE SCHEMA operreport;
-- ddl-end --
ALTER SCHEMA operreport OWNER TO postgres;
-- ddl-end --

-- object: prestage | type: SCHEMA --
-- DROP SCHEMA IF EXISTS prestage CASCADE;
CREATE SCHEMA prestage;
-- ddl-end --
ALTER SCHEMA prestage OWNER TO postgres;
-- ddl-end --

-- object: operreport_cp | type: SCHEMA --
-- DROP SCHEMA IF EXISTS operreport_cp CASCADE;
CREATE SCHEMA operreport_cp;
-- ddl-end --
ALTER SCHEMA operreport_cp OWNER TO postgres;
-- ddl-end --

-- object: operreport_cp1 | type: SCHEMA --
-- DROP SCHEMA IF EXISTS operreport_cp1 CASCADE;
CREATE SCHEMA operreport_cp1;
-- ddl-end --
ALTER SCHEMA operreport_cp1 OWNER TO postgres;
-- ddl-end --

SET search_path TO pg_catalog,public,operreport,prestage,operreport_cp,operreport_cp1;
-- ddl-end --

-- object: operreport."Active_flag_client" | type: TYPE --
-- DROP TYPE IF EXISTS operreport."Active_flag_client" CASCADE;
CREATE TYPE operreport."Active_flag_client" AS
ENUM ('1','0');
-- ddl-end --
ALTER TYPE operreport."Active_flag_client" OWNER TO postgres;
-- ddl-end --

-- object: prestage.oradata_cdr | type: TABLE --
-- DROP TABLE IF EXISTS prestage.oradata_cdr CASCADE;
CREATE TABLE prestage.oradata_cdr (
	"ClientID" bigint,
	"Active" smallint,
	"Region" character varying(10),
	"Locality" character varying(30),
	"Status" character varying(40),
	"TariffTitle" character varying(40),
	"StartDate" date,
	"EndDate" date,
	"DumpDate" date,
	"ExpItem" character varying(100),
	"Service" character varying(30),
	"ServiceName" character varying(100),
	"SegmentGroup" character(3),
	"EquipRental" character varying(3),
	"DataUsage" character varying(10),
	"Outages" character varying(15),
	"TechSupport" character varying(15),
	"UsagePattern" character varying(15),
	"Churnrate" character varying(5),
	"ConnectionSpeed" character varying(10)

);
-- ddl-end --
COMMENT ON COLUMN prestage.oradata_cdr."Active" IS E'Флаг активности клиента';
-- ddl-end --
COMMENT ON COLUMN prestage.oradata_cdr."Region" IS E'Буквенный код региона';
-- ddl-end --
COMMENT ON COLUMN prestage.oradata_cdr."Locality" IS E'Населенный пункт, район города. Местонахождение клиента';
-- ddl-end --
ALTER TABLE prestage.oradata_cdr OWNER TO postgres;
-- ddl-end --

-- object: operreport.clients | type: TABLE --
-- DROP TABLE IF EXISTS operreport.clients CASCADE;
CREATE TABLE operreport.clients (
	"ClientID" bigint NOT NULL,
	"Active" operreport."Active_flag_client",
	"DumpDate" date,
	"TariffID" smallint,
	"SubServiceID" smallint,
	"SegmentGroup" character(3),
	"EquipRental" character varying(3),
	"UserStatisticsID" integer,
	"PLClientID" bigint,
	"LocalityID" smallint,
	"RegionID" smallint,
	CONSTRAINT "ClientID_pk" PRIMARY KEY ("ClientID")
);
-- ddl-end --
ALTER TABLE operreport.clients OWNER TO postgres;
-- ddl-end --

-- object: prestage.oradata_pl | type: TABLE --
-- DROP TABLE IF EXISTS prestage.oradata_pl CASCADE;
CREATE TABLE prestage.oradata_pl (
	"ClientID" bigint,
	"DumpDate" date,
	"CSR" numeric(16,2),
	"ESR" numeric(16,2),
	"ODCR" numeric(16,2),
	"CES" numeric(16,2),
	"OCG" numeric(16,2),
	"DI" numeric(16,2),
	"PDW" numeric(16,2),
	"BDRE" numeric(16,2),
	"OOE" numeric(16,2),
	"SACM" numeric(16,2)

);
-- ddl-end --
ALTER TABLE prestage.oradata_pl OWNER TO postgres;
-- ddl-end --

-- object: operreport.regions | type: TABLE --
-- DROP TABLE IF EXISTS operreport.regions CASCADE;
CREATE TABLE operreport.regions (
	"RegionID" smallserial NOT NULL,
	"RegionCode" character varying(10),
	"DumpDate" date,
	CONSTRAINT "RegionID_pk" PRIMARY KEY ("RegionID")
);
-- ddl-end --
ALTER TABLE operreport.regions OWNER TO postgres;
-- ddl-end --

-- object: operreport.localities | type: TABLE --
-- DROP TABLE IF EXISTS operreport.localities CASCADE;
CREATE TABLE operreport.localities (
	"LocalityID" smallserial NOT NULL,
	"LocalityCode" character varying(30),
	"RegionID" smallint,
	"DumpDate" date,
	CONSTRAINT "LocalityID_pk" PRIMARY KEY ("LocalityID")
);
-- ddl-end --
ALTER TABLE operreport.localities OWNER TO postgres;
-- ddl-end --

-- object: operreport.statuses | type: TABLE --
-- DROP TABLE IF EXISTS operreport.statuses CASCADE;
CREATE TABLE operreport.statuses (
	"StatusID" smallserial NOT NULL,
	"StatusDesc" character varying(40),
	"DumpDate" date,
	"ClientID" bigint,
	CONSTRAINT "StatusID_pk" PRIMARY KEY ("StatusID")
);
-- ddl-end --
ALTER TABLE operreport.statuses OWNER TO postgres;
-- ddl-end --

-- object: operreport.tariffs | type: TABLE --
-- DROP TABLE IF EXISTS operreport.tariffs CASCADE;
CREATE TABLE operreport.tariffs (
	"TariffID" smallserial NOT NULL,
	"TariffTitle" character varying(40),
	"DumpDate" date,
	"ConnectionSpeed" character varying(10),
	"UsagePatterns" character varying(15),
	CONSTRAINT "TariffID_fk" PRIMARY KEY ("TariffID")
);
-- ddl-end --
ALTER TABLE operreport.tariffs OWNER TO postgres;
-- ddl-end --

-- object: operreport.services | type: TABLE --
-- DROP TABLE IF EXISTS operreport.services CASCADE;
CREATE TABLE operreport.services (
	"ServiceID" smallserial NOT NULL,
	"Service" character varying(30),
	"DumpDate" smallint,
	CONSTRAINT "ServiceID_fk" PRIMARY KEY ("ServiceID")
);
-- ddl-end --
ALTER TABLE operreport.services OWNER TO postgres;
-- ddl-end --

-- object: operreport.subservices | type: TABLE --
-- DROP TABLE IF EXISTS operreport.subservices CASCADE;
CREATE TABLE operreport.subservices (
	"SubServiceID" smallserial NOT NULL,
	"ServiceName" character varying(100),
	"DumpDate" date,
	"ServiceID" smallint,
	CONSTRAINT "SubServiceID_fk" PRIMARY KEY ("SubServiceID")
);
-- ddl-end --
ALTER TABLE operreport.subservices OWNER TO postgres;
-- ddl-end --

-- object: operreport.userstatistics | type: TABLE --
-- DROP TABLE IF EXISTS operreport.userstatistics CASCADE;
CREATE TABLE operreport.userstatistics (
	"UserStatisticsID" serial NOT NULL,
	"DataUsage" character varying(10),
	"DumpDate" date,
	"Outages" smallint,
	"TSTickets" smallint,
	CONSTRAINT "UserStatisticID_fk" PRIMARY KEY ("UserStatisticsID")
);
-- ddl-end --
ALTER TABLE operreport.userstatistics OWNER TO postgres;
-- ddl-end --

-- object: clients_pk | type: CONSTRAINT --
-- ALTER TABLE operreport.clients DROP CONSTRAINT IF EXISTS clients_pk CASCADE;
ALTER TABLE operreport.clients ADD CONSTRAINT clients_pk FOREIGN KEY ("UserStatisticsID")
REFERENCES operreport.userstatistics ("UserStatisticsID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: operreport."MrgnINT" | type: VIEW --
-- DROP VIEW IF EXISTS operreport."MrgnINT" CASCADE;
CREATE VIEW operreport."MrgnINT"
AS 
WITH select 
 to_char(c.DumpDate, 'TMMonth') as Period,
 r.RegionCode as Region,
 t.TariffTitle as Tariff,
 s.Service as Service,
 Active,
 sum(pl.CSR - pl.OOE) as Operating Revenue,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 sum((pl.CSR + pl.OOE) - (1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment)) as Operating Profit,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) / count(ei.ExpItemID) as COGS,
 sum(pl.CSR + pl.OOE + pl.DI) as OIBDA

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Internet'

group by 1, 2, 3, 4, 5





select 
 to_char(c.DumpDate, 'TMMonth') as Period,
 r.RegionCode as Region,
 t.TariffTitle as Tariff,
 s.Service as Service,
 Active,
 sum(pl.CSR - pl.OOE) as Operating Revenue,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 sum((pl.CSR + pl.OOE) - (1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment)) as Operating Profit,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) / count(ei.ExpItemID) as COGS,
 sum(pl.CSR + pl.OOE + pl.DI) as OIBDA

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Internet'

group by 1, 2, 3, 4, 5;
-- ddl-end --
ALTER VIEW operreport."MrgnINT" OWNER TO postgres;
-- ddl-end --

-- object: operreport.pl | type: TABLE --
-- DROP TABLE IF EXISTS operreport.pl CASCADE;
CREATE TABLE operreport.pl (
	"PLClientID" bigint NOT NULL,
	"DumpDate" date,
	"CSR" numeric(16,2),
	"ESR" numeric(16,2),
	"ODCR" numeric(16,2),
	"CES" numeric(16,2),
	"OCG" numeric(16,2),
	"DI" numeric(16,2),
	"PDW" numeric(16,2),
	"BDRE" numeric(16,2),
	"OOE" numeric(16,2),
	"SACM" numeric(16,2),
	CONSTRAINT pl_pk PRIMARY KEY ("PLClientID")
);
-- ddl-end --
ALTER TABLE operreport.pl OWNER TO postgres;
-- ddl-end --

-- object: clients_pk1 | type: CONSTRAINT --
-- ALTER TABLE operreport.clients DROP CONSTRAINT IF EXISTS clients_pk1 CASCADE;
ALTER TABLE operreport.clients ADD CONSTRAINT clients_pk1 FOREIGN KEY ("PLClientID")
REFERENCES operreport.pl ("PLClientID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: prestage."1c_data" | type: TABLE --
-- DROP TABLE IF EXISTS prestage."1c_data" CASCADE;
CREATE TABLE prestage."1c_data" (
	"1cID" int8,
	"DumpDate" date,
	"NetMaintenance" numeric(16,2),
	"OfficeRental" numeric(16,2),
	"WagePayment" numeric(16,2),
	"Energy" numeric(16,2)

);
-- ddl-end --
ALTER TABLE prestage."1c_data" OWNER TO postgres;
-- ddl-end --

-- object: operreport."1c" | type: TABLE --
-- DROP TABLE IF EXISTS operreport."1c" CASCADE;
CREATE TABLE operreport."1c" (
	"1cID" int8,
	"DumpDate" date,
	"NetMaintenance" numeric(16,2),
	"OfficeRental" numeric(16,2),
	"WagePayment" numeric(16,2),
	"Energy" numeric(16,2)

);
-- ddl-end --
ALTER TABLE operreport."1c" OWNER TO postgres;
-- ddl-end --

-- object: operreport.expitems | type: TABLE --
-- DROP TABLE IF EXISTS operreport.expitems CASCADE;
CREATE TABLE operreport.expitems (
	"ExpItemID" bigserial NOT NULL,
	"ExpItemCode" bigint,
	"ExpItemDescr" character varying(250),
	"DumpDate" date,
	"ClientID" bigint,
	CONSTRAINT "ExpItemID_pk" PRIMARY KEY ("ExpItemID")
);
-- ddl-end --
ALTER TABLE operreport.expitems OWNER TO postgres;
-- ddl-end --

-- object: operreport."MrgnTV" | type: VIEW --
-- DROP VIEW IF EXISTS operreport."MrgnTV" CASCADE;
CREATE VIEW operreport."MrgnTV"
AS 
WITH select 
 to_char(c.DumpDate, 'TMMonth') as Period,
 r.RegionCode as Region,
 t.TariffTitle as Tariff,
 s.Service as Service,
 Active,
 sum(pl.CSR - pl.OOE) as Operating Revenue,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 sum((pl.CSR + pl.OOE) - (1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment)) as Operating Profit,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) / count(ei.ExpItemID) as COGS,
 sum(pl.CSR + pl.OOE + pl.DI) as OIBDA

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Internet'

group by 1, 2, 3, 4, 5





select 
 to_char(c.DumpDate, 'TMMonth') as Period,
 r.RegionCode as Region,
 t.TariffTitle as Tariff,
 s.Service as Service,
 Active,
 sum(pl.CSR - pl.OOE) as Operating Revenue,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 sum((pl.CSR + pl.OOE) - (1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment)) as Operating Profit,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) / count(ei.ExpItemID) as COGS,
 sum(pl.CSR + pl.OOE + pl.DI) as OIBDA

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Internet'

group by 1, 2, 3, 4, 5;
-- ddl-end --
ALTER VIEW operreport."MrgnTV" OWNER TO postgres;
-- ddl-end --

-- object: operreport."MrgnTS" | type: VIEW --
-- DROP VIEW IF EXISTS operreport."MrgnTS" CASCADE;
CREATE VIEW operreport."MrgnTS"
AS 
WITH select 
 to_char(c.DumpDate, 'TMMonth') as Period,
 r.RegionCode as Region,
 t.TariffTitle as Tariff,
 s.Service as Service,
 Active,
 sum(pl.CSR - pl.OOE) as Operating Revenue,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 sum((pl.CSR + pl.OOE) - (1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment)) as Operating Profit,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) / count(ei.ExpItemID) as COGS,
 sum(pl.CSR + pl.OOE + pl.DI) as OIBDA

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Internet'

group by 1, 2, 3, 4, 5





select 
 to_char(c.DumpDate, 'TMMonth') as Period,
 r.RegionCode as Region,
 t.TariffTitle as Tariff,
 s.Service as Service,
 Active,
 sum(pl.CSR - pl.OOE) as Operating Revenue,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 sum((pl.CSR + pl.OOE) - (1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment)) as Operating Profit,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) / count(ei.ExpItemID) as COGS,
 sum(pl.CSR + pl.OOE + pl.DI) as OIBDA

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Telephone Services'

group by 1, 2, 3, 4, 5;
-- ddl-end --
ALTER VIEW operreport."MrgnTS" OWNER TO postgres;
-- ddl-end --

-- object: clients_pk2 | type: CONSTRAINT --
-- ALTER TABLE operreport.clients DROP CONSTRAINT IF EXISTS clients_pk2 CASCADE;
ALTER TABLE operreport.clients ADD CONSTRAINT clients_pk2 FOREIGN KEY ("LocalityID")
REFERENCES operreport.localities ("LocalityID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: clients_pk3 | type: CONSTRAINT --
-- ALTER TABLE operreport.clients DROP CONSTRAINT IF EXISTS clients_pk3 CASCADE;
ALTER TABLE operreport.clients ADD CONSTRAINT clients_pk3 FOREIGN KEY ("RegionID")
REFERENCES operreport.regions ("RegionID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: expitems_pk | type: CONSTRAINT --
-- ALTER TABLE operreport.expitems DROP CONSTRAINT IF EXISTS expitems_pk CASCADE;
ALTER TABLE operreport.expitems ADD CONSTRAINT expitems_pk FOREIGN KEY ("ClientID")
REFERENCES operreport.clients ("ClientID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "DumpDate_idx" | type: INDEX --
-- DROP INDEX IF EXISTS operreport."DumpDate_idx" CASCADE;
CREATE INDEX "DumpDate_idx" ON operreport."1c"
USING btree
(
	"DumpDate"
);
-- ddl-end --

-- object: operreport."ArpuINT" | type: VIEW --
-- DROP VIEW IF EXISTS operreport."ArpuINT" CASCADE;
CREATE VIEW operreport."ArpuINT"
AS 

create view ArpuINT as select 
 r.RegionCode as Region,
 to_char(c.DumpDate, 'TMMonth') as Period,
 s.Service as Service,
 Active,
 sum(pl.CSR) / count(c.ClientID) as  ARPU,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 avg(pl.SACM) as AVG SAC Market

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Internet'

group by 1, 2, 3, 4;
-- ddl-end --
ALTER VIEW operreport."ArpuINT" OWNER TO postgres;
-- ddl-end --

-- object: operreport."ArpuTS" | type: VIEW --
-- DROP VIEW IF EXISTS operreport."ArpuTS" CASCADE;
CREATE VIEW operreport."ArpuTS"
AS 

create view ArpuTV as select 
 r.RegionCode as Region,
 to_char(c.DumpDate, 'TMMonth') as Period,
 s.Service as Service,
 Active,
 sum(pl.CSR) / count(c.ClientID) as  ARPU,
 sum(1c.NetMaintenance + 1c.OfficeRental + 1c.Energy + 1c.WagePayment) as OPEX,
 avg(pl.SACM) as AVG SAC Market

from clients c 
left join regions r using (RegionID)
left join tariffs t using (TariffID)
left join subservices su using (SubServiceID)
left join services s on su.ServiceID = s.ServiceID
left join pl pl using(PLClientID)
left join 1c 1c using(DumpDate)
left join expitems ei using(ClientID)

where su.ServiceName = 'Television'

group by 1, 2, 3, 4;
-- ddl-end --
ALTER VIEW operreport."ArpuTS" OWNER TO postgres;
-- ddl-end --

-- object: tariffs_fk | type: CONSTRAINT --
-- ALTER TABLE operreport.clients DROP CONSTRAINT IF EXISTS tariffs_fk CASCADE;
ALTER TABLE operreport.clients ADD CONSTRAINT tariffs_fk FOREIGN KEY ("TariffID")
REFERENCES operreport.tariffs ("TariffID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: subservices_fk | type: CONSTRAINT --
-- ALTER TABLE operreport.clients DROP CONSTRAINT IF EXISTS subservices_fk CASCADE;
ALTER TABLE operreport.clients ADD CONSTRAINT subservices_fk FOREIGN KEY ("SubServiceID")
REFERENCES operreport.subservices ("SubServiceID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: localities_pk | type: CONSTRAINT --
-- ALTER TABLE operreport.localities DROP CONSTRAINT IF EXISTS localities_pk CASCADE;
ALTER TABLE operreport.localities ADD CONSTRAINT localities_pk FOREIGN KEY ("RegionID")
REFERENCES operreport.regions ("RegionID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: statuses_pk | type: CONSTRAINT --
-- ALTER TABLE operreport.statuses DROP CONSTRAINT IF EXISTS statuses_pk CASCADE;
ALTER TABLE operreport.statuses ADD CONSTRAINT statuses_pk FOREIGN KEY ("ClientID")
REFERENCES operreport.clients ("ClientID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: services_fk | type: CONSTRAINT --
-- ALTER TABLE operreport.subservices DROP CONSTRAINT IF EXISTS services_fk CASCADE;
ALTER TABLE operreport.subservices ADD CONSTRAINT services_fk FOREIGN KEY ("ServiceID")
REFERENCES operreport.services ("ServiceID") MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: "grant_CU_26541e8cda" | type: PERMISSION --
GRANT CREATE,USAGE
   ON SCHEMA public
   TO pg_database_owner;
-- ddl-end --

-- object: "grant_U_cd8e46e7b6" | type: PERMISSION --
GRANT USAGE
   ON SCHEMA public
   TO PUBLIC;
-- ddl-end --


