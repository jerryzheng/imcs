Create Table: CREATE TABLE `jerry1` (
  `my_date` varchar(255) DEFAULT NULL,
  `fund_id` int(11) DEFAULT NULL,
  `ext_id` int(11) DEFAULT NULL,
  `amount` decimal(17,2) DEFAULT NULL,
  `Details` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8



LOAD DATA LOCAL INFILE '/tmp/x.dat' INTO TABLE jerry1 FIELDS TERMINATED by '|' lines terminated by '\r\n'


insert into  im_capital_calls (fund_id, description, created_at, updated_at) select distinct fund_id, 'capital call', now(), now() from jerry1;

INSERT INTO im_capital_call_items (capital_call_id, position_id, requested_date, due_date, amount, 
created_at, updated_at)
SELECT c.id, p.id, STR_TO_DATE(j.my_date, '%c/%e/%Y'), STR_TO_DATE(j.my_date, '%c/%e/%Y'), j.amount, now(), now()
FROM im_capital_calls c,  im_positions p, jerry1 j,  im_investors i 
WHERE c.fund_id = j.fund_id 
and p.fund_id =j.fund_id
and i.id = p.investor_id
and i.external_id = j.ext_id;

INSERT INTO im_contributions (capital_call_item_id, date, amount, details, created_at, updated_at)
SELECT ci.id, ci.requested_date,  ci.amount, j.details, now(), now()
FROM im_capital_call_items ci, im_positions p, jerry1 j,  im_investors i
where ci.position_id = p.id
and p.fund_id = j.fund_id
and i.id = p.investor_id
and i.external_id = j.ext_id
and ci.requested_date = STR_TO_DATE(j.my_date, '%c/%e/%Y')
and ci.amount = j.amount
order by 1
;


SELECT ci.id, count(*)
FROM im_capital_call_items ci, im_positions p, jerry1 j,  im_investors i
where ci.position_id = p.id
and p.fund_id = j.fund_id
and i.id = p.investor_id
and i.external_id = j.ext_id
and ci.requested_date = STR_TO_DATE(j.my_date, '%c/%e/%Y')
and ci.amount = j.amount
group by 1
order by 2
;








