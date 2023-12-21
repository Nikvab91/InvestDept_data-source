create view MrgnX as select 
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

where su.ServiceName = '%S%'


group by 1, 2, 3, 4, 5;

create view ArpuX as select 
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


where su.ServiceName = '%S%'

group by 1, 2, 3, 4;





