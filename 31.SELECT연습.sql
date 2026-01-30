USE WNTRADE;

SELECT * FROM 고객;
select * from 사원;
SELECT * FROM 주문세부;
SELECT * FROM 부서;
select  고객번호, 고객회사명 
FROM 고객;
select 고객번호, 담당자명
, 고객회사명 AS 이름
, 마일리지 as 포인트 
from 고객;

select 이름 as 직원명, 주소, 직위 from 사원;

SELECT 제품명
, 단가
, 재고 as '구매가능 수량!!'
, format(단가*재고, 0) as '주문가능금액'
FROM 제품;

# 주문정보 출력하기 - 제품번호, 단가, 주문수량, 할인율, 할인금액, 주문금액 출력

SELECT 제품번호
, format(단가, 0) AS '단가'
, 주문수량
, FORMAT(주문수량*단가*(1-할인율), 0) AS '주문금액'
, 할인율
, FORMAT(할인율 * 단가, 0) AS '할인금액'
FROM 주문세부
ORDER BY (할인율 * 단가) DESC;


SELECT 고객번호
, 담당자명
, 마일리지
FROM 고객
WHERE 마일리지 >= 100000;

SELECT 단가
FROM 주문세부
WHERE 단가 >= 10000;

SELECT 제품명
, 재고
, format(단가*재고, 0) as '주문가능금액'
FROM 제품
WHERE 단가*재고 >= 100000;

SELECT * FROM 사원;

SELECT 이름
, 입사일
FROM 사원
WHERE 직위 = '사원';

SELECT 제품명
, 재고
FROM 제품
WHERE 단가*재고 > 100000
ORDER BY 1 ASC; -- ASC(기본), DESC 1>제품명, 2>재고 이런식으로 넘버링 (SELECT)다음 값

SELECT 고객번호
, 담당자명
, 도시
, 마일리지
FROM 고객
WHERE 도시 = '서울특별시'
ORDER BY 4 DESC;

SELECT *
FROM 고객
LIMIT 3;

SELECT *
FROM 고객
ORDER BY 마일리지 DESC 
LIMIT 3;

SELECT *
FROM 고객;

SELECT *
FROM 고객
ORDER BY 마일리지 DESC
LIMIT 3;

SELECT *
FROM 마일리지등급;

SELECT *
FROM 부서;

SELECT *
FROM 사원;

SELECT *
FROM 사원
WHERE 직위 = '사원'
ORDER BY 이름 ASC;

SELECT *
FROM 제품;

SELECT *
FROM 제품
WHERE 재고 >= 30
ORDER BY 단가 DESC
LIMIT 30;

SELECT *
FROM 주문;

SELECT *
FROM 주문
WHERE 사원번호 = 'E04'
ORDER BY 주문일
LIMIT 10;

SELECT *
FROM 주문세부
ORDER BY 제품번호;

SELECT *
, 단가*주문수량 AS 주문금액
FROM 주문세부
WHERE 주문수량 >= 10
ORDER BY 제품번호 ASC
LIMIT 30 ;

SELECT DISTINCT 도시 
FROM 고객;

SELECT 23 + 5 AS 더하기
, 23 -5 AS 빼기
, 23 * 5 AS 곱하기
, 23 / 5 AS 실수나누기
, 23 DIV 5 AS 정수나누기
, 23 % 5 AS 나머지1
, 23 MOD 5 AS 나머지2;

SELECT '오늘의 고객은'
, CURRENT_DATE()
, 담당자명
FROM 고객;

SELECT 23 >= 5
, 23 <= 5
, 23 > 23
, 23 < 23
, 23 = 23
, 23 != 23
, 23 <> 23;

SELECT *
FROM 고객;

SELECT *
FROM 고객
WHERE 담당자직위 != '대표 이사'
ORDER BY 담당자직위 DESC;

SELECT *
FROM 주문
ORDER BY 주문일 ;

DESCRIBE 주문;

SELECT *
FROM 고객
WHERE 도시 = '부산광역시'
AND 마일리지 < 1000;

SELECT *
FROM 고객
WHERE 도시 = '서울특별시'
AND 마일리지 >= 5000;

SELECT *
FROM 고객
WHERE 도시 = '서울특별시'
OR 마일리지 >= 10000;

SELECT *
FROM 고객
WHERE 도시 != '서울특별시';

SELECT *
FROM 고객
WHERE 도시 != '서울특별시'
AND 마일리지 >= 5000;

SELECT *
FROM 고객
WHERE 도시 = '서울특별시'
OR 도시 = '부산광역시';

SELECT 고객번호
, 담당자명
, 마일리지
, 도시
FROM 고객
WHERE 도시 = '부산광역시'
OR 마일리지 < 1000
ORDER BY 고객번호 ;

SELECT 고객번호
, 담당자명
, 마일리지
, 도시
FROM 고객
WHERE 도시 = '부산광역시'
UNION ALL
SELECT 고객번호
, 담당자명
, 마일리지
, 도시
FROM 고객
WHERE 마일리지 < 1000
ORDER BY 고객번호 ;

SELECT *
FROM 주문세부
WHERE 단가 >= 5000
OR 할인율 >= 0.5; 

SELECT *
FROM 주문세부
WHERE 단가 >= 5000
UNION
SELECT *
FROM 주문세부
WHERE 할인율 >= 0.5; 

SELECT 도시 
FROM 고객
UNION
SELECT 도시 
FROM 사원;

SELECT 도시
FROM 고객
UNION
SELECT 도시
FROM 사원;

SELECT *
FROM 고객
;

SELECT *
FROM 고객
WHERE 지역 = '';

SELECT *
FROM 고객
ORDER BY 지역 = '' desc;

SELECT 고객번호
, 담당자명
, 담당자직위
FROM 고객
WHERE 담당자직위 IN ('영업 과장', '마케팅 과장');

SELECT 담당자명
, 마일리지
FROM 고객
WHERE 마일리지 BETWEEN 100000 AND 200000;

SELECT *
FROM 사원
WHERE 부서번호 IN ('A1', 'A2');

SELECT *
FROM 주문
WHERE 주문일 BETWEEN '2020-06-01' AND '2020-06-11';

/* QUERY 질의문 - SELECT 행 단위로 추출하는 명령
SELECT 컬럼목록 - 값의 목록 지정, AS, 수식 사용법
FROM 테이블목록
WHERE 조건식 	
ORDER BY 컬럼목록 - 출력을 정렬 - ASC/ DESC
LIMIT n - 출력의 갯수 지정
DISTINCT - 컬럼에 나오는 값의 목록
*/

/* 쿼리 실행순서
FROM
WHERE
SELECT
ORDER BY 
LIMIT
*/

/* 연산자
수치연산자, 비교연산자, 논리연산자, 집합연산자(UNION, UNION ALL)
IS NULL
IN, BETWEEN AND
*/

/* SQL문 작성 규칙
대소문자 구분 X -> 명령여, 테이블명, 컬럼명/ 컬럼값 제외
여러 줄에 걸쳐 작성 o -> 마지막에 ; 필수 "들여쓰기 하면 좋음"
명령어는 대문자로 쓰는 것이 일반적
컬럼목록, 테이블 목록은 , (콤마)로 연결한다. 순서 중요
*/

SELECT 도시
FROM 고객
WHERE 도시 LIKE '%광역시';

# 첫글자가 C로 시작하는 고객번호
SELECT *
FROM 고객
WHERE 고객번호 LIKE 'C%';

# 두번째 글자가 C가 들어가는 고객번호
SELECT *
FROM 고객
WHERE 고객번호 LIKE '_C%';

# 세번째 글자가 C인 고객번호
SELECT *
FROM 고객
WHERE 고객번호 LIKE '__C%';

# 마지막 글자가 C인 고객번호
SELECT *
FROM 고객
WHERE 고객번호 LIKE '%C';

SELECT *
FROM 고객
WHERE 도시 LIKE '%광역시'
AND (고객번호 LIKE '_C%'
OR 고객번호 LIKE '__C%');

# 만약에 AND 부분에 () 없으면 광역시 & 두번째가 C인 애랑 그냥 C가 3번째인 애까지 추가로 나옴.
SELECT *
FROM 고객
WHERE 도시 LIKE '%광역시'
AND (고객번호 LIKE '_C%'
OR 고객번호 LIKE '__C%'); #우선순위 ()로 연결해주기

USE WNTRADE;

SELECT field('JAVA', 'SQL', 'JAVA', 'C')
, find_in_set('JAVA', 'SQL,JAVA,C') #이거 좀 특이하게 'SQL,JAVA,C' 여기 콤마 사이 띄워쓰기 하면은 값이 출력 안됨;; 근데 만약에 띄워쓰기 몇번째에 있나 확인하려면 ' JAVA' 이렇게 처음에 입력하면 가능함!
, instr('네 인생을 찾아라', '인생')
, LOCATE('인생', '네 인생을 찾아라'); #INSTR, LOCATE 이거는 () 안에 넣을 값 위치만 다른 것.

SELECT now(), sysdate(); 

SELECT NOW() AS 'START', SLEEP(5), NOW() AS 'END'; #얘는 5초 쉬어도 시작, 끝 값 같음. >> NOW는 쿼리가 시작한 시간을 가리킴. NOW를 기준으로 사용할듯?

SELECT sysdate() AS 'START', SLEEP(5), sysdate() AS 'END'; # 얘는 5초 텀이있음. >> SYSDATE는 시스템입력 기준? OR 호출시간 기준.

SELECT current_date(), current_time() ;

SELECT IF (12500 * 450 > 500000000 , '초과달성', '미달성');

SELECT 고객번호 , IF (마일리지 > 1000, 'VIP', 'GODL') AS '등급'
FROM 고객;

SELECT CASE WHEN 12500 * 450 > 5000000 THEN '초과달성'
WHEN 12500 * 450 > 4000000 THEN '달성'
ELSE '미달성'
END; 
/* CASE WHEN 조건1 THEN 조건1 달성 
WHEN 조건2 THEN 조건2 달성
ELSE 조건 1,2 미달시
END; >>> 꼭 써야함!
*/

SELECT 주문번호
, 단가
, 주문수량
, 단가 * 주문수량 AS 주문금액
, CASE WHEN 단가 * 주문수량 >= 5000000 THEN '초과달성'
WHEN 단가 * 주문수량 >= 4000000 THEN '달성'
ELSE '미달성'
END AS '달성여부' #케이스문' 타이틀을 END 뒤에 AS 써서 달아주면 됨.
FROM 주문세부;

#마일리지 등급
SELECT 고객번호
, 마일리지
, CASE WHEN 마일리지 > 10000 THEN 'VIP'
WHEN 마일리지 > 5000 THEN 'GOLD'
WHEN 마일리지 > 1000 THEN 'SILVER'
ELSE 'BRONZE'
END AS '마일리지등급'
FROM 고객;

#부서번호
SELECT 사원번호
, 이름
, 직위
, CASE WHEN 부서번호 = 'A1' THEN '영업부'
WHEN 부서번호 = 'A2' THEN '기획부'
WHEN 부서번호 = 'A3' THEN '개발부'
ELSE '홍보부'
END AS '부서이름'
FROM 사원;

#주문 테이블에 배송상태 추가 발송일 컬럼 기준, '배송대기' 빠른배송', '일반배송'
SELECT 주문번호
, 주문일
, 발송일
, datediff(발송일, 주문일) AS '주문소요기간'
, CASE WHEN 발송일 IS NULL THEN '배송대기'
WHEN datediff(발송일, 주문일) > 10 THEN '일반배송'
ELSE '빠른배송'
END AS '배송상태'
FROM 주문;

SELECT *, datediff(발송일, 주문일) AS '배송기간' FROM 주문;
SELECT * FROM 주문;

USE WNTRADE;

SELECT COUNT(*)
, COUNT(고객번호)
, COUNT(도시)
, COUNT(DISTINCT 지역)
, SUM(마일리지)
, AVG(마일리지)
, MIN(마일리지)
FROM 고객
# WHERE 도시 LIKE '서울%';
GROUP BY 도시;

SELECT * FROM 고객;

# 담당자별로
SELECT 담당자직위
, COUNT(고객번호)
FROM 고객
GROUP BY 담당자직위;

SELECT 담당자직위
, 도시
, COUNT(고객번호)
, SUM(마일리지)
, AVG(마일리지)
FROM 고객
GROUP BY 담당자직위, 도시
ORDER BY 담당자직위, 도시;

# GROUP BY 조건 HAVING
SELECT 도시
, COUNT(고객번호) AS '고객수'
, AVG(마일리지) AS '평균마일리지'
FROM 고객
GROUP BY 도시
HAVING COUNT(고객번호) >= 10 ;

SELECT 도시
, SUM(마일리지)
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시
HAVING SUM(마일리지) > 1000 ;

# 광역시 고객, 담당자 직위별로 최대마일리지, 단 1만점 이상 레코드만 출력

SELECT 담당자직위 #담당자 직위는 기준이므로 이건 꼭 나와야함
, MAX(마일리지)
FROM 고객
WHERE 도시 LIKE '%광역시'
GROUP BY 담당자직위 #담당자직위로 그룹이 안 나뉘는 값은 나올 수 없다 EX) 도시
HAVING MAX(마일리지) >= 10000 ;

SELECT 담당자직위 #담당자 직위는 기준이므로 이건 꼭 나와야함
, MAX(마일리지)
FROM 고객
WHERE 도시 LIKE '%광역시'
GROUP BY 담당자직위 #담당자직위로 그룹이 안 나뉘는 값은 나올 수 없다 EX) 도시
WITH ROLLUP #총계 행이 추가됨!
HAVING MAX(마일리지) >= 10000 ;

SELECT 도시
, COUNT(고객번호) AS 고객수
, AVG(마일리지)
FROM 고객
WHERE 지역 LIKE ''
GROUP BY 도시
WITH ROLLUP;

SELECT 담당자직위
, 도시
, COUNT(고객번호) AS '고객수'
FROM 고객
WHERE 담당자직위 LIKE '마케팅%'
GROUP BY 담당자직위, 도시
WITH ROLLUP;

USE WNTRADE;

#크로스 조인
SELECT 이름 #부서에는 이름 없고
, 사원.부서번호 AS 사원부서번호
, 부서.부서번호 AS 부서부서번호
, 부서명 #사원에는 부서명이 없기 때문에
FROM 사원 JOIN 부서
ON 부서.부서번호 = 사원.부서번호 #이걸 작성함으로써 크로스조인 > 이너조인으로
WHERE 이름 = '배재용';

# 주문, 고객 INNER JOIN
SELECT 주문번호
, 고객회사명
, 주문일
FROM 주문 JOIN 고객
ON 주문.고객번호 = 고객.고객번호
WHERE 고객.고객번호 = 'ITCWH';

#주문, 사원 INNER JOIN 주문번호별 담당자
SELECT 주문번호
, 사원.사원번호
, 고객번호
, 이름
FROM 사원 JOIN 주문
ON 주문.사원번호 = 사원.사원번호;


#고객, 제품 JOIN 이거는 여러번 걸어야함. 크로스조인 사용하면 모든 것 다 볼 수 있.(고객 갯수 * 제품명 갯수 만큼 출력됨)
SELECT 고객회사명
, 제품명
FROM 고객 JOIN 제품;

#고객, 마일리지 등급 > 비동등 조인
SELECT 고객회사명
, 마일리지
, 등급명
FROM 고객 JOIN 마일리지등급
ON 고객.마일리지 BETWEEN 하한마일리지 AND 상한마일리지;

SELECT 사원번호
, 직위
, 사원.부서번호
, 부서명
FROM 부서 JOIN 사원
ON 부서.부서번호 = 사원.부서번호
WHERE 이름 = '이소미';

SELECT 고객.고객번호
, 담당자명
, 고객회사명
, COUNT(주문.고객번호)
FROM 주문 JOIN 고객
ON 주문.고객번호 = 고객.고객번호
GROUP BY 고객.고객번호
, 고객회사명
, 담당자명
ORDER BY COUNT(주문.고객번호) DESC; # GROUP BY 를 썼기 때문에 주문.고객번호 자리에 *를 써도 된다!

USE WNTRADE;

/*
테이블이 1개 > 심플 쿼리
2 개 이상 > JOIN
크로스 조인(카테지안프로덕트 연산) M개 * N개 결과를 반환
내부 조인(INNER) 조건에 만족하는 데이터만 반환
*/

# 사원 입사일 이후 처리한 주문 조회 - 비동등 조인

SELECT 주문번호 
, 주문.사원번호
, 이름 AS '사원명'
, 입사일
, 주문일
FROM 사원 JOIN 주문
ON 사원.사원번호 = 주문.사원번호
AND 주문일 >= 입사일;

# GROUP BY 사용,, 고객회사들이 주문한 건수 #만약에 고객번호, 담당자명 보이고 싶으면 GROUP BY에도 추가해주기
SELECT 고객회사명
, COUNT(*) AS 주문건수
FROM 주문 JOIN 고객
ON 주문.고객번호 = 고객.고객번호
GROUP BY 고객회사명
ORDER BY 주문건수 DESC;

# 고객회사명 별 주문 금액 합
SELECT 고객회사명
, SUM(단가*주문수량) AS '주문금액'
FROM 고객 JOIN 주문 
ON 고객.고객번호 = 주문.고객번호
JOIN 주문세부
ON 주문.주문번호 = 주문세부.주문번호
GROUP BY 고객회사명
ORDER BY 주문금액 DESC;

# 외부조인 - 없는 자료는 없는대로 붙여서 만들기,, 현재 사원.부서번호에는 A1,A2,A3 밖에 없는데, 부서.부서번호에는 A1,A2,A3,A4까지 있음.
SELECT DISTINCT 부서번호
FROM 사원;
SELECT COUNT(*)
FROM 부서;

# 부서에는 4개이고, 사원은 10개가 있었지만 출력 결과는 9개만.
SELECT *
FROM 사원 RIGHT JOIN 부서
ON 사원.부서번호 = 부서.부서번호;

# 사원이 없는 부서 / 부서가 없는 사원 / 주문 안 한 고객
SELECT *
FROM 사원 LEFT JOIN 부서
ON 사원.부서번호 = 부서.부서번호;

SELECT *
FROM 사원 RIGHT JOIN 부서
ON 사원.부서번호 = 부서.부서번호;

SELECT *
FROM 고객 LEFT JOIN 주문
ON 고객.고객번호 = 주문.고객번호
WHERE 주문번호 IS NULL;