-- =====================================================
-- MOVIE DATABASE - COMPLETE SETUP
-- =====================================================
-- Run: psql -U postgres -f sql/setup.sql
-- =====================================================

\echo '=========================================='
\echo 'Setting up Movie Database'
\echo '=========================================='

-- Drop and recreate database
\echo '0. Creating database...'
DROP DATABASE IF EXISTS movie;
CREATE DATABASE movie;

-- Connect to the new database
\c movie

-- =====================================================
-- 1. SCHEMA (Tables)
-- =====================================================
\echo '1. Creating schema...'
\i sql/schema/01_titles.sql
\i sql/schema/02_series.sql
\i sql/schema/03_season.sql
\i sql/schema/04_episodes.sql
\i sql/schema/05_genre.sql
\i sql/schema/06_has_genre.sql
\i sql/schema/07_person.sql
\i sql/schema/08_role.sql
\i sql/schema/09_cast_member.sql
\i sql/schema/10_crew_member.sql
\i sql/schema/11_award.sql
\i sql/schema/12_users.sql
\i sql/schema/13_saved.sql
\i sql/schema/14_recommended.sql
\i sql/schema/15_review.sql
\i sql/schema/16_similar_to.sql
\i sql/schema/17_review_archive.sql

-- =====================================================
-- 2. INDEXES
-- =====================================================
\echo '2. Creating indexes...'
\i sql/indexes/01_indexes.sql

-- =====================================================
-- 3. TRIGGERS
-- =====================================================
\echo '3. Creating triggers...'
\i sql/triggers/01_update_title_vote_count.sql
\i sql/triggers/02_update_title_score.sql
\i sql/triggers/03_series_check_end_date.sql
\i sql/triggers/04_update_total_season.sql
\i sql/triggers/05_update_total_episodes.sql
\i sql/triggers/06_update_season_total_episodes.sql
\i sql/triggers/07_season_check_release_date.sql
\i sql/triggers/08_season_check_end_date.sql
\i sql/triggers/09_check_episode_release_date.sql

-- =====================================================
-- 4. FUNCTIONS
-- =====================================================
\echo '4. Creating functions...'
\i sql/functions/01_get_hero_title.sql
\i sql/functions/02_get_popular_genres.sql
\i sql/functions/03_get_recommendations.sql
\i sql/functions/04_get_top_movies.sql
\i sql/functions/05_get_top_series.sql
\i sql/functions/06_get_coming_soon.sql
\i sql/functions/07_get_title_header.sql
\i sql/functions/08_get_title_cast.sql
\i sql/functions/09_get_title_crew.sql
\i sql/functions/10_get_title_awards.sql
\i sql/functions/11_get_title_reviews.sql
\i sql/functions/12_get_title_similars.sql
\i sql/functions/13_get_series_seasons.sql
\i sql/functions/14_get_series_episodes.sql
\i sql/functions/15_get_profile_header.sql
\i sql/functions/16_get_watchlist.sql
\i sql/functions/17_get_user_ratings.sql
\i sql/functions/18_search_titles.sql
\i sql/functions/19_get_user_by_email.sql
\i sql/functions/20_calculate_similar_titles.sql
\i sql/functions/21_get_content_recommendations.sql
\i sql/functions/22_get_collaborative_recommendations.sql
\i sql/functions/23_get_hybrid_recommendations.sql

-- =====================================================
-- 5. PROCEDURES
-- =====================================================
\echo '5. Creating procedures...'
\i sql/procedures/01_save_title.sql
\i sql/procedures/02_remove_saved_title.sql
\i sql/procedures/03_add_review.sql
\i sql/procedures/04_remove_review.sql
\i sql/procedures/05_update_user_profile.sql
\i sql/procedures/06_remove_user.sql
\i sql/procedures/07_refresh_similar_titles.sql
\i sql/procedures/08_refresh_user_recommendations.sql
\i sql/procedures/09_refresh_hybrid_recommendations.sql
\i sql/procedures/10_archive_old_reviews.sql
\i sql/procedures/11_register_user.sql

-- =====================================================
-- 6. SEED DATA
-- =====================================================
\echo '6. Loading seed data...'
\i sql/seed/01_seed_titles.sql
\i sql/seed/02_seed_series.sql
\i sql/seed/03_seed_seasons.sql
\i sql/seed/04_seed_episodes.sql
\i sql/seed/05_seed_persons.sql
\i sql/seed/06_seed_roles.sql
\i sql/seed/07_seed_cast_members.sql
\i sql/seed/08_seed_crew_members.sql
\i sql/seed/09_seed_awards.sql
\i sql/seed/10_seed_genres.sql
\i sql/seed/11_seed_has_genre.sql
\i sql/seed/12_seed_users.sql
\i sql/seed/13_seed_reviews.sql
\i sql/seed/14_seed_saved.sql
CALL refresh_similar_titles();
CALL refresh_hybrid_recommendations();

-- =====================================================
-- 7. VERIFICATION
-- =====================================================
\echo '7. Verifying setup...'
SELECT 'Total titles: ' || COUNT(*) FROM title;
SELECT 'Total persons: ' || COUNT(*) FROM person;
SELECT 'Total users: ' || COUNT(*) FROM users;
SELECT 'Total reviews: ' || COUNT(*) FROM review;

\echo '=========================================='
\echo 'Database setup complete!'
\echo '=========================================='