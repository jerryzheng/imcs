
select o.id, c.tax_id tin, c.account_number bank_account_number, c.routing_number bank_routing_number, 
c.uses_savings_account bank_is_savings_account, c.settlement_method bank_settlement_method,
c.billing_reference payee_name,
a.id address_id, a.address1, a.address2, a.pobox, a.city, a.state, a.county, a.postal_code, a.country_code
from owners o 
JOIN contact_infos c ON  o.contact_info_id = c.id
JOIN addresses a ON c.billing_address_id = a.id


SELECT i.tin,  c.tax_id,  
i.bank_account_number, c.account_number,  
i.bank_routing_number, c.routing_number,
i.bank_is_savings_account,  c.uses_savings_account, 
i.bank_settlement_method, c.settlement_method,  
i.payee_name, c.billing_reference
FROM im_investors i, owners o, contact_infos c
WHERE i.external_id_type = 'apm'  
AND  i.external_id = o.id
AND  o.contact_info_id = c.id
;


--- Move data over
---select  c.billing_reference
--- from  im_investors i, owners o, contact_infos c


UPDATE  im_investors i, owners o, contact_infos c
SET i.payee_name = c.billing_reference
WHERE i.external_id_type = 'apm'
AND  i.external_id = o.id
AND  o.contact_info_id = c.id
AND c.billing_reference is not null
AND length( c.billing_reference) > 0
AND i.payee_name is NULL;

----- Master one

UPDATE  im_investors i, owners o, contact_infos c
SET i.tin =  c.tax_id,  i.bank_account_number = c.account_number,  i.bank_routing_number = c.routing_number,
i.bank_is_savings_account = c.uses_savings_account, i.bank_settlement_method = c.settlement_method,  
i.payee_name = c.billing_reference
WHERE i.external_id_type = 'apm'  
AND  i.external_id = o.id
AND  o.contact_info_id = c.id
;


INSERT into im_addresses
(street1, street2, pobox, city, state, postal_code,  country_code, investor_id, created_at, updated_at)
select a.address1, a.address2, a.pobox, a.city, a.state, a.postal_code, a.country_code, i.id, now(), now()
from im_investors i
JOIN owners o on i.external_id = o.id and i.external_id_type ='apm'
JOIN contact_infos c ON  o.contact_info_id = c.id
JOIN addresses a ON c.billing_address_id = a.id 
WHERE i.payment_address_id is NULL 




UPDATE im_investors i, im_addresses a
SET i.payment_address_id = a.id
WHERE a.investor_id = i.id
AND (a.id <> i.tax_address_id or i.tax_address_id is null)
AND  i.payment_address_id is NULL;


;



update im_funds set sync_distributions_to_external = 1;

update im_settings set value = 1 where name = 'experiments.external_sync.apm_enabled';

