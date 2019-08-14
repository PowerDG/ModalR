
ALTER TABLE `research_home`.`parties` 
MODIFY COLUMN `LikeLevel` decimal(4, 2) NULL DEFAULT NULL AFTER `Number`;
																