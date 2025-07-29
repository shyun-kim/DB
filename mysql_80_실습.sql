/**
* MYSQL :: 정형 데이터를 저장하는 데이터베이스 
- SQL 문법을 사용하여 데이터를 CRUD 한다.
- C(Create:생성, insert)
- R(Read:조회, select) 
- U(Update:수정, update)
- D(Delete:삭제, delete)
- 개발자는 DML에 대한 CRUD 명령어를 잘 사용할 수 있어야한다!!!
- SQL은 대소문자 구분하지 않음, 보통 소문자로 작성
- snake 방식의 네이밍 규칙을 가짐

- SQL은 크게 DDL, DML, DCL, DTL로 구분할 수 있다.
1. DDL(Data Definition Language) : 데이터 정의어
   : 데이터를 저장하기 위한 공간을 생성하고 논리적으로 정의하는 언어
   : create, alter, truncate, drop 
2. DML(Data Manipulation Language) : 데이터 조작어
   : 데이터를 CRUD하는 명령어
   : insert, select, update, delete
3. DCL(Data Control Language) : 데이터 제어어
   : 데이터에 대한 권한과 보안을 정의하는 언어
   : grant, revoke
4. DTL(Data Transaction Language,TCL) : 트랜잭션 제어어
   : 데이터베이스의 처리 작업 단위인 트랜잭션을 관리하는 언어
   : commit, save, rollback
*/

/* 반드시 기억해주세요!!! - 워크벤치 실행시 마다 명령어 실행!!!! */
show databases;  	-- 모든 데이터베이스 조회
use hrdb2019;  		-- 사용할 데이터베이스 오픈
select database(); 	-- 데이터베이스 선택
show tables;		-- 데이터베이스의 모든 테이블 조회


/********************************
	DESC(DESCRIBE) : 테이블 구조 확인
    형식> desc(describe) [테이블명];
********************************/


show tables;
desc employee;
desc department;
desc unit;
desc vacation;

/********************************
	SELECT : 테이블 내용 조회
    형식> select [컬럼 리스트] from [테이블명];
********************************/
select emp_id, emp_name from employee;
select * from employee;
select emp_name, gender, hire_date from employee;

-- 사원 테이블의 사번, 사원명, 성별, 입사일, 급여를 조회
select emp_id, emp_name, gender, hire_date, salary from employee;

-- 부서 테이블의 모든 정보 조회
select * from department;

-- as: 컬럼명 별칭 부여
-- 형식> select [컬럼명 as 별칭, ...] from [테이블명];

-- 사원 테이블의 사번, 사원명, 성별, 입사일, 급여 컬럼을 조회한 한글 컬럼명으로 출력
select emp_id as 사번, emp_name as "사 원 명", gender as 성별, hire_date 입사일, salary 급여 from employee; -- 공백이 들어가는 경우에는 따옴표로 감싸줌, as는 생략가능

-- 사원 테이블의 id, name, gender, Hdate, salary 컬럼명으로 조회
select emp_id ID, emp_name NAME, gender GENDER, hire_date HDATE, salary SALARY from employee;

-- 사원 테이블의 사번, 사원명, 부서명, 폰번호, 이메일, 급여, 보너스(급여*10%)를 조회
-- 기존의 컬럼에 연산을 수행하여 새로운 컬럼을 생성 할 수 있다.
desc employee;
select emp_id, emp_name, dept_id, phone, email, salary, salary*0.1 as bonus from employee;

-- 현재 날짜를 조회: curdate()
select curdate() as DATE from dual;

/********************************
	SELECT : 테이블 내용 상세 조회
    형식> select [컬럼 리스트] 
			from [테이블명]
            where [조건절];
********************************/

-- 정주고 사원의 정보를 조회
select * from employee;
select * from employee where emp_name = "정주고"; -- ""사용가능

-- SYS 부서의 속한 모든 사원을 조회
select * from employee where dept_id = 'SYS';


-- 사번이 S0005인 사원의 사원명, 성별, 입사일, 부서아이디, 이메일, 급여를 조회
select emp_name, gender, hire_date, dept_id, email, salary from employee where emp_id= 'S0005';

-- SYS 부서에 속한 모든 사원들을 조회, 단 출력되는 EMP_ID 컬럼은 사원번호 별칭으로 조회
select emp_id as '사원번호', emp_name, eng_name, gender, hire_date, salary 
from employee 
where dept_id = "sys";

-- where 조건절 컬럼으로 별칭을 사용할 수 있을까요?
-- 사원명이 홍길동인 사원을 별칭으로 조회 :: where 조건절에서 별칭을 컬럼명으로 사용 불가
select emp_id as '사원번호', emp_name as 사원명, eng_name, gender, hire_date, salary 
from employee 
where emp_name = "홍길동";

-- 전략기획 부서의 모든 사원들의 사번, 사원명, 입사일, 급여를 조회
select * from department;
select emp_id, emp_name, hire_date, salary
from employee
where dept_id = 'stg';

-- 입사일이 2014년 8월 1일인 사원들 조회
select * 
from employee 
where hire_date = 20140801; -- date 타입은 표현은 문자열 처럼, 처리는 숫자처럼

--  급여가 5000인 사원들 조회
select * 
from employee 
where salary = 5000;

-- 성별이 남자인 사원들을 조회
select * 
from employee 
where gender = 'm';

-- 성별이 여자인 사원들을 조회
select * 
from employee 
where gender = 'f';

-- null: 아직 정의되지 않은 미지수 
-- 숫자에서는 가장 큰수로 인식, 논리적인 의미를 포함하고 있으므로 등호(=)로는 검색X, is 키워드와 함께 사용 가능
-- 급여가 null인 값을 가진 사원들을 조회
select *
from employee
where salary is null;

-- 사원들의 영어이름이 정해지지 않은 사원들 조회
select * from employee where eng_name is null;

-- 퇴사하지 않은 사원들을 조회
select * from employee where retire_date is null;

-- 퇴사하지 않은 사원들의 보너스 컬럼을 추가하여 조회
select emp_id, emp_name, dept_id, salary, salary*0.2 as Bonus
from employee
where retire_date is null;

-- 퇴사한 사원들의 사번, 사원명, 이메일, 폰번호, 급여를 조회
select emp_id, emp_name, email, phone, salary, retire_date
from employee
where retire_date is not null;

-- ifnull: null 값을 다른 값으로 대체하는 방법
-- 형식> ifnull(null을 포함하고 있는 컬럼명, 대체값)
-- STG 부서에 속한 사원들의 정보 조회, 단, 급여가 null인 사원은 0으로 치환
select * from department;
select * from employee;

select emp_id, emp_name, email, phone, ifnull(salary,0) as salary
from employee
where dept_id = 'stg';

-- 사원 전체 테이블의 내용을 조회, 단 영어이름이 정해지지 않은 사원들은 'Smith' 이름으로 치환
select emp_id, emp_name, email, phone, ifnull(eng_name, 'SMITH') as eng_name
from employee;

-- MKT 부서의 사원들을 조회, 재직중인 사원들의 Retire_date 컬럼은 현재 날짜로 치환
select emp_id, emp_name, eng_name, gender, hire_date, ifnull(retire_date, curdate()) as retire_date, dept_id, phone, email, salary
from employee
where dept_id = 'mkt';


/********************************
	DISTINCT : 중복된 데이터 배제 후 조회
    형식> select distinct [컬럼 리스트] 
			from [테이블명]
            where [조건절];
********************************/
-- 사원 테이블의 부서리스트 조회
select distinct dept_id from employee;
-- 주의! 유니크한 컬럼과 함께 조회 하는 경우 distinct가 적용되지 않음
select distinct emp_id, dept_id from employee;


/********************************
	ORDER BY 컬럼 : 데이터 정렬
    형식> select [컬럼리스트]
			from [테이블]
            where [조건절]
            order by [컬럼, , ...] asc(올림차순)/desc(내림차순)
-- 테이블에 데이터를 넣을 때 정렬 후 넣는것이 아니라 아무곳이나 비어있는곳에 삽입하기 때문에 order by 필요
********************************/

-- 급여를 기준으로 오름차순 정렬
select *
from employee
order by salary desc;

-- 급여, 성별을 기준으로 오름차순 정렬
select *
from employee
order by gender, salary asc;

-- eng_name이 null인 사원들을 입사일 기준으로 내림차순 정렬
select *
from employee
where eng_name is null
order by hire_date desc;

-- 퇴직한 사원들을 급여기준으로 내림차순 정렬
select *
from employee
where retire_date is not null
order by salary desc;

-- 퇴직한 사원들을 급여 기준으로 내림차순 정렬, slalary 컬럼을 '급여' 별칭으로 치환
-- '급여' 별칭으로 order by 가능할까요? :: 별칭으로 order by 가능
-- 실질 순서: where 조건절 데이터 탐색 > 컬럼리스트 > 정렬
select emp_id, emp_name, dept_id, hire_date, retire_date, salary as 급여
from employee
where retire_date is not null
order by 급여 desc;

-- 정보 시스템(sys) 부서 사원들 중 입사일이 빠른 순서, 급여를 많이 받는 순서로 정렬
-- hire_date, salary 컬럼은 '입사일', '급여' 별칭으로 컬럼리스트 생성 후 정렬
select emp_id, emp_name, dept_id, hire_date as 입사일, retire_date, salary as 급여
from employee
where dept_id = "sys"
order by 입사일 asc, 급여 desc;


/********************************
	조건절(where) + 비교연산자: 특정 범위 혹은 데이터 검색
    형식> select [컬럼리스트]
			from [테이블]
            where [비교연산자]
********************************/

-- 급여가 5000 이상인 사원들을 조회
select *
from employee
where salary >= 5000
order by salary;

-- 입사일이 2017-01-01 이후 입사한 사원들을 조회
select *
from employee
where hire_date > 20170101
order by hire_date asc;

-- 입사일이 2015-01-01 이후거나, 급여가 6000 이상인 사원들을 조회
-- ~거나, ~또는 or: 두 개의 조건중 하나만 만족해도 조회 가능
select *
from employee
where hire_date >= '2015-01-01' and salary >= 6000;

-- 특정 기간: 2015-01-01~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준 오름차순 정렬
select *
from employee
where hire_date >= 20150101 and hire_date <=20171231
order by dept_id;

-- 급여가 6000 이상, 8000 이하인 사원 조회
select *
from employee
where salary >=6000 and salary <=8000;

-- mkt 부서 사원들의 사번, 사원명, 입사일, 이메일, 급여, 보너스(급여의 20%) 조회
-- 급여가 null인 사원의 보너스는 기본 50
-- 보너스가 1000 이상인 사원 조회
-- 보너스가 높은 사원 기준으로 정렬
select emp_id, emp_name, hire_date, email, salary, ifnull(salary*0.2, 50) as bonus
from employee
where dept_id = 'MKT' and salary*0.2 >= 1000
order by bonus desc;

-- 사원 명이 '일지매', '오삼식', '김삼순' 인 사원들 조회
select *
from employee
where emp_name = '일지매' or emp_name = '오삼식' or emp_name = '김삼순';


/********************************
	논리곱(and): BETWEEN ~ AND
    형식> select [컬럼리스트]
			from [테이블]
            where [컬럼명] between 값1 and 값2;

	논리합(or): IN
    형식> select [컬럼리스트]
			from [테이블]
            where [컬럼명] in (값1, 값2, 값3...);
********************************/

-- between ~ and
-- 특정 기간: 2015-01-01~ 2017-12-31 사이에 입사한 모든 사원 조회
-- 부서기준 오름차순 정렬
select *
from employee
where hire_date between 20150101 and 20171231
order by dept_id;

-- 급여가 6000 이상, 8000 이하인 사원 조회
select *
from employee
where salary between 6000 and 8000;

-- in
-- 사원 명이 '일지매', '오삼식', '김삼순' 인 사원들 조회
select *
from employee
where emp_name in ('일지매','오삼식','김삼순');

-- 부서 아이디가 mkt, sys, stg에 속한 모든 사원 조회
select *
from employee
where dept_id in ('mkt', 'sys', 'stg')
order by dept_id;

/********************************
	특정 문자열 검색: like 연산자 + 와일드 문자(%, _)
    %: 전체, _: 한글자
    형식> select [컬럼리스트]
			from [테이블]
            where [컬럼명] like '와일드 문자 포함 검색어'
********************************/

-- '한'씨 성을 가진모든 사원 조회
select *
from employee
where emp_name like '한%';

-- 영어 이름이 'f'로 시작하는 모든 사원
select *
from employee
where eng_name like 'f%';

-- 이메일 이름 중 두번째 자리에 'a'가 들어가는 모든 사원 조회
select *
from employee
where email like '_a%';

-- 이메일 아이디가 4자인 모든 사원을 조회
select *
from employee
where email like '____@%';





-- 7/23



/********************************
	내장함수: 숫자함수, 문자함수, 날짜함수
    호출되는 위치 - select 다음의 컬럼리스트, 조건절(where)의 컬럼명
********************************/
-- 숫자함수
-- 함수 실습을 위한 테이블: DUAL 테이블
-- (1) abs(숫자): 절대값
select abs(100), abs(-100) from dual;

-- (2) floor(숫자), truncate(숫자, 자리수): 소수점 버리기, truncate는 자리수 변수로 소수점 몇번째 자리에서 버릴지 선택가능(반올림X)
select floor(123.456), truncate(123.456, 0), truncate(123.456, 1)
from dual;

-- 사원테이블의 sys부서 사원들의 보너스(급여*25%)
-- 보너스 컬럼은 소수점 1자리로 출력
select emp_id, emp_name, dept_id, phone, salary, truncate((salary*0.25), 1) as bonus
from employee
where dept_id = 'sys';

-- (3) RAND(): 임의의 수를 난수로 발생시키는 함수
select rand() from dual;
-- 정수 3자리 난수 발생(0~999)
select floor(rand()*1000) as rand
from dual;
-- 정수 4자리 난수 발생, 소수점 2자리
select truncate(rand()*10000, 2) as rand
from dual;

-- (4) mod(숫자, 나누는 수): 나머지 함수
select mod(123, 2)as odd, mod(124, 2) as even
from dual;

-- 3자리 수를 랜덤으로 발생시켜, 2로 나눈 후 홀수, 짝수를 구분
select mod(floor(rand()*10000),2) as result
from dual;

-- [문자함수]
-- (1) concat: 문자열을 합쳐주는 함수
select concat('안녕하세요~ ', '홍길동'," 입니다") as str
from dual;

-- 사번, 사원명, 사원명2 형식으로 컬럼을 생성하여 조회
-- 사원명2 컬럼의 데이터 형식은 S0001(홍길동) 출력
select emp_id, emp_name, concat(emp_id, '(', emp_name, ')') as 사원명2
from employee;

-- 사번, 사원명, 영어이름, 입사일, 폰번호, 급여를 조회
-- 영어이름의 출력형식을 홍길동/hong 타입으로 출력
-- 영어이름이 null 인 경우에는 'smite'를 기본으로 조회
select emp_id, emp_name, concat(emp_name, '/', ifnull(eng_name, 'smith')) as 영어이름, hire_date, phone, salary
from employee;

-- (2) substring(문자열, 위치, 갯수) : 문자열 추출
select substring("대한민국 홍길동", 1, 4) -- 문자열이기 때문에 1번부터, 저장소 관련 메모리 순서는 0번부터
, substring("대한민국 홍길동", 6,3)
from dual; -- 공백 포함되어 출력됨

-- 사원 테이블의 사번, 사원명, 입사년도, 입사월, 입사일, 급여를 조회
select emp_id, emp_name, substring(hire_date,1,4) as 입사년도, substring(hire_date,6,2) 입사월, substring(hire_date,9,2) 입사일, salary
from employee;

-- 2015년도에 입사한 모든 사원 조회
select *
from employee
where substring(hire_date, 1, 4) = '2025';

-- 2018년도에 입사한 정보시스템(sys) 부서 사원 조회
select *
from employee
where substring(hire_date, 1,4) = 2018 and dept_id = 'sys';

-- (3) left(문자열, 갯수), right(문자열, 갯수): 왼쪽, 오른쪽 기준으로 문자열 추출
select left(curdate(),4) as year, right('010-1234-5678', 4) as phone
from dual;

-- 2018년도에 입사한 모든 사원 조회
select *
from employee
where left(hire_date, 4) = '2018';

-- 2025년부터 2017년사이에 입사한 모든 사원 조회
select *
from employee
where left(hire_date, 4) between 2017 and 2025;

-- 사원번호, 사원명, 입사일, 폰번호, 급여 조회
-- 폰번호는 마지막 4자리만 출력
select emp_id, emp_name, hire_date, right(phone,4), salary
from employee;

-- (4) upper(문자열), lower(문자열): 대소문자 치환
select upper('welcomToMysql'), lower('welcomToMysql')
from dual;

-- 사번, 사원명, 영어이름, 부서아이디, 이메일, 급여를 조회
-- 영어 이름은 전체 대문자, 부서 아이디는 소문자, 이메일은 대문자로 조회
select 	emp_id, 
		emp_name, 
		upper(eng_name), 
        lower(dept_id), 
        upper(email), 
        salary
from employee;

-- (5) trin(): 공백 제거
select 	trim('                대한민국') as t1,
		trim('대한민국                ') as t2,
        trim('대한                민국') as t3,
        trim('        대한민국        ') as t4
from dual;


-- (6) format(문자열, 소수점 자리) : 문자열 포맷 3자리 콤마 구분
select format(123456, 0) as format from dual;
select format('123456', 0) as format from dual;

-- 사번, 사원명, 입사일, 폰번호, 급여, 보너스(급여의 20%)를 조회
-- 급여, 보너스는 소수점 없이, 3자리 콤마(,)로 구분하여 출력
-- 급여가 null인 경우에는 기본값 0
-- 2016년 부터 2017년 사이에 입사한 사원
-- 사번 기준으로 내림차순 정렬

select 	emp_id,
		emp_name, 
        hire_date, 
        phone, 
        format(ifnull(salary, 0), 0) as salary, 
        format(floor(ifnull(salary, 0)*0.2), 0) as bonus
from employee
where left(hire_date, 4) between '2015' and '2017'
order by emp_id desc;

-- [날짜함수]
-- curdate(): 현재 날짜(년,월,일)
-- sysdate(): 현재 날짜(년,월,일,시,분,초)
-- now()

select curdate(), sysdate(), now()
from dual;

-- [형변환 함수]
-- cast(변환하고자 하는 값 as 데이터 타입)
-- convert(변환하고자 하는 값 as 데이터 타입): MySQL에서 지원하는 OLD 버전
select 1234 as number, cast(1234 as char) as string from dual;
select '1234' as string, cast(1234 as signed integer) as number from dual;
select '20250723' as string, cast('20250723' as date) from dual;
select 	now() as date,
		cast(now() as char) as String,
		cast(cast(now() as char) as date) as date,
        cast(curdate() as datetime) as datetime
from dual;


select 	'12345' as string,
		cast('12345' as signed integer) as cast_int, -- int변환
        cast('12345' as unsigned integer) as cast_int2, -- 부호가 포함된 int
        cast('12345' as decimal(10,2)) as cast_desimal -- 실수 형태
from dual;

-- [문자 치환 함수]
-- replace(문자열, old, new)
select 	'홍-길-동' as old,
		replace('홍-길-동', '-', ',') as new from dual;
        
-- 사원 테이블의 사번, 사원명, 입사일, 퇴사일, 부서아이디, 폰번호, 급여 조회
-- 입사일, 퇴사일 출력은 '-'을 '/'로 치환하여 출력
-- 재직중인 사원은 현재날짜를 출력

select	emp_id, 
		emp_name, 
        replace(hire_date, '-','/') as hire_date,
        -- replace(cast(hire_date), '-','/') as hire_date,
        replace(ifnull(retire_date, curdate()), '-','/') as retire_date,
        dept_id,
        phone,
        format(salary, 0) as salary
from employee;


-- '20150101' str으로 입력된 날짜를 기준으로 해당 날짜 이후에 입사한 사원들은 모두 조회
-- 모든 mysqpl 데이터베이스에서 적용가능한 형태로 작성
select *
from employee
where hire_date >= cast('20150101' as date);

-- '20150101' ~ '20171231' 사이에 입사한 사원들을 모두 조회
-- 모든 mysql 데이터 베이스에서 적용 가능한 형태로 작성
select *
from employee
where hire_date between cast('20150101' as date) and cast(20170101 as date);


/********************************
	그룹(집계) 함수 : sum(), avg(), min(), max(), count()..
    group by - 그룹함수를 적용하기 위한 그룹핑 컬럽 정의
    having - 그룹함수에서 사용하는 조건절
********************************/
-- (1) sum(숫자) : 전체 총합을 구하는 함수
-- 사원들 전체의 급여 총액을 조회, 3자리 구분, 마지막 '만원' 표시
select concat(format(sum(salary),0),'만원') as 총급여
from employee;

-- 그룹 함수와 일반 컬럼은 사용 불가
select emp_id, sum(salary)
from employee
group by emp_id;

-- (2) avg(숫자) : 전체 평균을 구하는 함수
-- 사원들 전체의 급여 평균을 조회, 3자리 구분, 앞에 '$' 표시
select concat('$',format(floor(avg(salary)),0)) as '평균 급여'
from employee;

-- 정보시스템(sys) 부서 전체의 급여 총액과 평균을 조회
-- 3자리 구분, 마지막 만원 표시


-- (3) max(숫자): 최대값 구하는 함수
-- 가장 높은 급여를 받는 사원의 급여 조회
select max(salary)
from employee;

-- (4) min(숫자): 최소값 구하는 함수
-- 가장 낮은 급여를 받는 사원의 급여 조회
select min(salary)
from employee;

-- 사원들의 총급여, 평균급여, 최대급여, 최소급여 조회
-- 3자리 구분
select 	format(sum(salary),0) as 급여총액,
		format(avg(salary),0) as 평균급여,
        format(max(salary),0) as 최대급여,
        format(min(salary),0) as 최소급여
from employee;

-- (5) count(컬럼): 조건에 맞는 데이터의 row 수를 조회
-- 전체 row count
select count(*)
from employee;

-- 급여 컬럼의 row count
select count(salary)
from employee; -- null 포함 하지않음

-- 재직중인 사원, 퇴사한 사원의 row count
select 	count(*) as 총사원,
		count(retire_date) as 퇴사자,
        count(*)-count(retire_date) as 재직자
from employee;

-- 2015년도에 입사한 입사자 수
select count(*)
from employee
where left(hire_date, 4)= 2015;

-- 정보시스템(sys) 부서의 사원수
select count(*)
from employee
where dept_id = 'sys';

-- 가장 빠른 입사자, 가장 늦은 입사자를 조회 max(), min() 함수 사용
select max(hire_date), min(hire_date)
from employee;

-- 가장 빨리 입사한 사람의 정보를 조회
select *
from employee
where hire_date = (select min(hire_date) from employee);
-- 서브 쿼리, 괄호에 들어가 있는 값 부터 처리, 그룹 함수는 그대로는 등호 계산이 되지 않음


-- [group by]: 그룹함수와 일반컬럼을 함께 사용 할 수 있도록 함
-- ~~ 별 그룹핑이 가능한 컬럼으로 쿼리 실행

-- 부서별 총급여, 평균급여, 사원수, 최대급여, 최소급여
select dept_id, sum(salary), avg(salary), count(*), max(salary), min(salary)
from employee
group by dept_id;

-- 연도별 총급여, 평균급여, 사원수, 최대급여, 최소급여
-- 소수점 X, 3자리 구분
select 	year(hire_date) as 연도별, -- left(hire_date, 4) 사용가능
		count(*) 사원수, 
        format(sum(salary),0) 총급여, 
        format(avg(salary),0) 평균급여, 
        format(max(salary),0) 최대급여, 
        format(min(salary),0) 평균급여
from employee
group by year(hire_date);

-- 사원별 총급여, 평균급여 조회(사원은 유니크한 값이기 때문에 비추천)

-- [having 조건절]: 그룹함수를 적용한 결과에 조건 추가
-- 부서별 총급여, 평균급여를 조회
-- 부서의 총급여가 30000 이상인 부서만 출력
-- 급여컬럽의 null은 제외
select	dept_id,
		format(sum(salary), 0) as sum,
		format(avg(salary), 0) as avg
from employee
where salary is not null
group by dept_id
having sum(salary) >= 30000;

-- 연도별 총급여, 평균급여, 사원수, 최대급여, 최소급여
-- 소수점 X, 3자리 구분
-- 총급여가 30000이상인 년도 출력
select 	year(hire_date) as 연도별, -- left(hire_date, 4) 사용가능
		count(*) 사원수, 
        format(sum(salary),0) 총급여, 
        format(avg(salary),0) 평균급여, 
        format(max(salary),0) 최대급여, 
        format(min(salary),0) 평균급여
from employee
group by year(hire_date)
having sum(salary) >= 30000;


-- rollup 함수: 리포팅을 위한 함수
-- 부서별 사원수, 총급여, 평균급여 조회
select 	dept_id,
		count(*) count,
        format(sum(ifnull(salary, 0)), 0) sum,
        format(avg(ifnull(salary, 0)), 0) avg
from employee
-- where salary is not null
group by dept_id with rollup;


-- rollup한 결과에 부서 ID를 추가
select 	if(grouping(dept_id), '총합계', ifnull(dept_id, '-')) as dept_id,
		count(*) count,
        format(sum(ifnull(salary, 0)), 0) sum,
        format(avg(ifnull(salary, 0)), 0) avg
from employee
-- where salary is not null
group by dept_id with rollup;


-- 
select 	year(hire_date) as 연도,
		count(*) 사원수, 
        format(sum(salary),0) 총급여, 
        format(avg(salary),0) 평균급여, 
        format(max(salary),0) 최대급여, 
        format(min(salary),0) 평균급여
from employee
group by year(hire_date) with rollup;


-- limit 함수: 출력 갯수를 제한하는 함수
select *
from employee
limit 3; -- 현재 출력되는 기준 상 올림차순으로 n개 조회

-- 최대 급여를 수급하는 사원 순서대로 5명 조회
select *
from employee
order by salary desc
limit 5
;

/********************************
	조인(join): 두개 이상의 테이블을 연동해서 sqlp 실행
    ERD(Entity Relationship Diagrem): 데이터 베이스 구조도(설계도)
    -데이터 모델링: 정규화 과정
    
    **ANSI SQL: 데이터 베이스 시스템들의 표준 SQL
    **조인(join) 종류**
    1) Cross join(Cateisian) - 합집함: 테이블의 데이터 전체를 조인 - 테이블A(10) * 테이블B(10)
    2) Inner join(Natural) - 교집합: 두 개 이상의 테이블을 조인 연결 고리를 통해 조인 실행
    3) Outer Join - Inner Join + 선택한 테이블의 join 제외 row 포함
    4) Self join: 한 테이블을 두개 테이블 처럼 조인 실행
********************************/
use hrdb2019;
select database();
select *
from employee;
select * from department;

-- cross join: 합집합
-- 형식> select [컬럼리스트] from [테이블1], [테이블2]...
-- 		where [조건절]
-- ansi> select [컬럼리스트] from [테이블1] cross join [테이블2], ...
-- where [조건절]

select *
from employee, department;

select *
from employee cross join department;

-- 
select count(*) from vacation;

-- 사원, 부서, 휴가테이블 cross join: 20* 7* 102
select count(*) from employee, department, vacation;
select count(*)
from employee cross join department cross join vacation;

-- inner join 
select count(*)
from employee, department
where employee.dept_id = department.dept_id
order by emp_id;

-- inner join: ansi
-- 형식> select [컬럼리스트] from [테이블1],[테이블2] ...
-- 		where [테이블1.조인컬럼] = [테이블2.조인컬럼]
-- 							and [조건절]
-- ansi> select [컬럼리스트] from [테이블1]
-- 				inner join [테이블2],...
-- 				on [테이블1.조인컬럼] = [테이블2.조인컬럼]
select count(*)
from employee inner join department
on employee.dept_id = department.dept_id
order by emp_id;

/*
-- 사원테이블, 부서테이블, 본부테이블 inner join
select *
from employee e, department d, unit u
where e.dept_id = d.dept_id
and d.unit_id = u.unit_id
order by e.emp_id;

-- 사원테이블, 부서테이블, 본부테이블 inner join : ansi
select *
from employee e 
	inner join department d
	on e.dept_id = d.dept_id
	inner join unit u
    on d.unit_id = u.unit_id ;

-- 사원테이블, 부서테이블, 본부테이블, 휴가테이블 inner join : ansi
select *
from employee e, department d, unit u, vacation v
where e.dept_id = d.dept_id
	and d.unit_id = u.unit_id
    and e.emp_id = v.emp_id;

-- 모든 사원들의 사번, 사원명, 부서아이디, 부서명, 입사일, 급여를 조회
select e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.hire_date, e.salary 
from employee e, department d
where e.dept_id = d.dept_id;

-- 영업부에 속한 사원들의 사번, 사원명, 입사일, 퇴사일, 폰번호, 급여, 부서아이디, 부서명 조회
select e.emp_id, e.emp_name, e.hire_date, e.retire_date, e.phone, e.salary, e.dept_id, d.dept_name
from employee e, department d
where e.dept_id = d.dept_id
	and d.dept_name = '영업';

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들의 내역을 조회
select *
from employee e, department d, vacation v
where e.dept_id = d.dept_id
	and e.emp_id = v.emp_id
    and d.dept_name = '인사';

-- 영업부서 사원의 사원명, 폰번호, 부서명, 휴가사용 이유 조회
-- 휴가 사용 이유가 '두통'인 사원, 소속본부 조회 
select e.emp_name, e.phone, d.dept_name, v.reason, u.unit_name
from employee e, department d, unit u, vacation v
where e.dept_id = d.dept_id
	and d.unit_id = u.unit_id
    and e.emp_id = v.emp_id
    and d.dept_name = '영업'
    and v.reason = '두통';

-- 2014년부터 2016년까지 입사한 사원들 중에서 퇴사하지 않은 사원들의
-- 사원아이디, 사원명, 부서명, 입사일, 소속본부를 조회 
-- 소속본부 기준으로 오름차순 정렬
select e.emp_id, e.emp_name, d.dept_name, e.hire_date, u.unit_name
from employee e, department d, unit u
where e.dept_id = d.dept_id
	and d.unit_id = u.unit_id
    and left(hire_date,4) between '2014' and '2016'
    and e.retire_date is null
order by u.unit_id asc;    

-- 부서별 총급여, 평균급여, 총휴가사용일수를 조회
-- 부서명, 부서아이디, 총급여, 평균급여, 휴가사용일수 
select d.dept_name, d.dept_id, sum(e.salary), avg(e.salary), sum(duration) 
from employee e, department d, vacation v
where e.dept_id = d.dept_id
	and e.emp_id = v.emp_id
group by d.dept_id, d.dept_name;   

-- 본부별, 부서의  휴가사용 일수
select u.unit_name, d.dept_name, d.dept_id, sum(duration) as 휴가사용일수
from employee e, department d, vacation v, unit u
where e.dept_id = d.dept_id
	and e.emp_id = v.emp_id
    and d.unit_id = u.unit_id
group by d.dept_id, d.dept_name, u.unit_name;   

    
-- outer join : inner join + 조인에서 제외된 row(테이블별 지정)
-- 오라클 형식의 outer join은 사용불가, ansi sql 형식 사용 가능!!
-- SELECT [컬럼리스트] FROM 
-- [테이블명1 테이블별칭] LEFT/RIGHT OUTER JOIN 테이블명2 [테이블별칭], ...]
-- 					 ON [테이블명1.조인컬럼 = 테이블명2.조인컬럼]

-- ** 오라클 형식 outer join 사용불가!!!
-- select * from table1 t1, table2 t2
-- where t1.col = t2.col(+);

-- 모든 부서의 부서아이디, 부서명, 본부명을 조회
select * from department;
select d.dept_id, d.dept_name, ifnull(u.unit_name, "협의중") as unit_name
from department d
	left outer join unit u
	on d.unit_id = u.unit_id
order by unit_name ;

-- 본부별, 부서의  휴가사용 일수 조회
-- 부서의 누락없이 모두 출력
select u.unit_name, d.dept_name, count(v.duration)
from employee e left outer join vacation v
	on e.emp_id = v.emp_id
    right outer join department d
    on e.dept_id = d.dept_id
    left outer join unit u
    on d.unit_id = u.unit_id
group by u.unit_name, d.dept_name 
order by u.unit_name desc;

-- 2017년부터 2018년도까지 입사한 사원들의 사원명, 입사일, 연봉, 부서명, 본부명 조회해주세요
-- 단, 퇴사한 사원들 제외
-- 소속본부를 모두 조회  
select e.emp_name, e.hire_date, e.salary, d.dept_name, u.unit_name
from employee e inner join department d
				on e.dept_id = d.dept_id
                left outer join unit u
                on d.unit_id = u.unit_id
where left(hire_date, 4) between '2017' and '2018'                
and retire_date is null;

-- self join : 자기 자신의 테이블을 조인
-- self join은 서브쿼리 형태로 실행하는 경우가 많음!!
-- select [컬럼리스트] from [테이블1], [테이블2]  where [테이블1.컬럼명] = [테이블2.컬럼명]
-- 사원테이블을 self join
select e.emp_id, e.emp_name, m.emp_id, m.emp_name
from employee e, employee m
where e.emp_id = m.emp_id;

select emp_id, emp_name
from employee 
where emp_id = (select emp_id from employee where emp_name='홍길동');

-- 
*/


/********************************
	서브쿼리(SubQuesty): 메인 쿼리에 다른 쿼리를 추가하여 실행하는 방식
    형식: select [컬럼리스트: (스칼라 서브쿼리, 비추천)
		from [테이블명: (인라인뷰)]
        where [조건절:(서브쿼리)]
********************************/

use hrdb2019;
select database();
show tables;

-- [서브쿼리]
-- 정보시스템 부서명의 사원들을 모두 조회
-- 사번, 사원명, 부서아이디, 폰번호, 급여
select emp_id, emp_name, dept_id, phone, salary
from employee
where dept_id = (select dept_id from department where dept_name = '정보시스템');

-- [스칼라 서브쿼리]
-- 정보시스템 부서명의 사원들을 모두 조회
-- 사번, 사원명, 부서아이디, 폰번호, 급여
select 	emp_id, 
		emp_name,
        dept_id,
        (select dept_name from department where dept_name='정보시스템') as dept_name, -- 권장하지 않음
        phone,
        salary
from employee
where dept_id = (select dept_id from department where dept_name = '정보시스템');

-- [서브쿼리: 단일행 - '=']
-- 홍길동 사원이 속한 부서명 조회
select dept_name
from department
where dept_id = (select dept_id from employee where emp_name = '홍길동');

-- 홍길동 사원의 휴가사용내역을 조회
desc vacation;
select *
from vacation
where emp_id = (select emp_id from employee where emp_name = '홍길동');

-- 제 3본부에 속한 모든 부서를 조회
select *
from department
where unit_id = (select unit_id from unit where unit_name = '제3본부');

-- 급여가 가장 높은 사원의 정보 조회
select *
from employee
where salary = (select max(salary) as salary from employee);

-- 급여가 가장 낮은 사원의 정보 조회
select *
from employee
where salary = (select min(salary) as salary from employee);

-- 가장 빨리 입사한 사원의 정보 조회
select *
from employee
where hire_date = (select min(hire_date) from employee);

-- 가장 최근 입사한 사원의 정보 조회
select *
from employee
where hire_date = (select max(hire_date) from employee);

-- [서브쿼리 : 다중행 - in]
-- 제 3본부에 속한 모든 사원 정보 조회
select *
from employee
where dept_id in (select dept_id
					from department
                    where unit_id = (select unit_id from unit where unit_name = '제3본부'));

-- '제3본부'에 속한 모든 사원들의 휴가 사용 내역 조회
select *
from vacation
where emp_id in (select emp_id
				from employee
				where dept_id in (select dept_id
					from department
					where unit_id = (select unit_id from unit where unit_name = '제3본부'))
					);

-- [인라인뷰: 메인쿼리의 테이블 자리에 들어가는 서브쿼리 형식]
-- [휴가를 사용한 사원정보만]
-- 사원별 휴가사용 일수를 그룹핑하여, 사원아이디, 사원명, 입사일, 연봉, 휴가사용 일수를 조회
desc vacation;

select e.emp_id, e.emp_name, e.hire_date, e.salary, v.duration
from employee e, (select emp_id, sum(duration) as duration
				from vacation
				group by emp_id) v
where e.emp_id = v.emp_id;

-- ansi : inner join
select e.emp_id, e.emp_name, e.hire_date, e.salary, v.duration
from employee e
inner join (select emp_id, sum(duration) as duration
				from vacation
				group by emp_id) v
where e.emp_id = v.emp_id;

-- [휴가를 사용한 사원정보 + 사용하지않은 사원 포함]
-- 사원별 휴가 사용 일수를 그룹핑하여 ,사원아이디, 사원명, 입사일, 연봉, 휴가 사둉일수 조회
-- 휴가를 사용하지않은 사원은 기본값 0
-- 사용일수 기준 내림차순 정렬
-- left outer join
select e.emp_id, e.emp_name, e.hire_date, e.salary, ifnull(v.duration, 0) duration
from employee e
		left outer join
        (select emp_id, sum(duration) as duration
				from vacation
				group by emp_id) v
on e.emp_id = v.emp_id
order by duration desc;

-- 1) 2016~2017년도 입사한 사원들의 정보 조회
-- 2) 1번의 실행 결과와 vacation 테이블을 조인하여 휴가 사용 내역 출력
select *
from vacation v,
		(select *
			from employee
            where left(hire_date,4) between '2016' and '2017') e
where v.emp_id = e.emp_id;



-- 1) 부서별 총급여, 평균급여를 구하여 30000 이상인 부서 조회
-- 2) 1번의 실행 결과와 employee 테이블을 조인하여 사원아이디, 사원명, 급여, 부서아이디, 부서명, 부서별 총급여, 평균급여 출력
select e.emp_id, e.emp_name, e.salary, e.dept_id, d.dept_name, t.sum, t.avg
from 	employee e,
		department d,
		(select dept_id, sum(ifnull(salary, 0)) as sum, floor(avg(ifnull(salary,0))) as avg
						from employee
						group by dept_id
                        having sum(ifnull(salary, 0)) > 30000) t
where e.dept_id = d.dept_id and d.dept_id=t.dept_id;



/********************************
	테이블 결과 합치기: union, union all
    형식> 쿼리1 실행 결과 union 쿼리2 실행 결과 (똑같은 값만 걸러내기 - inner join)
		 쿼리1 실행 결과 union all 쿼리2 실행 결과 (전체값 합집합)
	** 실행결과 컬럼이 동일해야 함(컬럼명, 데이터타입)
********************************/
-- 영업부, 정보시스템 부서의 사원아이디, 사원명, 급여, 부서아이디 조회
-- union: 영업 부서 사원들이 한번만 출력
select emp_id, emp_name, salary, dept_id
from employee
where dept_id = (select dept_id from department where dept_name = '영업')
union 
select emp_id, emp_name, salary, dept_id
from employee
where dept_id = (select dept_id from department where dept_name = '영업')
union 
select emp_id, emp_name, salary, dept_id
from employee
where dept_id = (select dept_id from department where dept_name = '정보시스템');

-- union all: 영업 부서 사원들이 중복되어 출력
select emp_id, emp_name, salary, dept_id
from employee
where dept_id = (select dept_id from department where dept_name = '영업')
union all
select emp_id, emp_name, salary, dept_id
from employee
where dept_id = (select dept_id from department where dept_name = '영업')
union all
select emp_id, emp_name, salary, dept_id
from employee
where dept_id = (select dept_id from department where dept_name = '정보시스템');

/********************************
	논리적인 테이블: view(뷰), SQL을 실행하여 생성된 결과를 가상테이블로 정의
    뷰 생성: create view
			as [SQL 정의];
	뷰 삭제: drop view [view 이름]
	** 뷰 생성시 권한을 할당 받아야 함 - mysql, maria는 권한 할당 받지 않아도 됨
    뷰는 편리하지만 권한을 할당 받아야 해서 DBA들이 선호하지 않음,
    view를 가상으로 생성해야 하기 때문에 많이 생성할 시 성능 누수 발생
********************************/
select *
from information_schema.views
where table_schema = 'hrdb2019';

-- 부서 총 급여가 30000 이상인 테이블
create view view_salary_sum
as
select e.emp_id, e.emp_name, e.salary, e.dept_id, d.dept_name, t.sum, t.avg
from 	employee e,
		department d,
		(select dept_id, sum(ifnull(salary, 0)) as sum, floor(avg(ifnull(salary,0))) as avg
						from employee
						group by dept_id
                        having sum(ifnull(salary, 0)) > 30000) t
where e.dept_id = d.dept_id and d.dept_id=t.dept_id;

-- view_salary_sum 실행
select *
from view_salary_sum;

-- view_salary_sum 삭제
drop view view_salary_sum;
select * from information_schema.views
where table_schema = 'hrdb2019';

/********************************
	DDL(Data Definition Language) : 생성, 수정, 삭제 - 테이블 기준
    DML: C(Insert), R(Select), U(Update), D(Delete)
********************************/
-- 모든 테이블 목록
show tables;

-- [테이블 생성]
-- 형식> create table [테이블명] (
-- 				컬럼명 데이터타입(크기),
-- 				....
-- 			);
-- 데이터 타입: 정수형(int, long), 실수형(float, double), 문자형(char, varchar, longtext...), 이진데이터(longblob)..
-- char(고정형 문자형) : 크기가 메모리에 고정되는 형식, 예) char(10) --> 3자리 입력: 7자리 낭비
-- varchar(가변형 문자형) : 실제 저장되는 데이터 크기에 따라 메모리가 변경되는 형식, varchar(10) --> 3자리 입력: 메모리 3자리 공간만 생성
-- longtext: 문장형태로 다수으 ㅣ문자열 저장
-- longblob: 이진데이터 타입의 이미지, 동영상 등 데이터 저장
-- date: 년, 월, 일 -> curdate()
-- datetime: 년, 월, 일, 시, 분, 초 -> sysdate(), now()
desc employee;
select * from employee;

-- emp 테이블 생성
-- emp_id: (char, 4), ename: (varchar, 10), gender: (char, 1), hire_date: (datetime), salary: (int)
show tables;
create table emp (
	emp_id		char(4),
	ename		varchar(10),
    gender		char(1),
    hire_date	datetime,
    salary		int
);

select * from information_schema.tables
where table_schema = 'hrdb2019';

desc emp;

-- [테이블 삭제]
-- 형식> drop table [테이블명];
show tables;

drop table emp;

-- [테이블 복제]
-- 형식> create table [테이블명]
-- 		as [SQL 정의]

-- employee 테이블을 복제하여 emp 테이블 생성
select * from employee;

create table emp
	as select * from employee;
    
show tables;

select * from emp;
desc employee;
desc emp; -- 제약사항은 복제 되지 않음

-- 2016년도에 입사한 사원의 정보를 복제: employee_2016
create table employee_2016
as select * from employee where left(hire_date, 4) = '2016';

desc employee_2016;

/********************************
	데이터 생성(insert:C)
    형식> 	insert into [테이블명] (컬럼리스트...)
			values (데이터1, 데이터2...)
********************************/
show tables;
drop table emp;
desc emp;

select * from employee;
insert into emp(emp_id, ename, gender, hire_date, salary)
values('s001', '홍길동', 'm', now(), 1000);

insert into emp(emp_id, ename, gender, salary, hire_date)
values('s001', '홍길동', 'm', 1000, null);

insert into emp(emp_id)
values('s002'); -- null을 허용하고 있기 때문에 디폴트 값 null로 삽입됨

select * from emp;

-- [테이블 절삭: 테이블의 데이터만 영구 삭제]
-- 형식> truncate table [테이블명];
truncate table emp;
select * from emp;
drop table emp;

create table emp (
	emp_id		char(4)		not null,
	ename		varchar(10) not null,
    gender		char(1) 	not null,
    hire_date	datetime,
    salary		int
);

desc emp;
select * from emp;

insert into emp(emp_id, ename, gender, hire_date, salary)
values('s001', '홍길동', 'm', now(), 1000);

insert into emp(emp_id, ename, gender, hire_date, salary)
values('s002', '이순신', 'm', sysdate(), 2000);

insert into emp(emp_id, ename, gender, hire_date, salary)
values(2000, 's002', '이순신', 'm', sysdate());

insert into emp(emp_id, ename, gender, hire_date, salary)
values('s002', null , 'm', sysdate(), 2000);

insert into emp
values('s003', '김유신', 'm', curdate(), 3000);

-- [자동 행번호 생성: auto_increment]
-- 정수형으로 번호를 생성하며 저장함, pk(Primary key), unique 제약으로 정정된 컬럼에 주로 사용
create table emp2(
	emp_id	int		auto_increment primary key, -- unique + not null
	ename	varchar(10) 	not null,
    gender char(1) 			not null,
    hire_date				date,
    salary					int
    );
    
show tables;
desc emp2;
insert into emp2(ename, gender, hire_date, salary)
values ('홍길동', 'm', now(), 1000);

/********************************
	데이터 변경: alter table
    형식> 	alter table [테이블명]
			 add column (새로추가하는 컬렴명) [데이터타입] null 허용
             modify column [변경하는 컬러몀], 크기 고려
             drop column [삭제하는 컬럼명]
********************************/
show tables;
select * from emp;

-- phone(char,13) 컬럼 추가, null 허용
alter table emp
	add column phone char(13) null;
desc emp;
select * from emp;

insert into emp
	values('s004', '홍홍', 'f', now(), 4000, '010-1234-1234');

-- phone 컬럼의 크기 변경: char(13) --> char(10)
alter table emp
	modify column phone char(10) null; -- 저장된 데이터 보다 크기가 작으면 에러발생; 데이터 유실 위험 발생

-- phone 컬럼 삭제
alter table emp
	drop column phone;
    
/********************************
	데이터 수정(update: u)
    형식> update [테이블명]
			set [컬럼리스트...]
			where [조건절~]
	** 주의사항: set sql_safe_updates = 1 or 0;
    -- 1: 업데이트 불가, 0: 업데이트 가능
********************************/
select * from emp;
set sql_safe_updates = 0; -- 업데이트 모드 해제
-- 홍길동의 급여를 6000으로 수정
update emp
	set salary = 6000
    where emp_id = 's001';

-- 김유신의 입사날짜를 '20210725'로 수정
update emp
	set hire_date = cast('20210724' as datetime)
	where emp_id = 's003';
    
-- emp2 테이블에 retire_date 컬럼 추가: date, null 허용
-- 기존 데이터는 현재 날짜로 수정
-- 업데이트 완료 후 retire_date not null 로 변경
select * from emp2;
alter table emp2
	add column retire_date date null;
    
update emp2
	set retire_date = curdate()
    where retire_date is null;

alter table emp2
	modify column retire_date date not null;
    
/********************************
	데이터 삭제(delete :D)
    형식> delete from [테이블명]
			where [조건절~]
	** 주의사항: set sql_safe_updates = 1 or 0;
    -- 1: 업데이트 불가, 0: 업데이트 가능
********************************/
select * from emp;

-- 이순신 사원 삭제
delete from emp
	where emp_id = 's002';

-- 홍홍 사원 삭제
delete from emp
	where emp_id = 's004';

rollback;

/********************************
	constraint(제약사항) : 데이터의 무결성 원칙을 적용하기 위한 규칙
    - unique(유니크 제약) : 중복 방지 제약
    - not null: null 값을 허용하지 않는 제약 :: 화면 구현시 유효성 체크 로직과 연동
    - primary key(기본키) : unique + not null
    - foreigh key(참조키) : 타 테이블의 기본키를 참조하는 컬럼 설정,
							참조하는 기본키의 데이터 타입과 동일함
	- default : 데이터 입력 시 기본으로 저장되는 값 설정
    ** 제약사항은 테이블 생성 시 정의 가능함, 또는 테이블 수정으로도 변경, 추가 가능
    - create table ... , alt table ...
********************************/
use hrdb2019;
select database();
select * from information_schema.table_constraints
where table_schema = 'hrdb2019';

desc employee;
desc department;

-- 테이블 생성: emp_const
create table emp_const(
	emp_id		char(4)		primary key, -- 유니크, not null
	emp_name	varchar(10)	not null,
    hire_date	date,
    salary		int
);
show tables;
desc emp_const;
insert into emp_const(emp_id, emp_name, hire_date, salary)
	values('s002', '홍길동', curdate(), 1000);

insert into emp_const(emp_id, emp_name, hire_date, salary)
	values('s003', '이순신', null, null); -- 뒤의 null 값 컬럼들은 생략할 수 있지만 유지보수를 위해 null로 맵핑되는 데이터를 넣어주는것이 좋다
select * from emp_const;

desc emp_const;

-- 테이블 생성 : emp_const2
create table emp_const2(
	emp_id		char(5),
    emp_name	varchar(10)		not null,
    hire_date	date,
    salary		int,
    constraint pk_emp_const2	primary key(emp_id)
);

select * from information_schema.table_constraints
where table_name = 'emp_const2';

insert into emp_const2(emp_id, emp_name, hire_date, salary)
values('s001', '홍길동', now(), 1000);
select * from emp_const2;

-- emp_const2 컬럼 추가: phone, char(13) 컬럼추가
desc emp_const2;
select * from emp_const2;

alter table emp_const2
	add column phone char(13) null;

-- 홍길동의 폰 번호 업데이트 후, phone 컬럼을 not null 수정
update emp_const2
	set phone = '010-1234-5678'
	where emp_id = 's001';

alter table emp_const2
	modify column phone char(13) not null;
desc emp_const2;

-- phone 컬럼에 unique 제약 추가, 중복된 데이터 확인, null도 가능(단, 1개 값만 - 중복X)
alter table emp_const2
	add constraint uni_phone unique(phone);

select * from information_schema.table_constraints
	where table_name = 'emp_const2';
    
-- phone 컬럼에 unique 제약 삭제
alter table emp_const2
	drop constraint uni_phone;

-- emp 테이블 삭제
show tables;
drop table emp;
drop table emp2;

-- department 테이블의 복사본: dept
-- employee 테이블의 복사본: emp
create table dept
as
select * from department
	where unit_id is not null;
    
    

show tables;
desc dept;

select * from dept;
-- dept_id 컬럼에 primary key 제약 추가
alter table dept
	add constraint pk_dept_id primary key(dept_id);
select * from information_schema.table_constraints
	where table_name ='dept';
    
-- 2018년도에 입사한 사원들만 복제
create table emp
as
select * from employee
where left(hire_date, 4) = '2018';

show tables;
desc emp;

-- emp 테이블 제약사항 추가, primary key(emp_id)
alter table emp
	add constraint pk_emp_id primary key(emp_id);
    
-- foreign key(dept_id) 참조키 제약 추가
alter table emp
	add constraint fk_dept_id foreign key(dept_id)
		references dept(dept_id);
        
select * from emp;
-- 고소해 부서이동 --> ACC
update emp
	set dept_id = 'ACC'
    where emp_id = 'S0020';
    
-- 홍길동 사원 추가
desc emp;
insert into emp(emp_id, emp_name, eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary)
values('S0001', '홍길동', null, 'M', curdate(), null, 'HRD', '010-1234-2345', 'hong@test.com', null);

insert into emp(emp_id, emp_name, eng_name, gender, hire_date, retire_date, dept_id, phone, email, salary)
values('S0002', '홍길동', null, 'M', curdate(), null, 'ABC', '010-1234-2345', 'hong@test.com', null);

select * from emp;


/*
[학사관리 시스템 설계]
1. 과목(SUBJECT) 테이블은 
	컬럼 : SID(과목아이디), SNAME(과목명), SDATE(등록일:년월일 시분초)
    SID는 기본키, 자동으로 생성한다.
2. 학생(STUDENT) 테이블은 반드시 하나이상의 과목을 수강해야 한다. 
	컬럼 : STID(학생아이디) 기본키, 자동생성
		SNAME(학생명) 널허용x,
		GENDER(성별)  문자1자 널허용x,
		SID(과목아이디),
		STDATE(등록일자) 년월일 시분초
3. 교수(PROFESSOR) 테이블은 반드시 하나이상의 과목을 강의해야 한다.
	컬럼 : PID(교수아이디) 기본키, 자동생성
		NAME(교수명) 널허용x
		SID(과목아이디),
		PDATE(등록일자) 년월일 시분초
*/

create table subject(
	sid			int auto_increment primary key,
    sname		varchar(10) not null,
    sdate		datetime
);
select * from subject;

create table student (
	stid		int auto_increment primary key,
    sname		varchar(5) not null,
    gender		char(1) not null,
    sid			int,
    stdate		datetime,
    constraint fk_sid_student foreign key(sid)
    references subject(sid)
);


create table professor (
	pid			int primary key auto_increment,
    name		varchar(5) not null,
    sid			int,
    pdate		datetime,
    constraint fk_sid_professional foreign key (sid)
    references subject(sid)
);

select * from information_schema.table_constraints
	where table_name in ('subject', 'student', 'professor ');

-- 과목 데이터 추가
insert into subject(sname, sdate) values('java', now());    
insert into subject(sname, sdate) values('mysql', now());  
insert into subject(sname, sdate) values('html', now());  
insert into subject(sname, sdate) values('react', now());  
insert into subject(sname, sdate) values('node', now());  

select * from subject;

-- 학생 데이터 입력
insert into student(sname, gender, sid, stdate)
	values('홍길동', 'm', 1, now());
insert into student(sname, gender, sid, stdate)
	values('이순신', 'm', 3, now());
insert into student(sname, gender, sid, stdate)
	values('김유신', 'm', 3, now());
insert into student(sname, gender, sid, stdate)
	values('박보검', 'm', 4, now());
insert into student(sname, gender, sid, stdate)
	values('아이유', 'f', 4, now());    
select * from student;

-- 교수 데이터 추가
insert into professor(name, sid, pdate) values('스미스', 1, now());
insert into professor(name, sid, pdate) values('홍홍', 3, now());
insert into professor(name, sid, pdate) values('김철수', 4, now());

select * from professor;

-- 홍길동 학생이 수강하는 과목명을 조회
select su.sname
from subject su, student st
where su.sid = st.sid
and st.sname = '홍길동';

select su.sname
from subject su inner join student st
on su. sid = st.sid
where st.sname = '홍길동';

select sname 
from subject 
where sid = (select sid from student where sname = '홍길동');

-- 홍길동 학생이 수강하는 과목명과 학생명을 조회
select su.sname as 과목명, st.sname as 학생명
from subject su, student st
where su.sid = st.sid
and st.sname = '홍길동';

select su.sname as 과목명, st.sname as 학생명
from subject su inner join student st
on su.sid=st.sid
where st.sname='홍길동';

-- 스미스 교수가 강의하는 과목명을 조회
select su.sname
from subject su, professor pr
where su.sid = pr.sid
and pr.name='스미스';

select su.sname
from subject su inner join professor pr
on su.sid = pr.sid
where pr.name = '스미스';

select sname from subject
where sid = (select sid from professor where name = '스미스');

-- java를 가르치는 안중근 교수 추가
insert into professor(name, sid, pdate)
values('안중근', 1, now());

-- java 수업을 강의하는 모든 교수 조회
select p.name
from subject su, professor p
where su.sid = p.sid
and su.sname = 'java';

select p.name
from subject su inner join professor p
on su.sid = p.sid
where su.sname = 'java';


select name from professor
where sid = (select sid from subject where sname = 'java');

-- java 수업을 강의하는 교수와 수강신청한 학생들을 조회
-- 과목 아이디, 과목명, 교수명, 학생명
select su.sid, su.sname, p.name, st.sname
from subject su, student st, professor p
where su.sid=st.sid 
	and su.sid=p.sid
	and su.sname = 'java';
    
select su.sid, su.sname, p.name, st.sname
from subject su inner join professor p on su.sid = p.sid
				inner join student st on su.sid = st.sid
where su.sname = 'java';

-- 김철수 교수가 강의하는 과목을 수강하는 학생 조회
-- 학생명 출력, 서브쿼리
select sname from student
where sid =(select sid from subject
			where sid = (select sid from professor where name = '김철수'));
            
            
select * from student;
-- kor, eng, math 과목 컬럼 추가, decimal(10,2)
alter table student
add column kor decimal(7,2) null;

alter table student
add column eng decimal(7,2) null;

alter table student
add column math decimal(7,2) null;

update student
set kor = '0.0', eng='0.0', math = '0.0'
where kor is null
and eng is null
and math is null;


/*************************************************
회원, 상품, 주문, 주문상세 테이블 생성 및 실습
*************************************************/
create table member(
	member_id	int				primary key		auto_increment,
    name 		varchar(50)		not null,
    email		varchar(100)	unique			not null,
    created_at	datetime		default	current_timestamp
);

create table product (
	product_id	int				primary key		auto_increment,
    name		varchar(100)	not null,
    price		decimal(10,2)	not null,
    stock		int				default 0
);

create table `order`(
	order_id	int				primary key		auto_increment,
    member_id	int,
    order_date	datetime		default current_timestamp,
    status		varchar(20)		default '주문완료',
	constraint	fk_memberid_member		foreign key(member_id)
    references member(member_id)
);

desc `order`;
select * from `order`;

create table orderitem(
	order_item_id	int			primary key		auto_increment,
    order_id		int,
    product_id		int,
    quantity		int			not null,
    unit_price		decimal(10,2)	not null,
    constraint fk_orderid_order			foreign key(order_id)
    references `order`(order_id),
    constraint fk_productid_order		foreign key(product_id)
	references product(product_id)
);

show tables;
select * from member;

insert into member(name, email)
values('홍길동','hong@example.com');

insert into member(name, email)
values('이순신','lee@naver.com');

desc product;
select * from product;
insert into product(name, price)
values('모니터', 1000),
	('키보드', 2000),
	('마우스', 2500);


desc `order`;
select * from `order`;
insert into `order`(member_id, order_date)
values(1, '2024-06-20');

insert into `order`(member_id, order_date)
values(2, '2025-01-25');

insert into `order`(member_id)
values(1);
insert into `order`(member_id)
values(2);

desc orderitem;
insert into orderitem(order_id, product_id, quantity, unit_price)
values(1,1,2,1000);
insert into orderitem(order_id, product_id, quantity, unit_price)
values(2,3,2,2500);
insert into orderitem(order_id, product_id, quantity, unit_price)
values(3,2,1,1500);
insert into orderitem(order_id, product_id, quantity, unit_price)
values(4,2,5,6000);

select * from orderitem;
update orderitem
set order_id = 4
where order_item_id = 4;


-- 홍길동 고객의 고객명, 이메일, 가입날짜, 주문날짜 조회
-- 주문날짜는 년,월,일로만 출력
select m.name, m.email, m.created_at, left(o.order_date,10) as order_date
from member m, `order` o
where m.member_id = o.member_id
and m.name = '홍길동';

select m.name, m.email, m.created_at, left(o.order_date,10) as order_date
from member m inner join `order` o
on m.member_id=o.member_id
where m.name = '홍길동';

-- 상품 별 주문 건수
-- 상품명, 주문건수 출력
select p.name, count(*) as count
from product p, orderitem oi
where p.product_id = oi.product_id
group by p.name
order by count;

select p.name, count(*) as count
from product p inner join orderitem oi
on p.product_id = oi.product_id
group by p.name
order by count;

insert into product(name, price)
values('리모컨',3000),
		('USB', 2000);

select * from product;

-- 상품 별 주문 건수(수량기준), 모든 상품 조회
select p.name, count(quantity) as count
from product p left outer join orderitem oi
on p.product_id = oi.product_id
group by p.name
order by count desc;

-- 회원이 주문한 내역과 제품명 조회
-- 회원명, 가입날짜, 주문날짜, 주문수량, 제품명, 가격
-- 주문되지 않은 모든 제품 출력
select m.name, m.created_at, o.order_date, oi.quantity, p.name, p.price
from member m, `order` o, orderitem oi, product p
where m.member_id = o.member_id
and o.order_id = oi.order_id
and oi.product_id = p.product_id;

select m.name, m.created_at, o.order_date, oi.quantity, p.name, p.price
from member m inner join `order` o on m.member_id = o.member_id
			  inner join orderitem oi on o.order_id = oi.order_id
              inner join product p on oi.product_id = p.product_id;

select t1.name, t1.created_at, t1.order_date, t1.quantity, p.name, p.price
from (select distinct m.name, m.created_at, o.order_date, oi.quantity, oi.product_id
	from member m, `order` o, orderitem oi, product p
	where m.member_id = o.member_id
	and o.order_id = oi.order_id) t1 right outer join product p
    on t1.product_id = p.product_id;


/********************************************
	행번호, 트리거를 이용한 사원번호 생성
*********************************************/

use hrdb2019;
select database();

-- 사원테이블의 사번, 사원명, 입사일, 폰번호, 이메일, 급여 조회
select emp_id, emp_name, hire_date, phone, email, salary
from employee;

-- row_number() over(order by 컬럼명 ASC/DESC)
-- 입사일 : 입사년도, 급여: 3자리 구분
select 
	row_number() over(order by emp_id) as rno,
    emp_id, 
    emp_name, 
    concat(left(hire_date, 4), '년') as hire_date,
    phone, 
    email, 
    salary,
	concat(format(salary, 0), '원') as salary
from employee;





-- rno 행번호 추가, 주문날짜(년,월,일), 가격(소수점 생략, 3자리 구분)
select 
	row_number() over() as rno,
    t1.name, 
    t1.created_at, 
    left(t1.order_date, 10) as order_date, 
    t1.quantity, 
    p.name, 
    format(floor(p.price), 0) as price
from (select distinct m.name, m.created_at, o.order_date, oi.quantity, oi.product_id
		from member m, `order` o, orderitem oi
		where m.member_id = o.member_id 
		and o.order_id = oi.order_id) t1 right outer join product p
										on t1.product_id = p.product_id;

-- 석차를 구하는 함수
select 
	-- row_number() over(order by emp_id desc) as rno, 
	rank() over(order by salary desc) as r,
	emp_id, 
    emp_name,
    dept_id,
    salary
from employee;   

-- 트리거 : 프로시저(함수, 메소드)를 호출하는 시작점
select *
from information_schema.triggers;


-- 트리거 실습 테이블
create table trg_member(
	mid		char(5),		-- 'M0001'
    name	varchar(10),
    mdate	date
);
drop table trg_member;

-- tgr_member, mid 컬럼 타입 수정: varchar(10)
alter table trg_member
	modify column mid varchar(10);
desc trg_member;

-- trigger 생성: 여러개의 sql문 포함
/***********************************************************/
delimiter $$
create trigger trg_member_mid
before insert on trg_member -- 테이블명
for each row
begin
declare max_code int; -- 'M0001'

-- 현재 저장된 값 중 가장 큰 값을 가져옴
select ifnull(max(cast(right(mid,4) as unsigned)), 0)
into max_code
from trg_member;

-- 'M0001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자 형식)
-- 왼쪽이 아니라 오른쪽에 0을 붙이고 싶으면 RPAD 사용
set new.mid = concat('M', lpad(max_code +1, 4, '0'));
-- set new.mid = lpad(max_code +1, 5, '0'); 

end $$
delimiter ;
/***********************************************************/


select * from information_schema.triggers;
select * from trg_member;
insert into trg_member(name, mdate)
	values('홍길동', curdate());

set sql_safe_updates =0;
delete from trg_member;
    
    
-- 트리거 삭제
drop trigger trg_member_mid;


--
show tables;
drop table employee_2016;

-- employee 테이블 구조만 복제
desc employee;
create table employee_stru
as 
select * from employee where 1 = 0;

show tables;
desc employee_stru;
select * from employee_stru;

alter table employee_stru
	add constraint pk_emp_id primary key(emp_id);


-- emp_id에 데이터 insert 작업 시 트리거가 실행되도록 생성
-- 'E0001' 형식으로 데이터 추가
/***********************************************************/
delimiter $$
create trigger trg_employee_stru_empid
before insert on employee_stru -- 테이블명
for each row
begin
declare max_code int;

-- 현재 저장된 값 중 가장 큰 값을 가져옴
select ifnull(max(cast(right(emp_id,4) as unsigned)), 0)
into max_code
from employee_stru;

-- 'M0001' 형식으로 아이디 생성, LPAD(값, 크기, 채워지는 문자 형식)
-- 왼쪽이 아니라 오른쪽에 0을 붙이고 싶으면 RPAD 사용
set new.emp_id = concat('E', lpad(max_code+1, 4, '0'));
-- set new.mid = lpad(max_code +1, 5, '0'); 

end $$
delimiter ;
/***********************************************************/
drop trigger trg_employee_stru_empid;

select * from employee_stru;
insert into employee_stru(emp_name, gender, hire_date, dept_id, phone, email, salary)
values('홍길동', 'm', '2016-01-01', 'SYS', '010-1234-5678','hong@example.com', 1000);

insert into employee_stru(emp_name, gender, hire_date, dept_id, phone, email, salary)
values('이순신', 'm', '2016-01-01', 'SYS', '010-1234-5678','hong@example.com', 1000);


-- 참조 관계에 대한 트리거 생성: 참조관계(부모(dept : dept_id) <---> 자식(emp : dept_id))
select * from dept;
select * from emp;

-- ACC 부서 삭제
delete from dept where dept_id = 'ACC'; -- emp의 고소해 사원이 참조중이라 삭제 불가

-- GEN 부서 삭제
delete from dept where dept_id = 'GEN'; -- emp에서 참조하는 사원이 없으므로 삭제 가능

-- 정주고 사원 삭제
delete from emp where emp_id = 'S0019';

-- 1. 참조 관계 설정 시 on delete cascade, on update cascade
-- 부모의 참조컬럼이 삭제되면, 자식의 행이 함께 삭제 됨
-- 뉴스테이블의 기사 컬럼이 삭제되며, 댓글 테이블의 댓글이 함께 삭제
-- 게시판의 게시글 삭제 시 게시글의 댓글이 함께 삭제
create table board(
	bid			int				primary key		auto_increment,
	title		varchar(100)	not null,
    content		longtext,
    bdate		datetime
);

create table reply(
	rid			int				primary key		auto_increment,
    content		varchar(100)	not null,
    bid			int		not null,
    rdate		datetime,
    constraint	fk_reply_bid		foreign key(bid)
    references board(bid)	on delete cascade
							on update cascade
);
desc board;
desc reply;
select * from board;
insert into board(title, content, bdate)
values('test','test',curdate());

select * from reply;
insert into reply(content, bid, rdate)
values('reply test', 1, curdate());

-- bid, 1 삭제
delete from board where bid = 1;






-- 2. 트리거를 사용하여 부모의 참조컬럼 삭제 시 자식의 참조 컬럼 데이터를 null로 변경
-- **** 오라클 DB에서는 트리거 실행 가능
-- **** innoDB 형식의 데이터베이스인 MYSQL, maria는 트리거 실행 불가
-- 이유는 innoDB 형식은 트리거 실행 전 참조관계를 먼저 체크 하여 에러 발생 시킴

/***********************************************************/
-- dept테이블의 row 삭제시(dept_id 컬럼 포함), 참조하는 emp 테이블의 dept_id에 null 값 업데이트
delimiter $$
create trigger trg_dept_dept_id_delete
after delete on dept -- 테이블명
for each row
begin
-- 참조하는 emp 테이블의 dept_id에 null 값 업데이트
update emp
	set dept_id = 'dpt'
    where dept_id = old.dept_id; -- old.dept_id: dept 테이블에서 삭제된 dept_id

end $$
delimiter ;
/***********************************************************/
drop trigger trg_dept_dept_id_delete;

select * from information_schema.triggers;
select * from dept;
select * from emp;
-- emp 테이블의 dept_id 컬럼 null 허용으로 변경

alter table emp
	modify column dept_id char(3) null;
    
delete from dept where dept_id = 'ACC';

create table salary_log(
	emp_id		char(5) primary key,
	old_salary	int,
    new_salary	int,
    change_date	date
);

desc salary_log;
select * from information_schema.triggers;
select * from salary_log;
update employee set salary = 9000
where emp_id = 'S0020';
/***********************************************************/
delimiter $$
create trigger trg_salary_update
after update on employee -- 테이블명
for each row
begin
-- 사원 테이블의 급여 변경 시 로그 저장, old.salary
	if old.salary <> new.salary then
		-- 로그 저장
        insert into salary_log(emp_id, old_salary, new_salary, change_date)
        values(old.emp_id, old.salary, new.salary, now());
    end if;

end $$
/***********************************************************/
