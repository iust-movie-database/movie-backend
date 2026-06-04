CREATE TABLE person (
    person_id BIGSERIAL PRIMARY KEY,
    name_fa VARCHAR(255) NOT NULL,
    name_en VARCHAR(255) NOT NULL,
    birth_date DATE CHECK ((birth_date IS NULL) OR (birth_date < CURRENT_DATE)),
    death_date DATE CHECK ((death_date IS NULL) OR (death_date BETWEEN birth_date AND CURRENT_DATE))
);