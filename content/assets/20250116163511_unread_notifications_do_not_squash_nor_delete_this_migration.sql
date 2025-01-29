-- +migrate Up 
BEGIN;
SET FOREIGN_KEY_CHECKS = 0;

# This table and the trigger on userNotification live here, outside of code specification.
# Make sure to not remove this migration when squashing the migrations.

DROP TRIGGER IF EXISTS createUnreadNotifications;
DROP TABLE IF EXISTS `unreadNotification`;

CREATE TABLE `unreadNotification`
(
	`notificationId` CHAR(22) NOT NULL,
	`userId`         CHAR(22) NOT NULL,
	`clientId`       CHAR(22) NOT NULL,
	PRIMARY KEY `pk_notificationId_userId` (`notificationId`, `userId`),
	INDEX `idx_notificationId` (`notificationId`),
	FOREIGN KEY `fk_notificationId` (`notificationId`) REFERENCES `userNotification` (`id`) ON DELETE CASCADE,
	INDEX `idx_userId` (`userId`),
	FOREIGN KEY `fk_userId` (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE,
	INDEX `idx_clientId` (`clientId`),
	FOREIGN KEY `fk_clientId` (`clientId`) REFERENCES `client` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB,
  DEFAULT CHARACTER SET = utf8mb4;

# Trigger for automatically inserting the "ack" entities
# for all client's users, whether active or not.

CREATE DEFINER = nest@`%` TRIGGER createUnreadNotifications
	AFTER INSERT
	ON userNotification
	FOR EACH ROW
BEGIN
	INSERT INTO unreadNotification (notificationId, userId, clientId)
	SELECT NEW.id, clientUser.userId, NEW.clientId
	FROM clientUser
	WHERE clientUser.clientId = NEW.clientId;
END;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
