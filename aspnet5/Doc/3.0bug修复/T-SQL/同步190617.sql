

-- 成员表总分核算

UPDATE members ,(select  SUM(integral)  TotalIntegral,mem.id
		FROM	 integrals ,members mem
		where  integrals.MemberId  =mem.id
GROUP BY mem.id)  temptotal

SET members.TotalIntegral =temptotal .TotalIntegral
WHERE members.Id=temptotal.id;



-- 年度积分核算
UPDATE annualintegrals ,(select  SUM(integral) TotalIntegral ,mem.id,YEAR(integrals.CreatedTime) yearseg
		FROM	 integrals ,members mem
		where  integrals.MemberId  =mem.id
GROUP BY mem.id,yearseg
)  temptotal

SET annualintegrals.AnnualIntegral =temptotal .TotalIntegral
WHERE annualintegrals.MemberId=temptotal.id
	AND annualintegrals.Years=temptotal.yearseg;