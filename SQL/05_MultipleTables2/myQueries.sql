/*Select the team with the highest average weight of its batters per year*/


WITH prev AS 
(
SELECT yearid, ROUND(AVG(weight), 6), team_id
FROM people
JOIN batting
ON people.playerid = batting.playerid
GROUP BY yearid, batting.team_id
ORDER BY yearid DESC
),
prev2 AS 
(SELECT prev.yearid, MAX(prev.round)
FROM prev
JOIN teams
ON prev.team_id = teams.id
GROUP BY 1
ORDER BY 1 DESC
),
prev3 AS 
(SELECT prev.yearid, MAX(prev.round), teams.name
FROM prev
JOIN teams
ON prev.team_id = teams.id
GROUP BY 1, 3
ORDER BY 1 DESC
)
SELECT prev2.yearid, prev2.max, prev3.name 
FROM prev2
JOIN prev3
ON prev2.max = prev3.max
ORDER BY 1 DESC;
