-- +migrate Up 
BEGIN;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `nest`
(
	`id`         VARCHAR(255)                NOT NULL,
	`created`    DATETIME                    NOT NULL,
	`lastUpdate` DATETIME                    NOT NULL,
	`domain`     VARCHAR(255)                NOT NULL,
	`location`   VARCHAR(255)                NOT NULL,
	`status`     ENUM ('ACTIVE', 'DISABLED') NOT NULL DEFAULT 'DISABLED',
	`isDefault`  TINYINT(1),
	UNIQUE idx_14e6b51e1c87adb29cb3355a61494bb0 (`domain`),
	UNIQUE idx_9943cb39e4ac2490f97ee3dcff0cce16 (`isDefault`),
	PRIMARY KEY idx_d8d688aaf82376fc8c70759a7c14ec9d (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

CREATE TABLE `instance`
(
	`id`                  CHAR(22)                                             NOT NULL,
	`nestId`              VARCHAR(255)                                         NOT NULL,
	`clientId`            CHAR(22)                                             NOT NULL,
	`projectId`           CHAR(22)                                             NOT NULL,
	`status`              ENUM ('NEW','CREATING','ACTIVE','DELETING','FAILED') NOT NULL DEFAULT 'NEW',
	`number`              BIGINT(20)                                                    DEFAULT NULL,
	`created`             DATETIME                                             NOT NULL,
	`lastUpdate`          DATETIME                                             NOT NULL,
	`publicIpV4`          VARCHAR(255)                                                  DEFAULT NULL,
	`publicIpV4Shared`    TINYINT(1)                                           NOT NULL DEFAULT 0,
	`publicIpV6`          VARCHAR(255)                                                  DEFAULT NULL,
	`publicZone`          VARCHAR(255)                                         NOT NULL,
	`zeropsSubdomainHost` VARCHAR(255)                                                  DEFAULT NULL,
	`isPrimary`           TINYINT(1)                                                    DEFAULT NULL,
	UNIQUE INDEX `idx_71a4b275a99e36aab9bfb1ad8b874cef` (`projectId`, `isPrimary`),
	PRIMARY KEY `idx_4563e84dc97efb662260a8627b068b02` (`id`),
	INDEX `idx_8b81640d442eb3712e9eb0e6e58b0b27` (`nestId`),
	FOREIGN KEY `idx_681e9010785b09826565f0a6f05d2653` (`nestId`) REFERENCES `nest` (`id`),
	INDEX `idx_3af74290cdc5a81a42075d12b2687171` (`clientId`),
	FOREIGN KEY `idx_0027bbb6536fabf3d823f013f6f920d7` (`clientId`) REFERENCES `client` (`id`),
	INDEX `idx_8fffa47c859113f623b95ac1434d72c1` (`projectId`),
	FOREIGN KEY `idx_2c00a65bd6496267556c31f6a8a1e34d` (`projectId`) REFERENCES `project` (`id`)
) ENGINE = InnoDB,
  DEFAULT CHARACTER SET = utf8mb4;

# ALTER TABLE with DEFAULT NULL changed in next schema migration to NOT NULL, after data migration.
ALTER TABLE `process` ADD COLUMN `instanceId` CHAR(22) DEFAULT NULL AFTER `projectId`;
ALTER TABLE `container` ADD COLUMN `instanceId` CHAR(22) DEFAULT NULL AFTER `projectId`;
ALTER TABLE `container` ADD COLUMN `nestId` VARCHAR(255) DEFAULT NULL AFTER `id`;
ALTER TABLE `container` ADD INDEX `idx_08f007745d8d4eeaf1eff5d40ed61a86` (`instanceId`);
ALTER TABLE `container` ADD INDEX `idx_58c52b68a7f4c509d825d20de1e31705` (`nestId`);
ALTER TABLE `container` ADD FOREIGN KEY `idx_9a6179b9ee3612d9f07d4374e89509fb` (`instanceId`) REFERENCES `instance` (`id`);
ALTER TABLE `container` ADD FOREIGN KEY `idx_c828381d2188b3f257dae8c0cc3fea08` (`nestId`) REFERENCES `nest` (`id`);
ALTER TABLE `appVersionObjectRemovalQueue` ADD COLUMN `nestId` VARCHAR(255) DEFAULT NULL AFTER `created`;
ALTER TABLE `appVersionObjectRemovalQueue` ADD INDEX `idx_2ddfaa484f7b4f74ab268ca99d6c6945` (`nestId`);
ALTER TABLE `appVersionObjectRemovalQueue` ADD FOREIGN KEY `idx_98e6954667917cdee2592e3757740565` (`nestId`) REFERENCES `nest` (`id`);
ALTER TABLE `ipQueue` CHANGE COLUMN `projectId` `instanceId` CHAR(22) DEFAULT NULL AFTER `ip`;
ALTER TABLE `service` ADD COLUMN `instanceId` CHAR(22) DEFAULT NULL AFTER `projectId`;
ALTER TABLE `service` ADD COLUMN `nestId` VARCHAR(255) DEFAULT NULL AFTER `id`;
ALTER TABLE `service` ADD INDEX `idx_f4d7d6f89ca6da9d9258943675b39ac5` (`instanceId`);
ALTER TABLE `service` ADD INDEX `idx_896661f10833a8790174b0038edf5c1f` (`nestId`);
ALTER TABLE `service` ADD FOREIGN KEY `idx_b9350ad87baf919f3e0032c5fe24cf98` (`nestId`) REFERENCES `nest` (`id`);
ALTER TABLE `service` ADD FOREIGN KEY `idx_2d741f6d20aef1da1991741761f98798` (`instanceId`) REFERENCES `instance` (`id`);
ALTER TABLE `serviceStack` DROP INDEX `idx_7420347931dd60cd0dbcc243e39d11b7`;
ALTER TABLE `serviceStack` ADD COLUMN `instanceId` CHAR(22) DEFAULT NULL AFTER `projectId`;
ALTER TABLE `serviceStack` ADD COLUMN `nestId` VARCHAR(255) DEFAULT NULL AFTER `id`;
ALTER TABLE `serviceStack` ADD INDEX `idx_db50c1dc22ae1707e5ab11a52e01b241` (`instanceId`);
ALTER TABLE `serviceStack` ADD UNIQUE INDEX `idx_d72b77a20b8f3d703b61977a1dd71bae` (`instanceId`, `name`);
ALTER TABLE `serviceStack` ADD INDEX `idx_9278df8e7700b13cbb9c8a1b5455d3ec` (`nestId`);
ALTER TABLE `serviceStack` ADD FOREIGN KEY `idx_e82ad611cff24c75959cbf8da6900277` (`nestId`) REFERENCES `nest` (`id`);
ALTER TABLE `serviceStack` ADD FOREIGN KEY `idx_c1097d071ccd3db9d698ed889e9358c3` (`instanceId`) REFERENCES `instance` (`id`);

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
