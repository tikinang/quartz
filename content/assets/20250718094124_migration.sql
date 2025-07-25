-- +migrate Up 
BEGIN;
SET FOREIGN_KEY_CHECKS = 0;

ALTER TABLE `container` CHANGE COLUMN `instanceId` `instanceId` CHAR(22) NOT NULL AFTER `projectId`;
ALTER TABLE `container` CHANGE COLUMN `nestId` `nestId` VARCHAR(255) NOT NULL AFTER `id`;
ALTER TABLE `ipQueue` CHANGE COLUMN `instanceId` `instanceId` CHAR(22) NOT NULL AFTER `ip`;
ALTER TABLE `service` CHANGE COLUMN `instanceId` `instanceId` CHAR(22) NOT NULL AFTER `projectId`;
ALTER TABLE `service` CHANGE COLUMN `nestId` `nestId` VARCHAR(255) NOT NULL AFTER `id`;
ALTER TABLE `serviceStack` CHANGE COLUMN `instanceId` `instanceId` CHAR(22) NOT NULL AFTER `projectId`;
ALTER TABLE `serviceStack` CHANGE COLUMN `nestId` `nestId` VARCHAR(255) NOT NULL AFTER `id`;

ALTER TABLE `project` DROP COLUMN `publicZone`;
ALTER TABLE `project` DROP COLUMN `zeropsSubdomainHost`;
ALTER TABLE `project` DROP COLUMN `publicIpV4`;
ALTER TABLE `project` DROP COLUMN `publicIpV4Shared`;
ALTER TABLE `project` DROP COLUMN `publicIpV6`;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
