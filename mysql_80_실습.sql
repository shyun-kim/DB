/**
* mysql 실습
*/


/********************************
	DESC(DESCRIBE) : 테이블 구조 확인
    형식> desc(describe) [테이블명];
********************************/


show tables;
desc employee;
desc department
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

-- SYS부서의 속한 모든 사원을 조회
select * from employee where dept_id = 'SYS';

