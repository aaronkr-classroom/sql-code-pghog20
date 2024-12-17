CREATE TABLE 교수
(
  교번 INT NOT NULL,
  교수명 INT NOT NULL,
  PRIMARY KEY (교번)
);

CREATE TABLE 교과목
(
  과목_번호 INT NOT NULL,
  과목명 INT NOT NULL,
  PRIMARY KEY (과목_번호)
);

CREATE TABLE 학생
(
  학번 INT NOT NULL,
  학생명 INT NOT NULL,
  PRIMARY KEY (학번)
);

CREATE TABLE 강의실
(
  강의실_번호 INT NOT NULL,
  좌석수 INT NOT NULL,
  PRIMARY KEY (강의실_번호)
);