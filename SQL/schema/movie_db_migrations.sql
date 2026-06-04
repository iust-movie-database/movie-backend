-- TRIGGERS
-- =====================================================
--  Update Series.total_episodes and total_seasons
-- =====================================================
CREATE OR REPLACE FUNCTION update_series_counts()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Series
    SET 
        total_episodes = (
            SELECT COUNT(*) FROM Episode 
            WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
        ),
        total_seasons = (
            SELECT COUNT(DISTINCT season_number) FROM Episode 
            WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
        )
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_series_counts
AFTER INSERT OR UPDATE OR DELETE ON Episode
FOR EACH ROW
EXECUTE FUNCTION update_series_counts();

-- =====================================================
--  Update Title.vote_count and average score (fixed for DECIMAL(3,2))
-- =====================================================
CREATE OR REPLACE FUNCTION update_title_review_stats()
RETURNS TRIGGER AS $$
DECLARE
    avg_score NUMERIC;
BEGIN
    -- Calculate average score, handle NULL
    SELECT ROUND(AVG(score), 2) INTO avg_score
    FROM Review_T 
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id);
    
    -- Ensure score doesn't exceed 9.99 (DECIMAL(3,2) max)
    IF avg_score > 9.99 THEN
        avg_score := 9.99;
    END IF;
    
    UPDATE Title
    SET 
        vote_count = (
            SELECT COUNT(*) FROM Review_T 
            WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
        ),
        score = avg_score
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_title_stats
AFTER INSERT OR UPDATE OR DELETE ON Review_T
FOR EACH ROW
EXECUTE FUNCTION update_title_review_stats();

-- =====================================================
-- Update Episode.vote_count and average score (fixed for DECIMAL(3,2))
-- =====================================================
CREATE OR REPLACE FUNCTION update_episode_review_stats()
RETURNS TRIGGER AS $$
DECLARE
    avg_score NUMERIC;
    ep_title_id BIGINT;
    ep_season INTEGER;
    ep_episode INTEGER;
BEGIN
    -- Get the episode identifiers
    ep_title_id := COALESCE(NEW.title_id, OLD.title_id);
    ep_season := COALESCE(NEW.season_number, OLD.season_number);
    ep_episode := COALESCE(NEW.episode_number, OLD.episode_number);
    
    -- Calculate average score, handle NULL
    SELECT ROUND(AVG(score), 2) INTO avg_score
    FROM Review_E 
    WHERE title_id = ep_title_id
      AND season_number = ep_season
      AND episode_number = ep_episode;
    
    -- Ensure score doesn't exceed 9.99 (DECIMAL(3,2) max)
    IF avg_score > 9.99 THEN
        avg_score := 9.99;
    END IF;
    
    UPDATE Episode
    SET 
        vote_count = (
            SELECT COUNT(*) FROM Review_E 
            WHERE title_id = ep_title_id
              AND season_number = ep_season
              AND episode_number = ep_episode
        ),
        score = avg_score
    WHERE title_id = ep_title_id
      AND season_number = ep_season
      AND episode_number = ep_episode;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_episode_stats
AFTER INSERT OR UPDATE OR DELETE ON Review_E
FOR EACH ROW
EXECUTE FUNCTION update_episode_review_stats();

-- =====================================================
-- Update Season.episodes_count
-- =====================================================
CREATE OR REPLACE FUNCTION update_season_episode_count()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Season
    SET episodes_count = (
        SELECT COUNT(*) FROM Episode 
        WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
          AND season_number = COALESCE(NEW.season_number, OLD.season_number)
    )
    WHERE title_id = COALESCE(NEW.title_id, OLD.title_id)
      AND season_number = COALESCE(NEW.season_number, OLD.season_number);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_season_episode_count
AFTER INSERT OR UPDATE OR DELETE ON Episode
FOR EACH ROW
EXECUTE FUNCTION update_season_episode_count();