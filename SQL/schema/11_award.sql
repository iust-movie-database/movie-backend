CREATE TABLE award (
    award_id BIGSERIAL PRIMARY KEY,
    award_name VARCHAR(255) NOT NULL,
    category VARCHAR(511) NOT NULL,
    ceremony_date DATE NOT NULL CHECK (ceremony_date <= CURRENT_DATE),
    title_id BIGINT NOT NULL REFERENCES title(title_id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'Nominated' CHECK (status IN ('Nominated', 'Won'))
);