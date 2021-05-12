SET GLOBAL time_zone = '+01:00';
CREATE DATABASE A;
USE A;
CREATE USER 'JavaInterface'@'localhost' IDENTIFIED BY 'UHjSDJeJ3kFMDFxn';
GRANT ALL PRIVILEGES ON * TO 'JavaInterface'@'localhost';
CREATE TABLE `userInfo` (
  `userID` int PRIMARY KEY AUTO_INCREMENT,
  `userName` varchar(35) UNIQUE,
  `password` varchar(256),
  `salt` varchar(512),
  `connections` int DEFAULT 0
);

CREATE TABLE `userGroupPermissions` (
  `permissionsID` int PRIMARY KEY AUTO_INCREMENT,
  `admin` bool DEFAULT 0,
  `userID` int,
  `chatGroupID` int
);

CREATE TABLE `chatGroup` (
  `chatGroupID` int PRIMARY KEY AUTO_INCREMENT,
  `chatGroupName` varchar(45),
  `directMessage` boolean DEFAULT 0
);

CREATE TABLE `chatMembers` (
  `chatMemberID` int PRIMARY KEY AUTO_INCREMENT,
  `chatGroupID` int,
  `userID` int,
  `mostRecentMessage` int
);

CREATE TABLE `chatGroupData` (
  `messageID` int PRIMARY KEY AUTO_INCREMENT,
  `chatGroupID` int,
  `time` timestamp DEFAULT now(),
  `userID` int,
  `message` varchar(256)
);

ALTER TABLE `userGroupPermissions` ADD FOREIGN KEY (`userID`) REFERENCES `userInfo` (`userID`);

ALTER TABLE `userGroupPermissions` ADD FOREIGN KEY (`chatGroupID`) REFERENCES `chatGroup` (`chatGroupID`);

ALTER TABLE `chatMembers` ADD FOREIGN KEY (`chatGroupID`) REFERENCES `chatGroup` (`chatGroupID`);

ALTER TABLE `chatMembers` ADD FOREIGN KEY (`userID`) REFERENCES `userInfo` (`userID`);

ALTER TABLE `chatGroupData` ADD FOREIGN KEY (`chatGroupID`) REFERENCES `chatGroup` (`chatGroupID`);

ALTER TABLE `chatGroupData` ADD FOREIGN KEY (`userID`) REFERENCES `userInfo` (`userID`);

INSERT INTO userInfo(`userName`, `password`, `salt`) VALUES ('fin', '639dff18cb17dbf32fba47c2d420870ef33b84af28ed72c9081abe2035a6476535cc90411ed1ed305896ac36e337468992e7f3c862ea1e1242163cefaec77451', '-85/126/85/96/67/-84/-96/-45/28/74/-123/-103/89/-17/-36/-37'),
('tob', '47c63578f4ba8ba24993db188e1ef0e967ee64bb347725c1617a0e95209723eae08f852bef40f4103528ecd98d4df775c667502cace435916cc85cefa7c8beae', '95/-24/-122/-85/-95/47/110/-108/-69/-84/-31/-15/59/-96/-56/52');
INSERT INTO `chatGroup`(`chatGroupName`, `directMessage`) VALUES ('Example Group Alpha','0');
INSERT INTO `chatMembers`(`chatGroupID`, `userID`,`mostRecentMessage`) VALUES('1','1','1'), ('1','2','1');
INSERT INTO `chatGroupData`(`chatGroupID`,`time`,`userID`,`message`) VALUES ('1', now(), '1', 'Never gonna give you up'),  ('1', now(), '2', 'Never gonna let you down'),  ('1', now(), '1', 'Never gonna turn around'),  ('1', now(), '2', 'and forget you B-)');
