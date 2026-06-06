-- Foreign Keys
CREATE INDEX IF NOT EXISTS idx_reviews_title_id ON review(title_id);
CREATE INDEX IF NOT EXISTS idx_reviews_user_id ON review(user_id); 
CREATE INDEX IF NOT EXISTS idx_saved_user_id ON saved(user_id);
CREATE INDEX IF NOT EXISTS idx_saved_title_id ON saved(title_id);
CREATE INDEX IF NOT EXISTS idx_cast_member_title_id ON cast_member(title_id);
CREATE INDEX IF NOT EXISTS idx_cast_member_person_id ON cast_member(person_id);
CREATE INDEX IF NOT EXISTS idx_crew_member_title_id ON crew_member(title_id);
CREATE INDEX IF NOT EXISTS idx_crew_member_person_id ON crew_member(person_id);

-- Title queries
CREATE INDEX IF NOT EXISTS idx_title_score ON title(score DESC);
CREATE INDEX IF NOT EXISTS idx_title_release_date ON title(release_date DESC);

-- Person search
CREATE INDEX IF NOT EXISTS idx_person_name_en ON person(name_en);
CREATE INDEX IF NOT EXISTS idx_person_name_fa ON person(name_fa);

-- Login
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);