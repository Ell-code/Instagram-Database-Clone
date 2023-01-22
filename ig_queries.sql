-- 1. Find the five oldest users
SELECT *
FROM users
ORDER BY instagram_db.users.created_at ASC
LIMIT 5;

-- 2. What day of the week do most user register on? (Most Popular Registration Date)
SELECT 
	DAYOFWEEK(created_at) AS day_of_the_week, 
    DAYNAME(created_at) AS day, 
    COUNT(created_at) as total_count
FROM users
GROUP BY DAYOFWEEK(created_at)
ORDER BY COUNT(created_at) DESC, DAYOFWEEK(created_at);

-- 3. Inactive Users. Users who never posted a picture
SELECT username
FROM users
LEFT JOIN photos
	on users.id = photos.user_id
WHERE ISNULL(user_id);

-- 4. Most Liked picture (identify the most populafr photo and the user who created it)
SELECT image_url, count(*) AS total, username
FROM photos
JOIN likes
	ON photos.id = likes.photo_id
JOIN users
	on users.id = photos.user_id
GROUP BY photos.id
ORDER BY count(*) DESC
LIMIT 1;

-- 5. How many time does the average user post
-- Avergae = Total number of photos / total number of users

SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS avg;
    
-- 6. Most commonly used HasTag

SELECT tag_name, 
	COUNT(*) AS total
FROM tags
JOIN photo_tags
	ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Bot detection
SELECT username,
	COUNT(*) AS total
FROM users
-- JOIN photos
-- 	ON photos.user_id = users.id
JOIN likes
	ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING total = (SELECT COUNT(*) FROM photos);