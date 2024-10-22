-- 데이터베이스 생성
CREATE DATABASE univDB;

-- 새로 만든 데이터베이스를 선택하세요…

-- 학생 테이블생성
CREATE TABLE 학생
( 학번 CHAR(4) NOT NULL,
이름 VARCHAR(20) NOT NULL,
주소 VARCHAR(50) NULL DEFAULT '미정',
학년 INT NOT NULL,
나이 INT NULL,
성별 CHAR(1) NOT NULL,
휴대폰번호 CHAR(14) NULL,
소속학과 VARCHAR(20) NULL,
PRIMARY KEY (학번) );

-- 과목 테이블 생성
CREATE TABLE 과목
( 과목번호 CHAR(4) NOT NULL PRIMARY KEY,
이름 VARCHAR(20) NOT NULL,
강의실 CHAR(3) NOT NULL,
개설학과 VARCHAR(20) NOT NULL,
시수 INT NOT NULL );

-- 수강 테이블 생성
CREATE TABLE 수강
( 학번 CHAR(6) NOT NULL,
과목번호 CHAR(4) NOT NULL,
신청날짜 DATE NOT NULL,
중간성적 INT NULL DEFAULT 0,
기말성적 INT NULL DEFAULT 0,
평가학점 CHAR(1) NULL,
PRIMARY KEY( 학번, 과목번호) );

-- 학생 테이블입력
INSERT INTO 학생
VALUES 
	('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터'),
	('s002', '홍길동', DEFAULT, 1, 26, '남', NULL, '통계'),
	('s003', '이승엽', NULL, 3, 30, '남', NULL, '정보통신'),
	('s004', '이영애', '경기 분당', 2, NULL, '여', '010-4444-5555', '정보통신'),
	('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터'),
	('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터'),
	('s007', '이온진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영');

-- 괴목 테이블 입력
INSERT INTO 과목
VALUES
('c001', '데이터베이스', '126', '컴퓨터', 3),
('c002', '정보보호', '137', '정보통신', 3),
('c003', '모바일웹', '128', '컴퓨터', 3),
('c004', '철학개론', '117', '철학', 2),
('c005', '전공글쓰기', '120', '교양학부', 1);

-- 수강 테이블 입력
INSERT INTO 수강
VALUES 
('s001', 'c002', '2019-09-03', 93, 98, 'A'),
('s004', 'c005', '2019-03-03', 72, 78, 'C'),
('s003', 'c002', '2017-09-06', 85, 82, 'B'),
('s002', 'c001', '2018-03-10', 31, 50, 'F'),
('s001', 'c004', '2019-03-05', 82, 89, 'B'),
('s004', 'c003', '2020-09-03', 91, 94, 'A'),
('s001', 'c005', '2020-09-03', 74, 79, 'C'),
('s003', 'c001', '2019-03-03', 81, 82, 'B'),
('s004', 'c002', '2018-03-05', 92, 95, 'A');

--새로운 사본 테이블 만들어요
CREATE TABLE 과목2
	(과목번호 CHAR(4) NOT NULL PRIMARY KEY,
	이름 VARCHAR(20) NOT NULL,
	강의실 CHAR(5) NOT NULL,
	개설학관 VARCHAR(20) NOT NULL,
	사수 INT NOT NULL
	);



CREATE TABLE 학생2
	(학번 CHAR(4) NOT NULL,
	이름 VARCHAR(20) NOT NULL,
	주소 VARCHAR(50) DEFAULT '미정',
	학년 INT NOT NULL,
	나이 INT NULL,
	성별 CHAR(1) NOT NULL,
	휴대폰번호 CHAR(13) NULL,
	소속학관 VARCHAR(20) NULL,
	PRIMARY KEY(학번),
	UNIQUE (휴대폰번호)
	);

CREATE TABLE 수강2
	(학번 CHAR(6) NOT NULL,
	과목번호 CHAR(4) NOT NULL,
	신청날짜 DATE NOT NULL,
	중간성적 INT NULL DEFAULT 0,
	기말성적 INT NULL DEFAULT 0,
	평가학점 CHAR(1) NULL,
	PRIMARY KEY (학번, 과목번호),
	FOREIGN KEY (학번) REFERENCES 학생2 (학번),
	FOREIGN KEY (과목번호) REFERENCES 과목2 (과목번호)
	);

--데이터를 입력 / 가져오기
INSERT INTO 학생2
VALUES ('003', '이순신', DEFAULT, 4, 54, '남', NULL, NULL);
INSERT INTO 과목2 SELECT * FROM 과목;
INSERT INTO 학생2 SELECT * FROM 학생;
INSERT INTO 수강2 SELECT * FROM 수강;

TABLE 수강2;
TABLE 학생2;
TABLE 과목2;

-- ALTER TABLE문 (테이블 수정/변경)
ALTER TABLE 학생2
	ADD COLUMN 등록날짜 DATE NOT NULL DEFAULT '2024-10-15';

ALTER TABLE 학생2
	DROP COLUMN 등록날짜;

CREATE TABLE 학생3
	AS SELECT * FROM 학생2;

DROP TABLE 학생3;
TABLE 학생3;

ALTER TABLE 학생2 RENAME COLUMN 소속학관 TO 소속학과;
ALTER TABLE 과목2 RENAME COLUMN 개설학관 TO 개설학과;

--새로운 manager 계정 만든다
SELECT current_user; --postgres (기본 사용자)

CREATE USER manager WITH PASSWORD '1234';

GRANT ALL PRIVILEGES ON DATABASE univdb TO manager;

ALTER DATABASE univdb OWNER TO manager; --postgres계정만 실행 가능 

--위 드랍다운 화살표 누르고 new connection 
--univdb 와 manager 계정 선택하고 저장하기
SElECT current_user;--manager (새로운 사용자)

--뷰
CREATE VIEW V1_고학년학생 (학생이름, 나이, 성, 학년)AS 
	SELECT 이름, 나이, 성별, 학년 FROM 학생2
	WHERE 학년 >= 3 AND 학년 >= 4;

CREATE VIEW V2_과목수강현황(과목번호, 강의실, 수강인원수) AS
	SELECT 과목.과목번호, 강의실, COUNT(과목.과목번호)
	FROM 과목 JOIN 수강 ON 과목.과목번호 = 수강.과목번호
	GROUP BY 과목.과목번호;


CREATE VIEW V3_고학년여학생 AS
	SELECT * FROM V1_고학년학생
	WHERE 성 = '여';

GRANT SELECT ON TABLE 학생2 TO manager; --학생,학생2에 대한 권한 부여
GRANT SELECT ON TABLE 과목2 TO manager; --과목,과목2에 대한 권한 부여
GRANT SELECT ON TABLE 수강2 TO manager; --수강,수강2에 대한 권한 부여

--뷰 조회
SELECT * FROM V1_고학년학생; 
SELECT * FROM V2_과목수강현황;
SELECT * FROM V3_고학년여학생;

--인덱스
CREATE INDEX idx_수강 ON 수강(학번, 과목번호); --오류 : 소유자만 가능 있다면, postgres 계정에서 실행

CREATE UNIQUE INDEX idx_과목 ON 과목(이름 ASC);

CREATE UNIQUE INDEX idx_학생 ON 학생(학번);




SHOW INDEX FROM 학생; --MySQL에서만 가능
