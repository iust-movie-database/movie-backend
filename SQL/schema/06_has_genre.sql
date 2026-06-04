CREATE TABLE has_genre(
	title_id BIGINT REFERENCES title(title_id) ON DELETE CASCADE,
	genre_id BIGINT REFERENCES genre(genre_id) ON DELETE CASCADE,
	PRIMARY KEY(title_id, genre_id)
);