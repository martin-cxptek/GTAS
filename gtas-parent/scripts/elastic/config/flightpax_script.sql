 select * from (select 
	concat(fp.`passenger_id`,'+',fp.`flight_id`) "id",
	f.`eta`  "flight.eta",
	f.`carrier`  "flight.carrier",
	f.`etd` "flight.etd", 
	f.`flight_number` "flight.flight_number",
	f.`full_flight_number` "flight.full_flight_number",
	f.`flight_date` "flight.flight_date",
	f.`id` "flight.id",
	f.`origin` "flight.origin", 
	f.`origin_country` "flight.origin_country",
-- 	f.`rule_hit_count` "flight.rule_hit_count",
	f.`passenger_count` "flight.passenger_count",
	f.`direction` "flight.direction",
	seat.`number` "flight.seat_number",
	
	p.`id` "p_id",
	p.`citizenship_country` "p_citizenship_country", 
	p.`debarkation` "p_debarkation", 
	p.`embarkation` "p_embarkation", 
	p.`gender` "p_gender", 
	p.`last_name`, 
	p.`first_name`, 
	p.`middle_name`, 
	p.`dob` "p_dob", 
	p.`passenger_type`, 
	p.`residency_country`,
	
	d.`document_number` "d_document_number",
	d.`document_type` "d_document_type",
	d.`expiration_date` "d_expiration_date",
	d.`issuance_country` "d_issuance_country",
	d.`issuance_date` "d_issuance_date", 
	d.`days_valid` "d_days_valid",
	d.`id` "d_document_id",
	
	a.id "address.id",
	a.`line1` "address.line1",
	a.`city` "address.city",
	a.`country` "address.country",
	a.`line2` "address.line2",
	a.`line3` "address.line3",
	a.`postal_code` "address.postal_code",
	a.`state` "address.state",
	a.`created_at` "address.created_at",
	a.`created_by` "address.created_by",
	
	pnr_message.`raw` "pnr",
	apis_message.`raw` "apis",

	pax_watchlist.`id` "pax_watchlist.id",
	pax_watchlist.`last_run_timestamp` "pax_watchlist.last_run_timestamp",
	pax_watchlist.`passenger_id` "pax_watchlist.passenger_id",
	pax_watchlist.`percent_match` "pax_watchlist.percent_match",
	pax_watchlist.`verified_status` "pax_watchlist.verified_status",
	pax_watchlist.`watchlist_item_id` "pax_watchlist.watchlist_item_id"
	
	from `flight_pax` fp 
	join `passenger` p 
		on (p.`id` = fp.`passenger_id`) 
	join `flight` f 
		on (fp.`flight_id` = f.`id`) 
	left join `document` d 
		on (d.`passenger_id` = p.id)
	left join `pnr_passenger` pnr_p
		on (pnr_p.`passenger_id` = fp.`passenger_id`)
	left join `pnr_flight` pnr_f
		on (pnr_f.`flight_id` = fp.`flight_id` and pnr_p.`pnr_id` = pnr_f.`pnr_id`)
	left join pnr_address pnr_a
		on (pnr_a.`pnr_id` = pnr_f.`pnr_id`)
	left join `address` a
		on (a.id = pnr_a.`address_id`)
	left join `pnr` pnr
		on (pnr_p.pnr_id = pnr.id and pnr_f.`pnr_id` = pnr.id)
	left join `message` pnr_message
		on (pnr_message.id = pnr.id)
	left join `apis_message_flight_pax` apis_fp
		on (apis_fp.`flight_pax_id` = fp.id)
	left join `apis_message` apis
		on (apis_fp.`apis_message_id` = apis.id)
	left join `message` apis_message
		on (apis.id = apis_message.id)
	left join `pax_watchlist_link` pax_watchlist
		on (pax_watchlist.passenger_id=p.id)
	left join seat 
		on (seat.flight_id=f.ID and seat.passenger_id=p.id)
	 ) a