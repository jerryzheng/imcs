
create table jerry1 as 
select i.id investor_id, a.address1,  min(a2.id) add_id
from im_investors i,  owners o, contact_infos c, addresses a, im_addresses a2, im_investors_contacts ic
where i.payment_address_id is null 
and ic.investor_id = i.id
and a2.contact_id = ic.contact_id
and o.id = i.external_id and i.external_id_type = 'apm' 
and o.contact_info_id = c.id 
and c.ignore_billing_address = 1
and a.contact_info_id = c.id and a.position = 1 
and a.address1 = a2.street1
group by investor_id, a.address1;


update im_investors, jerry1 set im_investors.payment_address_id = jerry1.add_id where im_investors.id = jerry1.investor_id;


drop table jerry1;


select i.id investor_id, a.address1  
from im_investors i,  owners o, contact_infos c, addresses a, im_investors_contacts ic
where i.payment_address_id is null
and ic.investor_id = i.id
and o.id = i.external_id and i.external_id_type = 'apm'
and o.contact_info_id = c.id
and c.ignore_billing_address = 1
and a.contact_info_id = c.id and a.position = 1
and not exists (select 1 from im_addresses a2 
where a.address1 = a2.street1
and a2.contact_id = ic.contact_id)
group by investor_id, a.address1



