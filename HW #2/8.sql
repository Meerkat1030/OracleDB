select movietitle
from starsin,movie
where movietitle = title and movieyear = year and 
                  (starname,length) in (select a.name,max(length)
                                        from moviestar a,starsin,movie
                                        where a.birthdate in (select min(birthdate)
                                                              from moviestar)and
                                                              starname = name and movietitle = title and movieyear = year
                                        group by a.name);