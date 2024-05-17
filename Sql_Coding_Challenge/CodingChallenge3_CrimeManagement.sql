-- Create tables
CREATE TABLE Crime (
CrimeID INT PRIMARY KEY,
IncidentType VARCHAR(255),
IncidentDate DATE,
Location VARCHAR(255),
Description TEXT,
Status VARCHAR(20)
);

CREATE TABLE Victim (
VictimID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255),
ContactInfo VARCHAR(255),
Injuries VARCHAR(255),
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

CREATE TABLE Suspect (
SuspectID INT PRIMARY KEY,
CrimeID INT,
Name VARCHAR(255),
Description TEXT,
CriminalHistory TEXT,
FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);

select * from crime;
select * from victim;
select * from suspect;

alter table victim add age int;
alter table suspect add age int;

update victim set age=40 where victimid=1;
update victim set age=30 where victimid=2;
update victim set age=20 where victimid=3;

update suspect set age=20 where suspectid=1;
update suspect set age=30 where suspectid=2;
update suspect set age=40 where suspectid=3;
       
-- Insert sample data
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate, Location, Description, Status)
VALUES
(1, 'Robbery', '2023-09-15', '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
(2, 'Homicide', '2023-09-20', '456 Elm St, Townsville', 'Investigation into a murder case', 'Under
Investigation'),
(3, 'Theft', '2023-09-10', '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');

INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries)
VALUES
(1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries'),
(2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased'),
(3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None');

INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory)
VALUES
(1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions'),
(2, 2, 'Unknown', 'Investigation ongoing', NULL),
(3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests');

-- 1. Select all open incidents.
select * from crime where status = 'open';

-- 2. Find the total number of incidents.
select count(*) from crime;

-- 3. List all unique incident types.
select distinct incidenttype from crime;

-- 4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
select * from crime where incidentdate between '2023-09-01' and '2023-09-10';

-- 5. List persons involved in incidents in descending order of age.
Select distinct name, age
from victim
order by age desc;

-- 6. Find the average age of persons involved in incidents.
select avg(age) 
from victim;

-- 7. List incident types and their counts, only for open cases.
select incidenttype, count(*) 
from crime where status = 'open' 
group by incidenttype;

-- 8. Find persons with names containing 'Doe'.
select name from victim where name like '%doe%';

-- 9. Retrieve the names of persons involved in open cases and closed cases.
select distinct v.Name 
from Victim v
inner join Crime c on v.CrimeID = c.CrimeID
where c.Status = 'Open' or c.Status = 'Closed';

-- 10. List incident types where there are persons aged 30 or 35 involved.
select distinct c.IncidentType 
from Crime c
inner join Victim v on c.CrimeID = v.CrimeID
inner join Suspect s on c.CrimeID = s.CrimeID
where v.Age in (30, 35) or s.Age in (30, 35);

-- 11. Find persons involved in incidents of the same type as 'Robbery'.
select Name 
from Victim 
where CrimeID in (
    select CrimeID 
    from Crime 
    where IncidentType = 'Robbery'
);

-- 12. List incident types with more than one open case.
select IncidentType 
from Crime 
where Status = 'Open' 
group by IncidentType 
having count(*) > 1;

-- 13. List all incidents with suspects whose names also appear as victims in other incidents.
select * 
from crime 
where crimeId in 
    (select crimeId 
    from suspect 
    where name in 
    (select name 
	from victim ) );

-- 14. Retrieve all incidents along with victim and suspect details.
select * 
from crime 
left join victim on crime.CrimeID = victim.CrimeID 
left join suspect on crime.CrimeID = suspect.CrimeID;

-- 15. Find incidents where the suspect is older than any victim.
select c.*
from crime c
inner join victim v on c.CrimeID = v.CrimeID
inner join suspect s on c.CrimeID = s.CrimeID
where s.age > (
    select max(age) from victim where CrimeID = c.CrimeID
);

-- 16. Find suspects involved in multiple incidents.
select suspectid,name
from suspect
group by suspectid
having count(distinct crimeid) > 1;

-- 17. List incidents with no suspects involved.
select *
from crime
where crimeid not in (select crimeid from suspect);

-- 18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'.
select c1.*
from crime c1
join crime c2 on c1.crimeid = c2.crimeid
where c1.incidenttype = 'homicide'
or c2.incidenttype = 'robbery';

-- 19. Retrieve a list of all incidents and the associated suspects, showing suspects for each incident, or 'No Suspect' if there are none
select c.*, case when s.name is null then 'no suspect' else s.name end 
as suspect_name 
from crime c 
left join suspect s 
on c.crimeid = s.crimeid;

-- 20. List all suspects who have been involved in incidents with incident types 'Robbery' or 'Assault'.
select * 
from suspect 
where crimeid in (
    select crimeid 
    from crime 
    where incidenttype in ('robbery', 'assault')
);
