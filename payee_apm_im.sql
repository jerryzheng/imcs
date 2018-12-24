
select i.id,  i.payee_name, c.billing_reference,  c.ignore_billing_address
from im_investors i,  owners o,  contact_infos c
where i.external_id = o.id and o.contact_info_id = c.id;


UPDATE im_investors, owners, contact_infos
SET contact_infos.billing_reference = im_investors.payee_name, contact_infos.ignore_billing_address = 0
WHERE im_investors.payee_name is not null  
and im_investors.external_id = owners.id
and owners.contact_info_id = contact_infos.id
;



