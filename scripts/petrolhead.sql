-- Person

   CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `DTYPE` varchar(31) DEFAULT NULL,
  `EMAILID` varchar(255) DEFAULT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `PASSWORD` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8


-- Make

CREATE TABLE `make` (
  `id` bigint(20) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NICENAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

-- Model

CREATE TABLE `model` (
  `id` varchar(255) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NICENAME` varchar(255) DEFAULT NULL,
  `makeId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_MODEL_makeId` (`makeId`),
  CONSTRAINT `FK_MODEL_makeId` FOREIGN KEY (`makeId`) REFERENCES `make` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

-- Years

CREATE TABLE `years` (
  `YEAR` bigint(20) NOT NULL,
  PRIMARY KEY (`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


-- Model Map year

CREATE TABLE `model_map_year` (
  `id` varchar(255) NOT NULL,
  `year` bigint(20) NOT NULL,
  PRIMARY KEY (`id`,`year`),
  KEY `FK_model_map_year_year` (`year`),
  CONSTRAINT `FK_model_map_year_id` FOREIGN KEY (`id`) REFERENCES `model` (`id`),
  CONSTRAINT `FK_model_map_year_year` FOREIGN KEY (`year`) REFERENCES `years` (`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

-- Car

CREATE TABLE `car` (
  `id` bigint(20) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `NAME` varchar(500) DEFAULT NULL,
  `makeId` bigint(20) DEFAULT NULL,
  `modelId` varchar(255) DEFAULT NULL,
  `year` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_CAR_year` (`year`),
  KEY `FK_CAR_makeId` (`makeId`),
  KEY `FK_CAR_modelId` (`modelId`),
  CONSTRAINT `FK_CAR_makeId` FOREIGN KEY (`makeId`) REFERENCES `make` (`id`),
  CONSTRAINT `FK_CAR_modelId` FOREIGN KEY (`modelId`) REFERENCES `model` (`id`),
  CONSTRAINT `FK_CAR_year` FOREIGN KEY (`year`) REFERENCES `years` (`YEAR`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


-- User View Car
CREATE TABLE `user_view_car` (
  `created_at` datetime DEFAULT NULL,
  `has_liked` tinyint(1) DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `style_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`style_id`),
  KEY `FK_user_view_car_style_id` (`style_id`),
  CONSTRAINT `FK_user_view_car_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_view_car_style_id` FOREIGN KEY (`style_id`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

-- User rating Car

CREATE TABLE `user_rating_car` (
  `COMMENT` varchar(1024) DEFAULT NULL,
  `comment_date` datetime NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `RATE` int(11) DEFAULT NULL,
  `style_id` bigint(20) NOT NULL,
  PRIMARY KEY (`person_id`,`style_id`),
  KEY `FK_user_rating_car_style_id` (`style_id`),
  CONSTRAINT `FK_user_rating_car_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_rating_car_style_id` FOREIGN KEY (`style_id`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8

-- User Map Car
CREATE TABLE `user_map_car` (
  `created_at` datetime DEFAULT NULL,
  `has_followed` tinyint(1) DEFAULT '0',
  `has_liked` tinyint(1) DEFAULT '0',
  `person_id` int(11) NOT NULL,
  `style_id` bigint(20) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`person_id`,`style_id`),
  KEY `FK_user_map_car_style_id` (`style_id`),
  CONSTRAINT `FK_user_map_car_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_user_map_car_style_id` FOREIGN KEY (`style_id`) REFERENCES `car` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8