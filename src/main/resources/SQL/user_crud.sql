DROP TABLE IF EXISTS Table_1;

/*==============================================================*/
/* Table: Table_1                                               */
/*==============================================================*/
CREATE TABLE Table_1
(
   column1             CHAR(32) NOT NULL COMMENT 'column1',
   Column_2             VARCHAR(200) COMMENT '姓名',
   Column_3             VARCHAR(200) COMMENT '姓名全拼',
   Column_4             VARCHAR(10) COMMENT '性别',
   Column_5             VARCHAR(200) COMMENT '身份证证件类型',
   Column_6             VARCHAR(200) COMMENT '身份证件号码',
   Column_7             DATE COMMENT '出生日期',
   Column_8             VARCHAR(200) COMMENT '手机号码',
   Column_9             VARCHAR(200) COMMENT '电子邮箱',
   createtime           DATETIME,
   updatetime           DATETIME,
   PRIMARY KEY (column1)
);

ALTER TABLE Table_1 COMMENT 'Table_1<人员基本信息表>';

/*Trigger: id_trigger
-----------------------

Statement:
----------

BEGIN
	SET new.column1=REPLACE(UUID(),'-','');
    END

Table:
------

table_1

Event:
------

INSERT

Timing:
-------

BEFORE

Created:
--------

(NULL)*/