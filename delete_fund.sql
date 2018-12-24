
delete from im_contributions where capital_call_item_id in
(select id from im_capital_call_items where position_id in (select id from im_positions where fund_id in (19, 24)));

delete from im_capital_call_items where position_id in (select id from im_positions where fund_id in (19, 24));

delete from im_positions where fund_id in (19, 24) and previous_position_id is not null;
delete from im_positions where fund_id in (19, 24);

delete from im_capital_calls where fund_id in (19, 24);

delete from im_document_shares where document_id in (select id from im_documents where  fund_id in (19, 24));
delete from im_documents where  fund_id  in (19, 24);


delete from im_addresses where asset_id in (select id from im_assets where fund_id in (19, 24));
delete from im_assets where fund_id in (19, 24);

delete from im_funds where id in (19, 24);



Merge investors;

update im_positions set investor_id = 141 where investor_id = 132;
update im_distribution_items  set investor_id = 141 where investor_id = 132;


delete from im_investors_contacts where investor_id = 132;
delete from im_investors where id=132;

delete from im_investors_contacts where investor_id = 135;
delete from im_investors where id=135;

delete from im_investors_contacts where contact_id = 94;
delete from im_contact_emails where contact_id = 94;
delete from im_addresses where contact_id = 94;

delete from im_contacts where id = 94;

mysql> delete from im_addresses where asset_id = 9;
Query OK, 1 row affected (0.00 sec)

mysql> delete from im_assets where id = 9;
Query OK, 1 row affected (0.00 sec)


-- Delete contributions by position_id

delete from im_contributions where capital_call_item_id in (select id from im_capital_call_items where position_id in (310,311));

delete from im_contributions where capital_call_item_id in 
(select id from im_capital_call_items where position_id in (313, 314, 321, 322, 318, 316, 315, 304)
);


-- Delete contributions with ids

Delete from im_contributions where id in (279, 304, 305, 306, 307, 308, 309, 109);



