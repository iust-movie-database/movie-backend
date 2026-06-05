CREATE TABLE similar_to(
	title_id BIGINT REFERENCES title(title_id) ON DELETE CASCADE,
	similar_id BIGINT REFERENCES title(title_id) ON DELETE CASCADE
		CHECK (similar_id != title_id),
	simil_date DATE CHECK (simil_date <= CURRENT_DATE),
	score INTEGER,
	PRIMARY KEY (title_id, similar_id)
);